#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO="https://raw.githubusercontent.com/MohammadFalhaa/server-config/main"

usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --all         Run everything"
    echo "  --tools       Install base tools (git, tmux, neovim, python3...)"
    echo "  --server      Server hardening (UFW, fail2ban, SSH config)"
    echo "  --docker      Install Docker + Docker Compose"
    echo "  --postgres    Install PostgreSQL + contrib extensions"
    echo "  --tmux        Install oh-my-tmux and apply config"
    echo "  --neovim      Link neovim config and install plugins"
    echo "  --dotfiles    Apply shell config (.bashrc)"
    echo ""
    echo "Examples:"
    echo "  ./setup.sh --all                  # fresh server, everything"
    echo "  ./setup.sh --tools --tmux         # just tools and tmux"
    echo "  ./setup.sh --tools --neovim       # tools and neovim only"
}

_run() {
    if [[ "$SCRIPT_DIR" == /dev/fd* ]]; then
        bash <(curl -fsSL "$REPO/$1")
    else
        bash "$SCRIPT_DIR/$1"
    fi
}

run_tools()    { _run install/tools.sh; }
run_server()   { _run install/server.sh; }
run_docker()   { _run install/docker.sh; }
run_postgres() { _run install/postgres.sh; }
run_tmux()     { _run install/tmux.sh; }
run_neovim()   { _run install/neovim.sh; }

run_dotfiles() {
    echo "→ Applying .bashrc..."
    if [[ "$SCRIPT_DIR" == /dev/fd* ]]; then
        curl -fsSL "$REPO/configs/.bashrc" >> "$HOME/.bashrc"
    else
        cat "$SCRIPT_DIR/configs/.bashrc" >> "$HOME/.bashrc"
    fi
    echo "✓ .bashrc updated — run 'source ~/.bashrc' to apply"
}

if [ $# -eq 0 ]; then
    usage
    exit 0
fi

for arg in "$@"; do
    case $arg in
        --all)      run_tools; run_server; run_docker; run_postgres; run_tmux; run_neovim; run_dotfiles ;;
        --tools)    run_tools ;;
        --server)   run_server ;;
        --docker)   run_docker ;;
        --postgres) run_postgres ;;
        --tmux)     run_tmux ;;
        --neovim)   run_neovim ;;
        --dotfiles) run_dotfiles ;;
        *)          echo "Unknown option: $arg"; usage; exit 1 ;;
    esac
done
