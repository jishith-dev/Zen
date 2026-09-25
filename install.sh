#!/usr/bin/env bash
#
# Zen language installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Jishith-dev/Zen/<branch>/install.sh | bash -s -- [options]
#   ./install.sh [options]
#
# Options:
#   --tag <tag>       Git tag/ref to install (default: latest release tag)
#   --branch <name>   Install from a branch instead of a tag (uses latest commit, no VERSION check)
#   --prefix <dir>    Install prefix for the `zen` symlink (default: $HOME/.local/bin
#                      or $PREFIX/bin if $PREFIX is set)
#   --force           Reinstall even if the target ref is already installed
#   -y, --yes         Assume "yes" to all prompts (non-interactive / CI mode).
#                      All necessary dependencies (including a correct LLVM) are
#                      installed automatically with no further prompts.
#   --no-rc-edit      Don't attempt to modify shell rc files to add PATH
#   -h, --help        Show this help text
#
# Env vars:
#   ZEN_REPO          Override the git repository URL
#   ZEN_INSTALL_DIR   Override the install directory (default: $HOME/.zen)

HELP_TEXT="
Usage:
  curl -fsSL https://raw.githubusercontent.com/Jishith-dev/Zen/<branch>/install.sh | bash -s -- [options]
  ./install.sh [options]

Options:
  --tag <tag>       Git tag/ref to install (default: latest release tag)
  --branch <name>   Install from a branch instead of a tag (uses latest commit, no VERSION check)
  --prefix <dir>    Install prefix for the zen symlink (default: \$HOME/.local/bin or \$PREFIX/bin)
  --force           Reinstall even if the target ref is already installed
  -y, --yes         Assume yes to all prompts (non-interactive / CI mode).
                     All necessary dependencies (including a correct LLVM) are
                     installed automatically with no further prompts.
  --no-rc-edit      Don't attempt to modify shell rc files to add PATH
  -h, --help        Show this help text

Env vars:
  ZEN_REPO          Override the git repository URL
  ZEN_INSTALL_DIR   Override the install directory (default: \$HOME/.zen)
"

set -Eeuo pipefail
IFS=$'\n\t'

REPO="${ZEN_REPO:-https://github.com/Jishith-dev/Zen.git}"
REF_KIND="tag"          # "tag" or "branch"
REF="${ZEN_REF:-}"
FORCE=0
ASSUME_YES=0
EDIT_RC=1
MIN_LLVM_MAJOR=20        # minimum LLVM major version Zen will accept
AUTO_LLVM_VERSION=21     # version we auto-install / set as default when we control the choice

: "${HOME:?HOME is not set; refusing to continue}"

INSTALL_DIR="${ZEN_INSTALL_DIR:-$HOME/.zen}"
STATE_FILE="$INSTALL_DIR/.install-state"
LOG_FILE="$(mktemp -t zen-install-XXXXXX.log 2>/dev/null || echo "/tmp/zen-install-$$.log")"

CUSTOM_PREFIX="${PREFIX:-}"

REQUIRED_DEPS=(git node pkg-config)

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; RESET='\033[0m'

_log_raw() { echo -e "$*" | tee -a "$LOG_FILE" >&2; }
info()    { _log_raw "${CYAN}[zen]${RESET} $*"; }
success() { _log_raw "${GREEN}[zen]${RESET} $*"; }
warn()    { _log_raw "${YELLOW}[zen]${RESET} $*"; }
error()   { _log_raw "${RED}[zen] error:${RESET} $*"; }
die()     { error "$*"; exit 1; }

# retry <max_attempts> <command...>
# Runs a command, retrying with exponential backoff on failure.
# Never triggers `set -e` itself -- callers combine it with `|| die "..."`.
retry() {
  local max_attempts="$1"; shift
  local attempt=1
  local delay=2
  local ec=0
  until "$@"; do
    ec=$?
    if [ "$attempt" -ge "$max_attempts" ]; then
      return "$ec"
    fi
    warn "Command failed (attempt $attempt/$max_attempts, exit $ec): $* -- retrying in ${delay}s..."
    sleep "$delay"
    attempt=$((attempt + 1))
    delay=$((delay * 2))
  done
  return 0
}

