#!/usr/bin/env bash

HELP_TEXT='Usage:
  curl -fsSL https://raw.githubusercontent.com/Jishith-dev/Zen/main/install.sh | bash
  curl -fsSL https://raw.githubusercontent.com/Jishith-dev/Zen/main/install.sh | bash -s -- [options]
  ./install.sh [options]

Options:
  --tag <tag>       Git tag to install (default: latest release tag)
  --branch <name>   Install from a branch instead of a tag (unpinned, no VERSION check)
  --prefix <dir>    Install prefix for the zen symlink (default: $HOME/.local/bin, or $PREFIX/bin on Termux)
  --force           Reinstall even if the target ref is already installed
  -y, --yes         Assume yes to all prompts (non-interactive / CI mode)
  --no-rc-edit      Do not modify shell rc files to add PATH
  -h, --help        Show this help text

Env vars:
  ZEN_REPO          Override the git repository URL
  ZEN_INSTALL_DIR   Override the install directory (default: $HOME/.zen)
  ZEN_PREFIX        Same as --prefix
  ZEN_REF           Same as --tag'

REPO=""
REF_KIND="tag"
REF=""
FORCE=0
ASSUME_YES=0
EDIT_RC=1
MIN_LLVM_MAJOR=20
MAX_LLVM_MAJOR=30
AUTO_LLVM_VERSION=21
INSTALL_DIR=""
STATE_FILE=""
LOG_FILE=""
CUSTOM_PREFIX=""
TARGET_OS=""
SUDO=""
TMP_CLONE_DIR=""
BACKUP_DIR=""
INSTALL_MOVED=0
INSTALL_SUCCEEDED=0
LLVM_BIN_DIR=""
LLC_VERSION_FULL=""
LLC_MAJOR=""
ORIG_PATH="$PATH"
CURL_CFLAGS=()
REQUIRED_DEPS=(git node pkg-config)
missing=()
missing_text=""

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

_log() { printf '%b\n' "$*" | tee -a "$LOG_FILE" >&2; }
info()    { _log "${CYAN}[zen]${RESET} $*"; }
success() { _log "${GREEN}[zen]${RESET} $*"; }
warn()    { _log "${YELLOW}[zen]${RESET} $*"; }
error()   { _log "${RED}[zen] error:${RESET} $*"; }
die()     { error "$*"; exit 1; }

