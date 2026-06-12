#!/bin/bash

set -euo pipefail

REPO="https://github.com/jishith-dev/Zen.git"
BRANCH="dev"
INSTALL_DIR="$HOME/.zen"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

info()    { echo -e "${CYAN}[zen]${RESET} $*"; }
success() { echo -e "${GREEN}[zen]${RESET} $*"; }
warn()    { echo -e "${YELLOW}[zen]${RESET} $*"; }
error()   { echo -e "${RED}[zen] error:${RESET} $*" >&2; }

REQUIRED_DEPS=(clang llc opt git node)

check_dep() {
  command -v "$1" >/dev/null 2>&1
}

info "Checking dependencies..."

missing=()

for dep in "${REQUIRED_DEPS[@]}"; do
  if ! check_dep "$dep"; then
    missing+=("$dep")
  fi
done

if [ ${#missing[@]} -ne 0 ]; then
  error "Missing dependencies: ${missing[*]}"
  echo ""
  echo "Install them using:"
  echo ""
  echo "================ LINUX (Ubuntu/Debian) ================"
  echo "sudo apt update"
  echo "sudo apt install -y git nodejs npm clang llvm libcurl4-openssl-dev"
  echo ""
  echo "================ ARCH ================================"
  echo "sudo pacman -S git nodejs npm clang llvm curl"
  echo ""
  echo "================ FEDORA =============================="
  echo "sudo dnf install git nodejs npm clang llvm libcurl-devel"
  echo ""
  echo "================ MACOS ==============================="
  echo "brew install git node llvm curl"
  echo ""
  echo "================ TERMUX =============================="
  echo "pkg update"
  echo "pkg install git nodejs clang llvm libcurl"
  echo ""
  exit 1
fi

# CHECK CURL DEV HEADERS

info "Checking for libcurl headers..."

if ! pkg-config --exists libcurl 2>/dev/null; then
  error "libcurl development headers not found."
  echo ""
  echo "Install using:"
  echo "  Ubuntu/Debian : sudo apt install -y libcurl4-openssl-dev"
  echo "  Arch          : sudo pacman -S curl"
  echo "  Fedora        : sudo dnf install libcurl-devel"
  echo "  macOS         : brew install curl"
  echo "  Termux        : pkg install libcurl-dev"
  echo ""
  exit 1
fi

CURL_CFLAGS=$(pkg-config --cflags libcurl)

success "All dependencies found."

info "Installing Zen to $INSTALL_DIR..."

rm -rf "$INSTALL_DIR"
git clone --depth 1 --branch "$BRANCH" "$REPO" "$INSTALL_DIR" || {
  error "Failed to clone repository."
  exit 1
}

cd "$INSTALL_DIR"

info "Building stdlib..."

compile_ll() {
  local src="$1"
  local out="$2"
  [ -f "$src" ] || { error "Source not found: $src"; exit 1; }
  llc -filetype=obj -relocation-model=pic "$src" -o "$out" || {
    error "Failed to compile: $src"
    exit 1
  }
}

compile_c() {
  local src="$1"
  local out="$2"
  [ -f "$src" ] || { error "Source not found: $src"; exit 1; }
  clang -c -fPIC "$src" -o "$out" || {
    error "Failed to compile: $src"
    exit 1
  }
}

compile_c_curl() {
  local src="$1"
  local out="$2"
  [ -f "$src" ] || { error "Source not found: $src"; exit 1; }
  clang -c -fPIC $CURL_CFLAGS "$src" -o "$out" || {
    error "Failed to compile: $src"
    exit 1
  }
}

compile_ll src/zen_stdlib/constants.ll        src/zen_stdlib/constants.o
compile_ll src/zen_stdlib/zen_stdlib_opt.ll   src/zen_stdlib/zen_stdlib_opt.o

info "Building runtime..."

compile_c      src/codegen/runtime/runtime.c       src/codegen/runtime/runtime.o
compile_c      src/codegen/runtime/listRuntime.c   src/codegen/runtime/listRuntime.o
compile_c      src/codegen/runtime/mapRuntime.c    src/codegen/runtime/mapRuntime.o
compile_c_curl src/codegen/runtime/curlRuntime.c   src/codegen/runtime/curlRuntime.o

info "Verifying build artifacts..."

ARTIFACTS=(
  src/zen_stdlib/constants.o
  src/zen_stdlib/zen_stdlib_opt.o
  src/codegen/runtime/runtime.o
  src/codegen/runtime/listRuntime.o
  src/codegen/runtime/mapRuntime.o
  src/codegen/runtime/curlRuntime.o
)

for f in "${ARTIFACTS[@]}"; do
  [ -f "$f" ] || { error "Missing artifact: $f"; exit 1; }
done

success "All artifacts verified."

info "Linking CLI..."

chmod +x bin/zen.js

if [ -n "${PREFIX:-}" ] && [ -d "$PREFIX/bin" ]; then
  ln -sf "$INSTALL_DIR/bin/zen.js" "$PREFIX/bin/zen"
  BIN_DIR="$PREFIX/bin"
else
  mkdir -p "$HOME/.local/bin"
  ln -sf "$INSTALL_DIR/bin/zen.js" "$HOME/.local/bin/zen"
  BIN_DIR="$HOME/.local/bin"
fi

if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  warn "$BIN_DIR is not in your PATH."
  echo ""
  echo "Add this to your shell config (~/.bashrc or ~/.zshrc):"
  echo "export PATH=\"$BIN_DIR:\$PATH\""
  echo ""
fi

echo ""
success "Zen installed successfully!"
echo ""
echo "  zen --help"
echo "  zen --version"
echo "  zen run <file>"
echo ""