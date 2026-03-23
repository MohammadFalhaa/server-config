#!/bin/bash
set -e

echo "→ Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "→ Installing essential tools..."
sudo apt install -y \
    git \
    curl \
    wget \
    tmux \
    screen \
    neovim \
    vim \
    sudo \
    python3 \
    python3-pip \
    python3-venv \
    htop \
    unzip \
    build-essential

echo "✓ Tools installed"