retry() {
  local max_attempts="$1"; shift
  local attempt=1
  local delay=3
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

cleanup() {
  local exit_code=$?
  cd "$HOME" 2>/dev/null || cd / 2>/dev/null || true
  if [ -n "$TMP_CLONE_DIR" ] && [ -d "$TMP_CLONE_DIR" ]; then
    rm -rf "$TMP_CLONE_DIR" || true
  fi
  if [ "$exit_code" -ne 0 ] && [ "$INSTALL_SUCCEEDED" -ne 1 ]; then
    error "Install failed (exit $exit_code). See log: $LOG_FILE"
    if [ -n "$BACKUP_DIR" ] && [ -d "$BACKUP_DIR" ]; then
      warn "Restoring previous install at $INSTALL_DIR"
      rm -rf "$INSTALL_DIR" || true
      mv "$BACKUP_DIR" "$INSTALL_DIR" || true
    elif [ "$INSTALL_MOVED" -eq 1 ]; then
      warn "Removing incomplete install directory: $INSTALL_DIR"
      rm -rf "$INSTALL_DIR" || true
    fi
  fi
}

confirm() {
  local prompt="$1"
  local answer=""
  if [ "$ASSUME_YES" -eq 1 ]; then
    return 0
  fi
  if ! { true </dev/tty; } 2>/dev/null; then
    warn "No terminal available and -y not given; assuming 'no' for: $prompt"
    return 1
  fi
  printf '%s [y/N] ' "$prompt" >/dev/tty
  IFS= read -r answer </dev/tty || answer=""
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

check_dep() { command -v "$1" >/dev/null 2>&1; }

setup_sudo() {
  SUDO=""
  if [ "$(id -u)" -ne 0 ]; then
    check_dep sudo || die "sudo is required to install packages. Install it or run this script as root."
    SUDO="sudo"
    sudo -v || die "sudo authentication failed. Re-run with sudo access, or install the dependencies manually."
  fi
}

apt_run() {
  $SUDO env DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::Lock::Timeout=120 -o Acquire::Retries=3 "$@"
}

install_llvm_apt() {
  local ver="$1"
  local script tool
  setup_sudo
  info "Installing LLVM $ver via apt.llvm.org..."
  script="$(mktemp "${TMPDIR:-/tmp}/zen-llvm-XXXXXX")"
  retry 3 wget -qO "$script" https://apt.llvm.org/llvm.sh \
    || { rm -f "$script"; die "Failed to download the apt.llvm.org install script. Check your network connection and re-run this script."; }
  retry 3 $SUDO bash "$script" "$ver" \
    || { rm -f "$script"; die "Failed to install LLVM $ver via apt.llvm.org. See log: $LOG_FILE -- re-run this script to retry."; }
  rm -f "$script"
  retry 3 apt_run install -y "clang-$ver" "llvm-$ver" \
    || die "Failed to install clang-$ver / llvm-$ver. Re-run this script to retry."
  for tool in clang llc opt llvm-config; do
    if [ -x "/usr/bin/${tool}-${ver}" ]; then
      $SUDO update-alternatives --install "/usr/bin/${tool}" "$tool" "/usr/bin/${tool}-${ver}" 100
      $SUDO update-alternatives --set "$tool" "/usr/bin/${tool}-${ver}"
    else
      warn "/usr/bin/${tool}-${ver} not found after install; ${tool} may be unavailable."
    fi
  done
  export PATH="/usr/lib/llvm-${ver}/bin:$PATH"
  success "LLVM $ver installed and set as the default clang/llc/opt."
}

install_deps() {
  case "$TARGET_OS" in
    linux)
      setup_sudo
      if check_dep apt-get; then
        info "Using APT."
        retry 3 apt_run update \
          || die "apt-get update failed. Check your network/proxy settings and re-run this script."
        retry 3 apt_run install -y git nodejs pkg-config libcurl4-openssl-dev gnupg wget ca-certificates lsb-release software-properties-common \
          || die "apt-get install failed. See log: $LOG_FILE -- re-run this script to retry."
        install_llvm_apt "$AUTO_LLVM_VERSION"
      elif check_dep pacman; then
        info "Using Pacman."
        retry 3 $SUDO pacman -Sy --needed --noconfirm git nodejs clang llvm pkgconf curl gnupg \
          || die "pacman install failed. Re-run this script to retry."
      elif check_dep dnf; then
        info "Using DNF."
        retry 3 $SUDO dnf install -y git nodejs clang llvm pkgconf-pkg-config libcurl-devel gnupg2 \
          || die "dnf install failed. Re-run this script to retry."
      elif check_dep zypper; then
        info "Using Zypper."
        retry 3 $SUDO zypper --non-interactive install git nodejs clang llvm pkg-config libcurl-devel gpg2 \
          || die "zypper install failed. Re-run this script to retry."
      else
        die "No supported Linux package manager found. Install manually: git nodejs clang llvm pkg-config libcurl-dev gnupg"
      fi
      ;;
    android)
      info "Using Termux (pkg)."
      export DEBIAN_FRONTEND=noninteractive
      retry 3 pkg update -y \
        || die "pkg update failed. Check your network connection and re-run this script."
      retry 3 pkg install -y git nodejs clang llvm pkg-config libcurl gnupg \
        || die "pkg install failed. Re-run this script to retry."
      ;;
    macos)
      check_dep brew || die "Homebrew is not installed. Install it from https://brew.sh, then re-run this script."
      info "Using Homebrew."
      retry 3 brew install git node llvm curl pkg-config gnupg \
        || die "brew install failed. Re-run this script to retry."
      ;;
    windows)
      if check_dep choco; then
        info "Using Chocolatey (best-effort)."
        retry 2 choco install -y git nodejs llvm \
          || warn "Chocolatey reported errors. Verify git/node/clang/llc manually before continuing."
      elif check_dep winget; then
        info "Using winget (best-effort)."
        winget install --id Git.Git -e --silent || warn "winget could not install Git; install it manually."
        winget install --id OpenJS.NodeJS -e --silent || warn "winget could not install Node.js; install it manually."
        winget install --id LLVM.LLVM -e --silent || warn "winget could not install LLVM; install it manually."
      else
        die "No supported package manager found (choco/winget). Install git, Node.js, LLVM $MIN_LLVM_MAJOR+ and libcurl dev headers manually, or use WSL."
      fi
      ;;
  esac
}

