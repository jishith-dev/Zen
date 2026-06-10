#!/bin/bash

set -e

REPO="https://github.com/jishith-dev/Zen.git"
INSTALL_DIR="$HOME/.zen"

echo "Installing Zen Compiler..."

rm -rf "$INSTALL_DIR"
git clone --depth 1 --branch dev "$REPO" "$INSTALL_DIR"

cd "$INSTALL_DIR"

echo "Checking LLVM toolchain..."
command -v clang >/dev/null 2>&1 || {
  echo "LLVM/Clang not found. Install LLVM first."
  echo ""
echo "LVM toolchain not found."
echo ""
echo "Install dependencies:"
echo ""

echo "Ubuntu / Debian:"
echo "sudo apt update"
echo "sudo apt install llvm clang"

echo ""

echo "Arch Linux:"
echo "sudo pacman -S llvm clang"

echo ""

echo "Fedora:"
echo "sudo dnf install llvm clang"

echo ""

echo "Termux (Android):"
echo "pkg install llvm clang"

echo ""

echo "macOS:"
echo "brew install llvm"

echo ""

echo "Then re-run installer."
exit 1
  
}

echo "Building runtime (in-place)..."

# -----------------------------
# STDLIB (.ll → .o in same folder)
# -----------------------------

llc -filetype=obj src/zen_stdlib/constants.ll -o src/zen_stdlib/constants.o
llc -filetype=obj src/zen_stdlib/zen_stdlib_opt.ll -o src/zen_stdlib/stdlib_opt.o

# -----------------------------
# RUNTIME (.c → .o in same folder)
# -----------------------------

clang -c src/codegen/runtime/runtime.c -o src/codegen/runtime/runtime.o
clang -c src/codegen/runtime/listRuntime.c -o src/codegen/runtime/listRuntime.o
clang -c src/codegen/runtime/mapRuntime.c -o src/codegen/runtime/mapRuntime.o

echo "Linking CLI..."

chmod +x bin/zen.js

mkdir -p "$HOME/.local/bin"
ln -sf "$INSTALL_DIR/bin/zen.js" "$HOME/.local/bin/zen"

echo "Zen installed successfully!"
echo "Run: zen run file.zen"