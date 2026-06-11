#!/bin/bash

set -euo pipefail

REPO="https://github.com/jishith-dev/Zen.git"
BRANCH="main"
INSTALL_DIR="$HOME/.zen"

# ---------------- COLORS ----------------

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

info()    { echo -e "${CYAN}[zen]${RESET} $*"; }
success() { echo -e "${GREEN}[zen]${RESET} $*"; }
warn()    { echo -e "${YELLOW}[zen]${RESET} $*"; }
error()   { echo -e "${RED}[zen] error:${RESET} $*" >&2; }

# ---------------- DEPS ----------------

check_dep() {
  command -v "$1" >/dev/null 2>&1 || {
    error "$1 not found."
    echo ""
    echo "Install LLVM toolchain:"
    echo "  Termux:         pkg install llvm clang"
    echo "  Ubuntu/Debian:  sudo apt install llvm clang"
    echo "  Arch:           sudo pacman -S llvm clang"
    echo "  Fedora:         sudo dnf install llvm clang"
    echo "  macOS:          brew install llvm"
    echo ""
    exit 1
  }
}

info "Checking dependencies..."
check_dep clang
check_dep llc
check_dep opt
check_dep git
check_dep node
success "All dependencies found."

# ---------------- CLONE ----------------

info "Installing Zen to $INSTALL_DIR..."

rm -rf "$INSTALL_DIR"
git clone --depth 1 --branch "$BRANCH" "$REPO" "$INSTALL_DIR" || {
  error "Failed to clone repository."
  exit 1
}

cd "$INSTALL_DIR"

# ---------------- BUILD STDLIB ----------------

info "Building stdlib..."

compile_ll() {
  local src="$1"
  local out="$2"
  [ -f "$src" ] || { error "Source not found: $src"; exit 1; }
  llc -filetype=obj -relocation-model=pic "$src" -o "$out" || { error "Failed to compile: $src"; exit 1; }
}

compile_c() {
  local src="$1"
  local out="$2"
  [ -f "$src" ] || { error "Source not found: $src"; exit 1; }
  clang -c -fPIC "$src" -o "$out" || { error "Failed to compile: $src"; exit 1; }
}

compile_ll src/zen_stdlib/constants.ll        src/zen_stdlib/constants.o
compile_ll src/zen_stdlib/zen_stdlib_opt.ll   src/zen_stdlib/zen_stdlib_opt.o

# ---------------- BUILD RUNTIME ----------------

info "Building runtime..."

compile_c src/codegen/runtime/runtime.c       src/codegen/runtime/runtime.o
compile_c src/codegen/runtime/listRuntime.c   src/codegen/runtime/listRuntime.o
compile_c src/codegen/runtime/mapRuntime.c    src/codegen/runtime/mapRuntime.o

# ---------------- VERIFY ARTIFACTS ----------------

info "Verifying build artifacts..."

ARTIFACTS=(
  src/zen_stdlib/constants.o
  src/zen_stdlib/zen_stdlib_opt.o
  src/codegen/runtime/runtime.o
  src/codegen/runtime/listRuntime.o
  src/codegen/runtime/mapRuntime.o
)

for f in "${ARTIFACTS[@]}"; do
  [ -f "$f" ] || { error "Missing artifact: $f"; exit 1; }
done

success "All artifacts verified."

# ---------------- LINK CLI ----------------

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

# ---------------- PATH CHECK ----------------

if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  warn "$BIN_DIR is not in your PATH."
  echo ""
  echo "Add this to your shell config (~/.bashrc or ~/.zshrc):"
  echo "  export PATH=\"$BIN_DIR:\$PATH\""
  echo ""
fi

# ---------------- DONE ----------------

echo ""
success "Zen installed successfully!"
echo ""
echo "  zen --help     show commands"
echo "  zen --version  show version"
echo "  zen run <file> run a .zen file"
echo ""