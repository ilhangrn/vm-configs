#!/usr/bin/env bash
# =============================================================================
# Linux / Ubuntu Machine Setup Script
# Usage: bash setup.sh [username]
# =============================================================================

set -euo pipefail

USERNAME="${1:-$USER}"
IG_BASE="$HOME/ig_one"

print_step() { echo -e "\n\033[1;36m==> $*\033[0m"; }
print_ok()   { echo -e "  \033[0;32m✓\033[0m $*"; }
print_warn() { echo -e "  \033[0;33m⚠\033[0m $*"; }

# ─── 1. Update System ─────────────────────────────────────────────────────────
print_step "Updating system packages"
sudo apt update -qq && sudo apt upgrade -y -qq
sudo apt autoremove -y -qq
print_ok "System updated"

# ─── 2. Install Core Packages ─────────────────────────────────────────────────
print_step "Installing core packages"
sudo apt install -y -qq \
    curl wget git zsh nano build-essential \
    cmake gcc g++ clang clang-format \
    pkg-config libssl-dev \
    sqlite3 \
    ssh openssh-client \
    xclip xdg-utils \
    unzip zip tar \
    filezilla \
    thunderbird
print_ok "Core packages installed"

# ─── 3. Create Folder Structure ───────────────────────────────────────────────
print_step "Creating folder structure under $IG_BASE"
mkdir -p "$IG_BASE/ig_dev" "$IG_BASE/ig_repos" "$IG_BASE/ig_personal"
print_ok "Folders created: ig_dev, ig_repos, ig_personal"

# ─── 4. Install Zsh & Oh My Zsh ──────────────────────────────────────────────
print_step "Setting up Zsh & Oh My Zsh"
if ! command -v zsh &>/dev/null; then
    sudo apt install -y -qq zsh
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no CHSH=no sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    print_ok "Oh My Zsh installed"
else
    print_ok "Oh My Zsh already present"
fi

# zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    git clone --quiet https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Copy .zshrc
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/zsh/.zshrc" ]]; then
    cp "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
    print_ok ".zshrc copied"
fi

# Set zsh as default shell
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
    chsh -s "$(command -v zsh)" "$USERNAME"
    print_ok "Default shell set to zsh (re-login required)"
fi

# ─── 5. Install pyenv ─────────────────────────────────────────────────────────
print_step "Installing pyenv"
if [[ ! -d "$HOME/.pyenv" ]]; then
    curl -fsSL https://pyenv.run | bash
    print_ok "pyenv installed"
else
    print_ok "pyenv already present"
fi

# ─── 6. Install uv (fast Python package manager) ─────────────────────────────
print_step "Installing uv"
if ! command -v uv &>/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    print_ok "uv installed"
else
    print_ok "uv already present"
fi

# ─── 7. Install Python Tools ──────────────────────────────────────────────────
print_step "Installing Python tools (black, tox, nox, pytest)"
if command -v pip3 &>/dev/null; then
    pip3 install --quiet --upgrade black tox nox pytest
    print_ok "Python tools installed"
else
    print_warn "pip3 not available; install Python first via pyenv, then re-run"
fi

# ─── 8. Install Rust ──────────────────────────────────────────────────────────
print_step "Installing Rust via rustup"
if ! command -v rustup &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --quiet
    source "$HOME/.cargo/env"
    print_ok "rustup + Rust stable installed"
else
    rustup update stable --quiet
    print_ok "Rust updated"
fi
rustup component add rustfmt clippy
print_ok "rustfmt and clippy installed"

# ─── 9. Install Node.js via nvm ───────────────────────────────────────────────
print_step "Installing Node.js via nvm"
if [[ ! -d "$HOME/.nvm" ]]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    # shellcheck source=/dev/null
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
    print_ok "Node.js LTS installed via nvm"
else
    print_ok "nvm already present"
fi

# ─── 10. Install VS Code ──────────────────────────────────────────────────────
print_step "Installing VS Code"
if ! command -v code &>/dev/null; then
    wget -qO /tmp/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    sudo dpkg -i /tmp/code.deb
    sudo apt install -f -y -qq
    rm -f /tmp/code.deb
    print_ok "VS Code installed"
else
    print_ok "VS Code already present"
fi

# Install VS Code extensions
print_step "Installing VS Code extensions"
EXTENSIONS=(
    "eamodio.gitlens"
    "bierner.markdown-mermaid"
    "esbenp.prettier-vscode"
    "redhat.vscode-yaml"
    "github.copilot"
    "github.copilot-chat"
    "ms-python.python"
    "ms-python.black-formatter"
    "ms-python.vscode-pylance"
    "rust-lang.rust-analyzer"
    "ms-vscode.cpptools"
    "xaver.clang-format"
    "ms-vscode.cmake-tools"
    "ms-vscode-remote.remote-ssh"
    "alexcvzz.vscode-sqlite"
    "streetsidesoftware.code-spell-checker"
    "usernamehw.errorlens"
)
if command -v code &>/dev/null; then
    for ext in "${EXTENSIONS[@]}"; do
        code --install-extension "$ext" --force &>/dev/null
        print_ok "  $ext"
    done
fi

# ─── 11. Install Brave Browser ────────────────────────────────────────────────
print_step "Installing Brave Browser"
if ! command -v brave-browser &>/dev/null; then
    curl -fsS https://dl.brave.com/install.sh | sh &>/dev/null
    print_ok "Brave installed"
else
    print_ok "Brave already present"
fi

# ─── 12. Install ProtonVPN ────────────────────────────────────────────────────
print_step "Installing ProtonVPN"
if ! command -v protonvpn-app &>/dev/null; then
    wget -qO /tmp/protonvpn.deb "https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb"
    sudo dpkg -i /tmp/protonvpn.deb &>/dev/null || true
    sudo apt update -qq && sudo apt install -y -qq proton-vpn-gnome-desktop
    rm -f /tmp/protonvpn.deb
    print_ok "ProtonVPN installed"
else
    print_ok "ProtonVPN already present"
fi

# ─── 13. Configure Git ────────────────────────────────────────────────────────
print_step "Configuring Git"
read -r -p "  Enter your Git user.name: " GIT_NAME
read -r -p "  Enter your Git user.email: " GIT_EMAIL

git config --global user.name  "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global core.editor "nano"
git config --global core.autocrlf input
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global color.ui auto
print_ok "Git configured"

# Copy git config
if [[ -f "$SCRIPT_DIR/../git/.gitconfig.template" ]]; then
    cp "$SCRIPT_DIR/../git/.gitconfig.template" "$HOME/.gitconfig.template"
fi

# ─── 14. SSH Setup ────────────────────────────────────────────────────────────
print_step "Setting up SSH"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""
    print_ok "SSH key generated: $HOME/.ssh/id_ed25519.pub"
    echo ""
    echo "  Add this key to GitHub → Settings → SSH keys:"
    cat "$HOME/.ssh/id_ed25519.pub"
else
    print_ok "SSH key already exists"
fi

print_step "Setup complete!"
echo -e "\033[0;32mRestart your terminal (or run: exec zsh) to activate all settings.\033[0m"
