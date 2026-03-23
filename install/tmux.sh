#!/bin/bash
set -e

echo "→ Installing oh-my-tmux..."

# oh-my-tmux requires tmux >= 2.1
if ! command -v tmux &>/dev/null; then
    echo "  tmux not found — run install/tools.sh first"
    exit 1
fi

# Clone oh-my-tmux into home directory
if [ -d "$HOME/.tmux" ]; then
    echo "  ~/.tmux already exists, pulling latest..."
    git -C "$HOME/.tmux" pull
else
    git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
fi

# Link the config
ln -sf "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"


echo "✓ oh-my-tmux installed"
echo "  Start a new tmux session to see the changes"
