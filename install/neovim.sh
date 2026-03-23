#!/bin/bash
set -e

echo "→ Setting up Neovim config..."

if ! command -v nvim &>/dev/null; then
    echo "  neovim not found — run install/tools.sh first"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"

# Create config dir if it doesn't exist
mkdir -p "$NVIM_CONFIG"

# Symlink the nvim config from this repo
ln -sf "$SCRIPT_DIR/configs/nvim/init.lua" "$NVIM_CONFIG/init.lua"

# Install lazy.nvim (plugin manager) if not already installed
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
    echo "  Installing lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$LAZY_PATH"
fi

echo "✓ Neovim config linked"
echo "  Open nvim and run :Lazy to install plugins"