info "Log file: $LOG_FILE"

TMP_CLONE_DIR=""
INSTALL_SUCCEEDED=0

cleanup() {
  local exit_code=$?
  if [ -n "$TMP_CLONE_DIR" ] && [ -d "$TMP_CLONE_DIR" ]; then
    rm -rf "$TMP_CLONE_DIR"
  fi
  if [ "$exit_code" -ne 0 ] && [ "$INSTALL_SUCCEEDED" -ne 1 ]; then
    error "Install failed (exit $exit_code). See log: $LOG_FILE"
    if [ -d "$INSTALL_DIR" ] && [ ! -f "$STATE_FILE" ]; then
      warn "Removing incomplete install directory: $INSTALL_DIR"
      rm -rf "$INSTALL_DIR"
    fi
  fi
}
trap cleanup EXIT
trap 'error "Command failed at line $LINENO. Re-run this script to retry -- it is safe to run multiple times. Full log: $LOG_FILE"' ERR

while [ $# -gt 0 ]; do
  case "$1" in
    --tag)        REF_KIND="tag";    REF="${2:?--tag requires a value}"; shift 2 ;;
    --branch)     REF_KIND="branch"; REF="${2:?--branch requires a value}"; shift 2 ;;
    --prefix)     CUSTOM_PREFIX="${2:?--prefix requires a value}"; shift 2 ;;
    --force)      FORCE=1; shift ;;
    -y|--yes)     ASSUME_YES=1; shift ;;
    --no-rc-edit) EDIT_RC=0; shift ;;
    -h|--help)    echo "$HELP_TEXT"; exit 0 ;;
    *) die "Unknown option: $1 (use --help)" ;;
  esac
done

confirm() {
  local prompt="$1"
  [ "$ASSUME_YES" -eq 1 ] && return 0
  if [ ! -t 0 ]; then
    warn "Non-interactive shell and no -y given; assuming 'no' for: $prompt"
    return 1
  fi
  read -r -p "$prompt [y/N] " answer < /dev/tty
  case "$answer" in
    y|Y|yes|YES|Yes) return 0 ;;
    *) return 1 ;;
  esac
}

detect_os() {
  case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
    Darwin)               echo "macos" ;;
    Linux)
      if [ -n "${TERMUX_VERSION:-}" ] || [ -d "/data/data/com.termux" ]; then
        echo "android"
      else
        echo "linux"
      fi
      ;;
    *) echo "unknown" ;;
  esac
}

TARGET_OS="$(detect_os)"
info "Detected OS: $TARGET_OS"

[ "$TARGET_OS" = "unknown" ] && die "Unsupported operating system: $(uname -s)"

if [ "$TARGET_OS" = "windows" ]; then
  warn "Running on native Windows. Automatic dependency installation here is best-effort (via winget/choco if available)."
  warn "Required either way: git, Node.js, LLVM $MIN_LLVM_MAJOR+ (clang, llc, opt on PATH), pkg-config, libcurl dev headers."
  warn "For a fully automatic, well-tested install, consider running this script under WSL instead."
fi

check_dep() { command -v "$1" >/dev/null 2>&1; }

install_llvm_apt() {
  local ver="$1"
  info "Installing LLVM $ver via apt.llvm.org..."
  retry 3 wget -qO /tmp/llvm.sh https://apt.llvm.org/llvm.sh \
    || die "Failed to download the apt.llvm.org install script after multiple attempts. Check your network connection and re-run this script (it is safe to re-run)."
  chmod +x /tmp/llvm.sh
  retry 2 sudo /tmp/llvm.sh "$ver" all \
    || die "Failed to install LLVM $ver via apt.llvm.org after multiple attempts. See log: $LOG_FILE -- you can re-run this script to retry."
  local tool
  for tool in clang llc opt llvm-config; do
    if [ -x "/usr/bin/${tool}-${ver}" ]; then
      sudo update-alternatives --install "/usr/bin/${tool}" "$tool" "/usr/bin/${tool}-${ver}" 100
      sudo update-alternatives --set "$tool" "/usr/bin/${tool}-${ver}"
    else
      warn "/usr/bin/${tool}-${ver} not found after install; ${tool} may be unavailable."
    fi
  done
  rm -f /tmp/llvm.sh
  export PATH="/usr/lib/llvm-${ver}/bin:$PATH"
  success "LLVM $ver installed and set as the default clang/llc/opt."
}

