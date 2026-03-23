# ── Navigation ──────────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah'
alias la='ls -A'

# ── Git ─────────────────────────────────────────────────────────────────────────
alias gs='git status'
alias gl='git log --oneline --graph --decorate'
alias gp='git push'
alias gpl='git pull'

# ── Python ──────────────────────────────────────────────────────────────────────
alias python='python3'
alias pip='pip3'
alias venv='python3 -m venv venv && source venv/bin/activate'

# ── Docker ──────────────────────────────────────────────────────────────────────
alias dps='docker ps'
alias dlog='docker logs -f'
alias dex='docker exec -it'

# ── PATH ────────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"
