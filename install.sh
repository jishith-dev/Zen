#!/bin/bash

set -e

REPO="https://github.com/jishith-dev/Zen.git"
INSTALL_DIR="$HOME/.zen"

echo "Installing Zen Compiler..."

# clean install
rm -rf "$INSTALL_DIR"
git clone --depth 1 "$REPO" "$INSTALL_DIR"

cd "$INSTALL_DIR"

chmod +x bin/zen.js

mkdir -p "$HOME/.local/bin"

ln -sf "$INSTALL_DIR/bin/zen.js" "$HOME/.local/bin/zen"

# ensure PATH (temporary + permanent)
export PATH="$HOME/.local/bin:$PATH"

if ! grep -q ".local/bin" "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "Zen installed successfully!"
echo "Run: zen run file.zen"