install_deps() {
  case "$TARGET_OS" in
    linux)
      if command -v apt-get >/dev/null 2>&1; then
        info "Using APT."
        retry 3 sudo apt-get update \
          || die "apt-get update failed after multiple attempts. Check your network/proxy settings and re-run this script."
        retry 3 sudo apt-get install -y git nodejs pkg-config libcurl4-openssl-dev gnupg wget \
          || die "apt-get install failed after multiple attempts. See log: $LOG_FILE -- re-run this script to retry."
        install_llvm_apt "$AUTO_LLVM_VERSION"
      elif command -v pacman >/dev/null 2>&1; then
        info "Using Pacman."
        retry 3 sudo pacman -Sy --needed git nodejs clang llvm pkgconf curl gnupg \
          || die "pacman install failed after multiple attempts. Re-run this script to retry."
      elif command -v dnf >/dev/null 2>&1; then
        info "Using DNF."
        retry 3 sudo dnf install -y git nodejs clang llvm pkgconf-pkg-config libcurl-devel gnupg2 \
          || die "dnf install failed after multiple attempts. Re-run this script to retry."
      elif command -v zypper >/dev/null 2>&1; then
        info "Using Zypper."
        retry 3 sudo zypper install -y git nodejs clang llvm pkg-config libcurl-devel gpg2 \
          || die "zypper install failed after multiple attempts. Re-run this script to retry."
      else
        die "No supported Linux package manager found. Install manually: git nodejs clang llvm pkg-config libcurl-dev gnupg"
      fi
      ;;
    android)
      info "Using Termux (pkg)."
      retry 3 pkg update \
        || die "pkg update failed after multiple attempts. Check your network connection and re-run this script."
      retry 3 pkg install -y git nodejs clang llvm pkg-config libcurl gnupg \
        || die "pkg install failed after multiple attempts. Re-run this script to retry."
      ;;
    macos)
      check_dep brew || die "Homebrew is not installed. Install it from https://brew.sh, then re-run this script."
      info "Using Homebrew."
      retry 3 brew install git node llvm curl pkg-config gnupg \
        || die "brew install failed after multiple attempts. Re-run this script to retry."
      ;;
    windows)
      if command -v choco >/dev/null 2>&1; then
        info "Using Chocolatey (best-effort)."
        retry 2 choco install -y git nodejs llvm \
          || warn "Chocolatey install reported errors. Verify git/node/clang/llc/opt manually before continuing."
      elif command -v winget >/dev/null 2>&1; then
        info "Using winget (best-effort)."
        winget install --id Git.Git -e --silent || warn "winget could not install Git; install it manually."
        winget install --id OpenJS.NodeJS -e --silent || warn "winget could not install Node.js; install it manually."
        winget install --id LLVM.LLVM -e --silent || warn "winget could not install LLVM; install it manually."
      else
        die "No supported package manager found (choco/winget). Install git, Node.js, LLVM $MIN_LLVM_MAJOR+, and libcurl dev headers manually, or run this script under WSL for full automatic support."
      fi
      ;;
  esac
}

missing=()
for dep in "${REQUIRED_DEPS[@]}" clang llc; do
  check_dep "$dep" || missing+=("$dep")
done