prepare_macos_env() {
  local p
  check_dep brew || return 0
  if ! check_dep llc; then
    p="$(brew --prefix llvm 2>/dev/null || true)"
    if [ -n "$p" ] && [ -x "$p/bin/llc" ]; then
      export PATH="$p/bin:$PATH"
      LLVM_BIN_DIR="$p/bin"
    fi
  fi
  if check_dep pkg-config && ! pkg-config --exists libcurl 2>/dev/null; then
    p="$(brew --prefix curl 2>/dev/null || true)"
    if [ -n "$p" ] && [ -d "$p/lib/pkgconfig" ]; then
      export PKG_CONFIG_PATH="$p/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
    fi
  fi
  return 0
}

collect_missing() {
  local dep
  missing=()
  for dep in "${REQUIRED_DEPS[@]}" clang llc; do
    check_dep "$dep" || missing+=("$dep")
  done
  missing_text=""
  if [ "${#missing[@]}" -gt 0 ]; then
    missing_text="$(IFS=' '; echo "${missing[*]}")"
  fi
}

read_llc_version() {
  local raw
  raw="$(llc --version 2>/dev/null | grep -m1 -oE 'LLVM version [0-9]+\.[0-9]+\.[0-9]+' || true)"
  [ -n "$raw" ] || die "Unable to determine LLVM version from 'llc --version'. Ensure LLVM $MIN_LLVM_MAJOR+ is installed and on PATH, then re-run this script."
  LLC_VERSION_FULL="${raw##* }"
  LLC_MAJOR="${LLC_VERSION_FULL%%.*}"
  case "$LLC_MAJOR" in
    ''|*[!0-9]*) die "Could not parse a numeric LLVM major version from: $raw" ;;
  esac
}

compile_ll() {
  local src="$1" out="$2"
  [ -f "$src" ] || die "Source not found: $src"
  llc -filetype=obj -relocation-model=pic "$src" -o "$out" || die "Failed to compile: $src"
}

compile_c() {
  local src="$1" out="$2"
  shift 2
  [ -f "$src" ] || die "Source not found: $src"
  clang -c -fPIC "$@" "$src" -o "$out" || die "Failed to compile: $src"
}

detect_rc_file() {
  case "${SHELL:-}" in
    */zsh)  echo "$HOME/.zshrc" ;;
    */bash) if [ -f "$HOME/.bash_profile" ]; then echo "$HOME/.bash_profile"; else echo "$HOME/.bashrc"; fi ;;
    *)      echo "$HOME/.profile" ;;
  esac
}

clone_ref() {
  rm -rf "$TMP_CLONE_DIR"
  git clone --quiet --branch "$REF" --depth 1 "$REPO" "$TMP_CLONE_DIR"
}

