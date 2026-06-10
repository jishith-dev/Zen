#!/bin/bash

set -e

REPO="https://github.com/jishith-dev/Zen.git"
BRANCH="main"
INSTALL_DIR="$HOME/.zen"

echo "Installing Zen Compiler..."

rm -rf "$INSTALL_DIR"
git clone --depth 1 --branch "$BRANCH" "$REPO" "$INSTALL_DIR"

cd "$INSTALL_DIR"

echo "Checking LLVM toolchain..."

command -v clang >/dev/null 2>&1 || {
echo "LLVM/Clang not found."
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

command -v llc >/dev/null 2>&1 || {
echo "LLVM llc not found."
echo "Install LLVM and re-run installer."
exit 1
}

echo "Building runtime ..."

llc -filetype=obj src/zen_stdlib/constants.ll -o src/zen_stdlib/constants.o

llc -filetype=obj src/zen_stdlib/zen_stdlib_opt.ll -o src/zen_stdlib/stdlib_opt.o


clang -c src/codegen/runtime/runtime.c -o src/codegen/runtime/runtime.o

clang -c src/codegen/runtime/listRuntime.c -o src/codegen/runtime/listRuntime.o

clang -c src/codegen/runtime/mapRuntime.c -o src/codegen/runtime/mapRuntime.o

echo "Linking CLI..."

chmod +x bin/zen.js

if [ -n "$PREFIX" ] && [ -d "$PREFIX/bin" ]; then
ln -sf "$INSTALL_DIR/bin/zen.js" "$PREFIX/bin/zen"
else
mkdir -p "$HOME/.local/bin"
ln -sf "$INSTALL_DIR/bin/zen.js" "$HOME/.local/bin/zen"
fi

echo ""
echo "Zen installed successfully!"
echo "Run: zen --help"