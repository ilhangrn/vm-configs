#!/usr/bin/env zsh
# =============================================================================
# Zsh Configuration (~/.zshrc)
# =============================================================================

# ─── History ─────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY

# ─── Oh My Zsh ───────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"   # dark-friendly theme; alternatives: powerlevel10k/powerlevel10k

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    pyenv
    rust
    node
    ssh-agent
    colored-man-pages
    command-not-found
)

[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# ─── Environment Variables ───────────────────────────────────────────────────
export EDITOR="nano"
export VISUAL="code"
export GIT_EDITOR="code --wait"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ─── pyenv ───────────────────────────────────────────────────────────────────
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv &>/dev/null && eval "$(pyenv init -)"

# ─── uv (fast Python package installer) ──────────────────────────────────────
export PATH="$HOME/.cargo/bin:$PATH"   # uv is distributed as a Rust binary
command -v uv &>/dev/null && eval "$(uv generate-shell-completion zsh)"

# ─── Rust / Cargo ────────────────────────────────────────────────────────────
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
[[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env"

# ─── Node ────────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# ─── Folder Shortcuts ─────────────────────────────────────────────────────────
export IG_DEV="$HOME/ig_one/ig_dev"
export IG_REPOS="$HOME/ig_one/ig_repos"
export IG_PERSONAL="$HOME/ig_one/ig_personal"

# ─── Aliases ─────────────────────────────────────────────────────────────────
# Navigation
alias dev="cd $IG_DEV"
alias repos="cd $IG_REPOS"
alias personal="cd $IG_PERSONAL"
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -lAh --color=auto"
alias la="ls -A --color=auto"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias glog="git log --oneline --graph --decorate --all"
alias gd="git diff"
alias gb="git branch -a"
alias gco="git checkout"

# Python
alias python="python3"
alias pip="pip3"
alias venv="python3 -m venv .venv && source .venv/bin/activate"
alias activate="source .venv/bin/activate"
alias deactivate="deactivate"
alias black="python3 -m black"
alias pytest="python3 -m pytest"

# Rust
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias cf="cargo fmt"
alias cc="cargo clippy"

# Editor
alias c="code ."
alias n="nano"

# System
alias ports="ss -tulnp"
alias myip="curl -s https://api.ipify.org && echo"
alias update="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"

# ─── Functions ───────────────────────────────────────────────────────────────
mkcd() { mkdir -p "$1" && cd "$1" }

# Create and activate a Python venv with a given name (default: .venv)
pyvenv() {
    local name="${1:-.venv}"
    python3 -m venv "$name"
    source "$name/bin/activate"
}

# Quick git clone into ig_repos
gclone() { git clone "$1" "$IG_REPOS/$(basename "$1" .git)" }

# SSH helper
sshadd() { ssh-add "$HOME/.ssh/${1:-id_rsa}" }
