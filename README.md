# server-config

Setup scripts and dotfiles for personal servers and dev machines. Allows running everything on a fresh server, or pick individual scripts.

## Usage

```bash
git clone git@github.com:yourusername/server-config.git
cd server-config
bash setup.sh --help
```

Or run directly from GitHub without cloning:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/yourusername/server-config/main/setup.sh) --tools --tmux
```

## Options

| Flag | What it does |
|------|-------------|
| `--all` | Everything below |
| `--tools` | git, curl, tmux, neovim, python3, vim, htop |
| `--server` | UFW firewall, fail2ban, SSH hardening, auto security updates |
| `--docker` | Docker Engine + Docker Compose plugin |
| `--postgres` | PostgreSQL + contrib extensions |
| `--tmux` | oh-my-tmux + custom config |
| `--neovim` | Neovim config + lazy.nvim plugins |
| `--dotfiles` | Shell aliases and PATH (.bashrc) |

## Common setups

```bash
# Fresh server — full setup
./setup.sh --all

# Fresh server — no postgres
./setup.sh --tools --server --docker --tmux --neovim --dotfiles

# New laptop — skip server hardening
./setup.sh --tools --tmux --neovim --dotfiles
```

## What's in the configs

- **tmux** — oh-my-tmux with defaults, a `.tmux.conf.local` is generated for your own overrides
- **neovim** — lazy.nvim, tokyonight theme, telescope, treesitter, file tree, autopairs
- **bashrc** — aliases for git, docker, python, navigation

## Structure

```
setup.sh              # entry point
install/
├── tools.sh          # base packages
├── server.sh         # security hardening
├── docker.sh         # docker install
├── postgres.sh       # postgresql
├── tmux.sh           # oh-my-tmux
└── neovim.sh         # neovim config + plugins
configs/
├── .bashrc           # shell aliases
└── nvim/
    └── init.lua      # neovim config
```