if [ ${#missing[@]} -ne 0 ]; then
  warn "Missing dependencies: ${missing[*]}"
  if confirm "Install the required dependencies automatically?"; then
    install_deps
    missing=()
    for dep in "${REQUIRED_DEPS[@]}" clang llc; do
      check_dep "$dep" || missing+=("$dep")
    done
    [ ${#missing[@]} -eq 0 ] || die "Still missing after automatic install: ${missing[*]}. Install them manually and re-run this script."
  else
    die "Cannot continue without: ${missing[*]}. Install them and re-run."
  fi
fi

info "Checking LLVM version..."

LLC_VERSION_RAW="$(llc --version 2>/dev/null | grep -m1 -oE 'LLVM version [0-9]+\.[0-9]+\.[0-9]+' || true)"
[ -n "$LLC_VERSION_RAW" ] || die "Unable to determine LLVM version from 'llc --version'. Ensure LLVM $MIN_LLVM_MAJOR+ is installed and on PATH, then re-run this script."

LLC_VERSION_FULL="${LLC_VERSION_RAW##* }"
LLC_MAJOR="${LLC_VERSION_FULL%%.*}"

case "$LLC_MAJOR" in
  ''|*[!0-9]*) die "Could not parse a numeric LLVM major version from: $LLC_VERSION_RAW" ;;
esac

if [ "$LLC_MAJOR" -lt "$MIN_LLVM_MAJOR" ] || [ "$LLC_MAJOR" -gt 30 ]; then
  warn "LLVM $LLC_VERSION_FULL detected; Zen requires LLVM >= $MIN_LLVM_MAJOR (tested up to 30)."
  if [ "$TARGET_OS" = "linux" ] && command -v apt-get >/dev/null 2>&1 && confirm "Install LLVM $AUTO_LLVM_VERSION via apt.llvm.org and set it as default?"; then
    install_llvm_apt "$AUTO_LLVM_VERSION"
    LLC_VERSION_RAW="$(llc --version 2>/dev/null | grep -m1 -oE 'LLVM version [0-9]+\.[0-9]+\.[0-9]+' || true)"
    [ -n "$LLC_VERSION_RAW" ] || die "Unable to determine LLVM version after install. Re-run this script to retry."
    LLC_VERSION_FULL="${LLC_VERSION_RAW##* }"
    LLC_MAJOR="${LLC_VERSION_FULL%%.*}"
    [ "$LLC_MAJOR" -ge "$MIN_LLVM_MAJOR" ] || die "LLVM install did not produce a supported version (got $LLC_VERSION_FULL). Re-run this script to retry, or install LLVM $MIN_LLVM_MAJOR+ manually."
  else
    die "LLVM $LLC_VERSION_FULL detected; Zen requires LLVM >= $MIN_LLVM_MAJOR (tested up to 30). Install a supported version (LLVM $AUTO_LLVM_VERSION recommended) and re-run."
  fi
fi

success "LLVM $LLC_VERSION_FULL detected (compatible)."

info "Checking for libcurl..."
pkg-config --exists libcurl 2>/dev/null || die "libcurl development files not found. Install them (e.g. libcurl4-openssl-dev / libcurl-devel) and re-run this script."
CURL_CFLAGS="$(pkg-config --cflags libcurl)"
success "libcurl found."

if [ -z "$REF" ] && [ "$REF_KIND" = "tag" ]; then
  info "Resolving latest release tag..."
  LATEST_TAG="$(retry 3 git ls-remote --tags --refs "$REPO" \
    | awk '{print $2}' \
    | sed 's#refs/tags/##' \
    | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' \
    | sort -V \
    | tail -n1 || true)"
  [ -n "$LATEST_TAG" ] || die "Could not resolve a release tag from $REPO. Check your network connection, or pass --tag <tag> / --branch <name> explicitly."
  REF="$LATEST_TAG"
fi

if [ "$REF_KIND" = "branch" ]; then
  warn "Installing from branch '$REF' -- unpinned, tracks the latest commit."
  confirm "Continue installing from branch '$REF'?" || die "Aborted by user."
fi

info "Target ref: $REF ($REF_KIND)"

if [ -f "$STATE_FILE" ] && [ "$FORCE" -ne 1 ]; then
  INSTALLED_REF="$(grep -m1 '^ref=' "$STATE_FILE" 2>/dev/null | cut -d= -f2- || true)"
  if [ "$REF_KIND" = "tag" ] && [ "$INSTALLED_REF" = "$REF" ]; then
    success "Zen ($REF) is already installed at $INSTALL_DIR. Use --force to reinstall."
    INSTALL_SUCCEEDED=1
    exit 0
  fi
fi

TMP_CLONE_DIR="$(mktemp -d "${TMPDIR:-/tmp}/zen-clone-XXXXXX")"

info "Cloning $REPO @ $REF into a staging directory..."
retry 3 git clone --quiet --branch "$REF" --depth 1 "$REPO" "$TMP_CLONE_DIR" \
  || die "Failed to clone $REPO at ref '$REF' after multiple attempts. Check that the ref exists and your network connection, then re-run this script."

cd "$TMP_CLONE_DIR"
RESOLVED_COMMIT="$(git rev-parse HEAD)"
info "Resolved commit: $RESOLVED_COMMIT"

if [ "$REF_KIND" = "tag" ]; then
  TAG_VERIFY_LOG="$(mktemp "${TMPDIR:-/tmp}/zen-tag-verify-XXXXXX" 2>/dev/null || mktemp)"
  if git tag -v "$REF" >"$TAG_VERIFY_LOG" 2>&1; then
    success "Tag signature verified for $REF."
  else
    warn "Could not cryptographically verify tag '$REF' (unsigned tag or key not in local keyring)."
    warn "Proceeding on trust of the resolved commit hash: $RESOLVED_COMMIT"
  fi
  rm -f "$TAG_VERIFY_LOG"
fi

if [ "$REF_KIND" = "tag" ]; then
  [ -f VERSION ] || die "VERSION file not found in repository."
  ZEN_VERSION="$(cat VERSION)"
  [ -n "$ZEN_VERSION" ] || die "VERSION file is empty."
else
  ZEN_VERSION="${RESOLVED_COMMIT:0:7}"
  [ -f VERSION ] && info "VERSION file says $(cat VERSION); using branch commit $ZEN_VERSION instead."
fi

info "Installing Zen v$ZEN_VERSION ($REF)..."

if [ -f SHA256SUMS ]; then
  info "Verifying source checksums..."
  sha256sum -c SHA256SUMS --quiet \
    || die "Checksum verification failed against SHA256SUMS. Refusing to build untrusted source."
  success "Checksums verified."
else
  warn "No SHA256SUMS manifest found in this ref; skipping checksum verification."
fi

compile_ll() {
  local src="$1" out="$2"
  [ -f "$src" ] || die "Source not found: $src"
  llc -filetype=obj -relocation-model=pic "$src" -o "$out" || die "Failed to compile: $src"
}

compile_c() {
  local src="$1" out="$2"
  [ -f "$src" ] || die "Source not found: $src"
  clang -c -fPIC "$src" -o "$out" || die "Failed to compile: $src"
}

compile_c_curl() {
  local src="$1" out="$2"
  [ -f "$src" ] || die "Source not found: $src"
  # shellcheck disable=SC2086
  clang -c -fPIC $CURL_CFLAGS "$src" -o "$out" || die "Failed to compile: $src"
}

info "Building stdlib..."
compile_ll src/zen_stdlib/constants.ll        src/zen_stdlib/constants.o
compile_ll src/zen_stdlib/zen_stdlib_opt.ll   src/zen_stdlib/zen_stdlib_opt.o

info "Building runtime..."
if [ "$TARGET_OS" = "windows" ]; then
  RUNTIME_SRC="src/codegen/runtime/w_runtime.c"
else
  RUNTIME_SRC="src/codegen/runtime/runtime.c"
fi

compile_c      "$RUNTIME_SRC"                              src/codegen/runtime/runtime.o
compile_c      src/codegen/runtime/listRuntime.c           src/codegen/runtime/listRuntime.o
compile_c      src/codegen/runtime/jsonRuntime.c           src/codegen/runtime/jsonRuntime.o
compile_c      src/codegen/runtime/mapRuntime.c            src/codegen/runtime/mapRuntime.o
compile_c      src/codegen/runtime/httpRuntime.c           src/codegen/runtime/httpRuntime.o
compile_c_curl src/codegen/runtime/curlRuntime.c           src/codegen/runtime/curlRuntime.o
compile_c_curl src/codegen/runtime/tcp.c                   src/codegen/runtime/tcp.o

info "Verifying build artifacts..."
ARTIFACTS=(
  src/zen_stdlib/constants.o
  src/zen_stdlib/zen_stdlib_opt.o
  src/codegen/runtime/runtime.o
  src/codegen/runtime/listRuntime.o
  src/codegen/runtime/mapRuntime.o
  src/codegen/runtime/curlRuntime.o
  src/codegen/runtime/httpRuntime.o
  src/codegen/runtime/jsonRuntime.o
  src/codegen/runtime/tcp.o
)
for f in "${ARTIFACTS[@]}"; do
  [ -f "$f" ] || die "Missing artifact after build: $f"
done
success "All artifacts verified."

chmod +x bin/zen.js

info "Finalizing install directory: $INSTALL_DIR"
BACKUP_DIR=""
if [ -d "$INSTALL_DIR" ]; then
  BACKUP_DIR="${INSTALL_DIR}.bak.$(date +%s)"
  mv "$INSTALL_DIR" "$BACKUP_DIR"
fi

mv "$TMP_CLONE_DIR" "$INSTALL_DIR"
TMP_CLONE_DIR=""

[ -n "$BACKUP_DIR" ] && rm -rf "$BACKUP_DIR"

cat > "$STATE_FILE" <<EOF
ref=$REF
ref_kind=$REF_KIND
version=$ZEN_VERSION
commit=$RESOLVED_COMMIT
installed_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
os=$TARGET_OS
EOF

if [ -n "$CUSTOM_PREFIX" ] && [ -d "$CUSTOM_PREFIX/bin" ]; then
  BIN_DIR="$CUSTOM_PREFIX/bin"
else
  BIN_DIR="$HOME/.local/bin"
  mkdir -p "$BIN_DIR"
fi

ln -sf "$INSTALL_DIR/bin/zen.js" "$BIN_DIR/zen"
info "Linked zen -> $INSTALL_DIR/bin/zen.js in $BIN_DIR"

PATH_LINE="export PATH=\"$BIN_DIR:\$PATH\""

path_already_set() {
  case ":$PATH:" in
    *":$BIN_DIR:"*) return 0 ;;
    *) return 1 ;;
  esac
}

detect_rc_file() {
  case "${SHELL:-}" in
    */zsh)  echo "$HOME/.zshrc" ;;
    */bash) [ -f "$HOME/.bash_profile" ] && echo "$HOME/.bash_profile" || echo "$HOME/.bashrc" ;;
    *)      echo "$HOME/.profile" ;;
  esac
}

if path_already_set; then
  success "$BIN_DIR is already in PATH."
else
  warn "$BIN_DIR is not in your PATH."
  RC_FILE="$(detect_rc_file)"
  if [ "$EDIT_RC" -eq 1 ] && confirm "Add PATH export to $RC_FILE?"; then
    if [ -f "$RC_FILE" ] && grep -qF "$BIN_DIR" "$RC_FILE" 2>/dev/null; then
      info "$RC_FILE already references $BIN_DIR; not adding a duplicate line."
    else
      {
        echo ""
        echo "# Added by Zen installer on $(date -u +%Y-%m-%d)"
        echo "$PATH_LINE"
      } >> "$RC_FILE"
      success "Added PATH export to $RC_FILE. Restart your shell or run: source $RC_FILE"
    fi
  else
    echo ""
    echo "Add this to your shell config manually:"
    echo ""
    echo "  $PATH_LINE"
    echo ""
  fi
fi

INSTALL_SUCCEEDED=1

echo ""
success "Zen v$ZEN_VERSION installed successfully!"
echo ""
echo "  zen --help"
echo "  zen --version"
echo "  zen run <file>"
echo ""
info "Install log saved to: $LOG_FILE"