main() {
  set -Eeuo pipefail
  IFS=$'\n\t'
  export GIT_TERMINAL_PROMPT=0

  : "${HOME:?HOME is not set; refusing to continue}"

  REPO="${ZEN_REPO:-https://github.com/Jishith-dev/Zen.git}"
  REF="${ZEN_REF:-}"
  INSTALL_DIR="${ZEN_INSTALL_DIR:-$HOME/.zen}"
  STATE_FILE="$INSTALL_DIR/.install-state"
  CUSTOM_PREFIX="${ZEN_PREFIX:-}"
  LOG_FILE="$(mktemp "${TMPDIR:-/tmp}/zen-install-XXXXXX" 2>/dev/null || echo "/tmp/zen-install-$$.log")"

  trap cleanup EXIT
  trap 'error "Command failed at line $LINENO. Re-run this script to retry. Full log: $LOG_FILE"' ERR

  while [ $# -gt 0 ]; do
    case "$1" in
      --tag)        REF_KIND="tag";    REF="${2:?--tag requires a value}"; shift 2 ;;
      --branch)     REF_KIND="branch"; REF="${2:?--branch requires a value}"; shift 2 ;;
      --prefix)     CUSTOM_PREFIX="${2:?--prefix requires a value}"; shift 2 ;;
      --force)      FORCE=1; shift ;;
      -y|--yes)     ASSUME_YES=1; shift ;;
      --no-rc-edit) EDIT_RC=0; shift ;;
      -h|--help)    printf '%s\n' "$HELP_TEXT"; rm -f "$LOG_FILE"; exit 0 ;;
      *) die "Unknown option: $1 (use --help)" ;;
    esac
  done

  info "Log file: $LOG_FILE"

  TARGET_OS="$(detect_os)"
  info "Detected OS: $TARGET_OS"
  [ "$TARGET_OS" != "unknown" ] || die "Unsupported operating system: $(uname -s)"

  if [ "$TARGET_OS" = "windows" ]; then
    warn "Running on native Windows. Dependency installation is best-effort (choco/winget)."
    warn "Required: git, Node.js, LLVM $MIN_LLVM_MAJOR+ (clang, llc on PATH), pkg-config, libcurl dev headers."
    warn "For a fully automatic install, use WSL instead."
  fi

  if [ -z "$CUSTOM_PREFIX" ] && [ "$TARGET_OS" = "android" ] && [ -n "${PREFIX:-}" ]; then
    CUSTOM_PREFIX="$PREFIX"
  fi

  if [ "$TARGET_OS" = "macos" ]; then
    prepare_macos_env
  fi

  collect_missing
  if [ "${#missing[@]}" -gt 0 ]; then
    warn "Missing dependencies: $missing_text"
    if confirm "Install the required dependencies automatically?"; then
      install_deps
      if [ "$TARGET_OS" = "macos" ]; then
        prepare_macos_env
      fi
      collect_missing
      [ "${#missing[@]}" -eq 0 ] || die "Still missing after automatic install: $missing_text. Install them manually and re-run this script."
    else
      die "Cannot continue without: $missing_text. Install them, or re-run with -y to install automatically."
    fi
  fi

  info "Checking LLVM version..."
  read_llc_version

  if [ "$LLC_MAJOR" -lt "$MIN_LLVM_MAJOR" ] || [ "$LLC_MAJOR" -gt "$MAX_LLVM_MAJOR" ]; then
    warn "LLVM $LLC_VERSION_FULL detected; Zen requires LLVM >= $MIN_LLVM_MAJOR (tested up to $MAX_LLVM_MAJOR)."
    if [ "$TARGET_OS" = "linux" ] && check_dep apt-get && confirm "Install LLVM $AUTO_LLVM_VERSION via apt.llvm.org and set it as default?"; then
      install_llvm_apt "$AUTO_LLVM_VERSION"
      read_llc_version
      [ "$LLC_MAJOR" -ge "$MIN_LLVM_MAJOR" ] || die "LLVM install did not produce a supported version (got $LLC_VERSION_FULL). Install LLVM $MIN_LLVM_MAJOR+ manually."
    else
      die "LLVM $LLC_VERSION_FULL detected; Zen requires LLVM >= $MIN_LLVM_MAJOR (tested up to $MAX_LLVM_MAJOR). Install a supported version (LLVM $AUTO_LLVM_VERSION recommended) and re-run."
    fi
  fi
  success "LLVM $LLC_VERSION_FULL detected (compatible)."

  if [ "$TARGET_OS" = "linux" ] || [ "$TARGET_OS" = "android" ]; then
    local clang_major
    clang_major="$(clang --version 2>/dev/null | grep -m1 -oE 'version [0-9]+' | grep -oE '[0-9]+' || true)"
    if [ -n "$clang_major" ] && [ "$clang_major" -lt "$MIN_LLVM_MAJOR" ]; then
      warn "clang $clang_major is older than LLVM $MIN_LLVM_MAJOR; llc and clang versions should match."
    fi
  fi

  info "Checking for libcurl..."
  pkg-config --exists libcurl 2>/dev/null || die "libcurl development files not found. Install them (e.g. libcurl4-openssl-dev / libcurl-devel) and re-run this script."
  local curl_flags
  curl_flags="$(pkg-config --cflags libcurl)"
  CURL_CFLAGS=()
  if [ -n "$curl_flags" ]; then
    IFS=' ' read -r -a CURL_CFLAGS <<< "$curl_flags"
  fi
  success "libcurl found."

  if [ -z "$REF" ] && [ "$REF_KIND" = "tag" ]; then
    info "Resolving latest release tag..."
    local remote_tags latest_tag
    remote_tags="$(retry 3 git ls-remote --tags --refs "$REPO")" \
      || die "Could not reach $REPO. Check your network connection, or pass --tag <tag> / --branch <name> explicitly."
    latest_tag="$(printf '%s\n' "$remote_tags" \
      | awk '{t=$2; sub("refs/tags/","",t); v=t; sub(/^v/,"",v); print v, t}' \
      | grep -E '^[0-9]+\.[0-9]+\.[0-9]+ ' \
      | sort -t. -k1,1n -k2,2n -k3,3n \
      | tail -n1 \
      | awk '{print $2}' || true)"
    [ -n "$latest_tag" ] || die "Could not resolve a release tag from $REPO. Pass --tag <tag> or --branch <name> explicitly."
    REF="$latest_tag"
  fi

  if [ "$REF_KIND" = "branch" ]; then
    warn "Installing from branch '$REF' -- unpinned, tracks the latest commit."
    confirm "Continue installing from branch '$REF'?" || die "Aborted by user."
  fi

  info "Target ref: $REF ($REF_KIND)"

  if [ -f "$STATE_FILE" ] && [ "$FORCE" -ne 1 ] && [ -x "$INSTALL_DIR/bin/zen.js" ]; then
    local installed_ref
    installed_ref="$(grep -m1 '^ref=' "$STATE_FILE" 2>/dev/null | cut -d= -f2- || true)"
    if [ "$REF_KIND" = "tag" ] && [ "$installed_ref" = "$REF" ]; then
      success "Zen ($REF) is already installed at $INSTALL_DIR. Use --force to reinstall."
      INSTALL_SUCCEEDED=1
      exit 0
    fi
  fi

  local parent
  parent="$(dirname "$INSTALL_DIR")"
  mkdir -p "$parent"
  TMP_CLONE_DIR="$parent/.zen-staging.$$"

  info "Cloning $REPO @ $REF into a staging directory..."
  retry 3 clone_ref \
    || die "Failed to clone $REPO at ref '$REF'. Check that the ref exists and your network connection, then re-run this script."

  cd "$TMP_CLONE_DIR"
  local resolved_commit
  resolved_commit="$(git rev-parse HEAD)"
  info "Resolved commit: $resolved_commit"

  if [ "$REF_KIND" = "tag" ]; then
    if git tag -v "$REF" >/dev/null 2>&1; then
      success "Tag signature verified for $REF."
    else
      warn "Could not cryptographically verify tag '$REF' (unsigned tag or key not in local keyring)."
      warn "Proceeding on trust of the resolved commit hash: $resolved_commit"
    fi
  fi

  local zen_version
  if [ "$REF_KIND" = "tag" ]; then
    [ -f VERSION ] || die "VERSION file not found in repository."
    zen_version="$(tr -d '[:space:]' < VERSION)"
    [ -n "$zen_version" ] || die "VERSION file is empty."
    if [ "${zen_version#v}" != "${REF#v}" ]; then
      warn "VERSION file ($zen_version) does not match tag ($REF)."
    fi
    zen_version="${zen_version#v}"
  else
    zen_version="${resolved_commit:0:7}"
    if [ -f VERSION ]; then
      info "VERSION file says $(tr -d '[:space:]' < VERSION); using branch commit $zen_version instead."
    fi
  fi

  info "Installing Zen v$zen_version ($REF)..."

  local sha_cmd=()
  if check_dep sha256sum; then
    sha_cmd=(sha256sum -c)
  elif check_dep shasum; then
    sha_cmd=(shasum -a 256 -c)
  fi

  if [ -f SHA256SUMS ]; then
    [ "${#sha_cmd[@]}" -gt 0 ] || die "Neither sha256sum nor shasum is available to verify SHA256SUMS."
    info "Verifying source checksums..."
    "${sha_cmd[@]}" SHA256SUMS >/dev/null \
      || die "Checksum verification failed against SHA256SUMS. Refusing to build untrusted source."
    success "Checksums verified."
  elif [ "$REF_KIND" = "tag" ]; then
    die "SHA256SUMS not found in release $REF. Refusing to install an unverified release."
  else
    warn "No SHA256SUMS manifest found in this branch; skipping checksum verification."
  fi

  local rt="src/codegen/runtime"
  local std="src/zen_stdlib"
  local runtime_src="$rt/runtime.c"
  if [ "$TARGET_OS" = "windows" ]; then
    runtime_src="$rt/w_runtime.c"
  fi

  info "Building stdlib..."
  compile_ll "$std/constants.ll"      "$std/constants.o"
  compile_ll "$std/zen_stdlib_opt.ll" "$std/zen_stdlib_opt.o"

  info "Building runtime..."
  compile_c "$runtime_src"        "$rt/runtime.o"
  compile_c "$rt/listRuntime.c"   "$rt/listRuntime.o"
  compile_c "$rt/jsonRuntime.c"   "$rt/jsonRuntime.o"
  compile_c "$rt/mapRuntime.c"    "$rt/mapRuntime.o"
  compile_c "$rt/httpRuntime.c"   "$rt/httpRuntime.o"
  compile_c "$rt/curlRuntime.c"   "$rt/curlRuntime.o" ${CURL_CFLAGS[@]+"${CURL_CFLAGS[@]}"}
  compile_c "$rt/tcp.c"           "$rt/tcp.o"         ${CURL_CFLAGS[@]+"${CURL_CFLAGS[@]}"}

  info "Packing runtime archive..."
  local ar_bin
  ar_bin="$(command -v llvm-ar || command -v ar || true)"
  [ -n "$ar_bin" ] || die "Neither llvm-ar nor ar found. Install LLVM or binutils."

  rm -f "$rt/libzenrt.a"
  "$ar_bin" rcs "$rt/libzenrt.a" \
    "$rt/runtime.o" \
    "$rt/listRuntime.o" \
    "$rt/jsonRuntime.o" \
    "$rt/mapRuntime.o" \
    "$rt/httpRuntime.o" \
    "$rt/curlRuntime.o" \
    "$rt/tcp.o" \
    || die "Failed to create libzenrt.a"

  info "Verifying build artifacts..."
  local artifacts=(
    "$std/constants.o"
    "$std/zen_stdlib_opt.o"
    "$rt/runtime.o"
    "$rt/listRuntime.o"
    "$rt/mapRuntime.o"
    "$rt/curlRuntime.o"
    "$rt/httpRuntime.o"
    "$rt/jsonRuntime.o"
    "$rt/tcp.o"
    "$rt/libzenrt.a"
  )
  local f
  for f in "${artifacts[@]}"; do
    [ -f "$f" ] || die "Missing artifact after build: $f"
  done
  success "All artifacts verified."

  [ -f bin/zen.js ] || die "bin/zen.js not found in repository."
  chmod +x bin/zen.js

  info "Finalizing install directory: $INSTALL_DIR"
  cd "$HOME"
  if [ -e "$INSTALL_DIR" ]; then
    BACKUP_DIR="${INSTALL_DIR}.bak.$$"
    rm -rf "$BACKUP_DIR"
    mv "$INSTALL_DIR" "$BACKUP_DIR"
  fi
  mv "$TMP_CLONE_DIR" "$INSTALL_DIR"
  INSTALL_MOVED=1
  TMP_CLONE_DIR=""

  {
    printf 'ref=%s\n' "$REF"
    printf 'ref_kind=%s\n' "$REF_KIND"
    printf 'version=%s\n' "$zen_version"
    printf 'commit=%s\n' "$resolved_commit"
    printf 'installed_at=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    printf 'os=%s\n' "$TARGET_OS"
  } > "$STATE_FILE"

  local bin_dir
  if [ -n "$CUSTOM_PREFIX" ]; then
    bin_dir="$CUSTOM_PREFIX/bin"
  else
    bin_dir="$HOME/.local/bin"
  fi
  mkdir -p "$bin_dir" || die "Could not create $bin_dir. Use --prefix with a writable directory."

  ln -sf "$INSTALL_DIR/bin/zen.js" "$bin_dir/zen" || die "Could not create symlink in $bin_dir. Use --prefix with a writable directory."
  info "Linked zen -> $INSTALL_DIR/bin/zen.js in $bin_dir"

  if [ -n "$BACKUP_DIR" ]; then
    rm -rf "$BACKUP_DIR" || true
    BACKUP_DIR=""
  fi
  INSTALL_SUCCEEDED=1

  local path_add=""
  case ":$ORIG_PATH:" in
    *":$bin_dir:"*) ;;
    *) path_add="$bin_dir" ;;
  esac
  if [ -n "$LLVM_BIN_DIR" ]; then
    case ":$ORIG_PATH:" in
      *":$LLVM_BIN_DIR:"*) ;;
      *) path_add="${path_add:+$path_add:}$LLVM_BIN_DIR" ;;
    esac
  fi

  if [ -z "$path_add" ]; then
    success "$bin_dir is already in PATH."
  else
    local path_line rc_file
    path_line="export PATH=\"$path_add:\$PATH\""
    rc_file="$(detect_rc_file)"
    warn "$path_add is not in your PATH."
    if [ "$EDIT_RC" -eq 1 ] && confirm "Add PATH export to $rc_file?"; then
      if [ -f "$rc_file" ] && grep -qF "$path_line" "$rc_file" 2>/dev/null; then
        info "$rc_file already contains this PATH line."
      elif {
        echo ""
        echo "# Added by Zen installer on $(date -u +%Y-%m-%d)"
        echo "$path_line"
      } >> "$rc_file" 2>/dev/null; then
        success "Added PATH export to $rc_file. Restart your shell or run: source $rc_file"
      else
        warn "Could not write to $rc_file. Add this line manually:"
        echo "  $path_line"
      fi
    else
      echo ""
      echo "Add this to your shell config manually:"
      echo ""
      echo "  $path_line"
      echo ""
    fi
  fi

  echo ""
  success "Zen v$zen_version installed successfully!"
  echo ""
  echo "  zen --help"
  echo "  zen --version"
  echo "  zen run <file>"
  echo ""
  info "Install log saved to: $LOG_FILE"
}

main "$@" </dev/null