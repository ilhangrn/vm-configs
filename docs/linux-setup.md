# Linux / Ubuntu Setup Guide

A step-by-step guide to setting up a fresh Ubuntu (22.04+) machine for development.

## Prerequisites

- Ubuntu 22.04 LTS or 24.04 LTS (or any Debian-based distro)
- `sudo` access
- Internet connection

## Automated Setup (Recommended)

```bash
bash linux/setup.sh
```

The script handles everything below automatically. The manual steps are provided
for reference or if you prefer to install individual components.

---

## Manual Step-by-Step

### 1. Update System

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git build-essential
```

### 2. Create Folder Structure

```bash
mkdir -p ~/ig_one/{ig_dev,ig_repos,ig_personal}
```

### 3. Install Zsh & Oh My Zsh

```bash
sudo apt install -y zsh

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Useful plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Set zsh as default shell
chsh -s $(which zsh)
```

Copy [`.zshrc`](../linux/zsh/.zshrc) to `~/.zshrc` and restart your terminal.

### 4. Install VS Code

```bash
wget -qO /tmp/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo dpkg -i /tmp/code.deb && sudo apt install -f -y
rm /tmp/code.deb
```

Copy [`vscode/settings.json`](../vscode/settings.json) to:

```bash
cp vscode/settings.json ~/.config/Code/User/settings.json
```

Install extensions:

```bash
extensions=(
    eamodio.gitlens
    bierner.markdown-mermaid
    esbenp.prettier-vscode
    redhat.vscode-yaml
    github.copilot
    github.copilot-chat
    ms-python.python
    ms-python.black-formatter
    ms-python.vscode-pylance
    rust-lang.rust-analyzer
    ms-vscode.cpptools
    xaver.clang-format
    ms-vscode.cmake-tools
    ms-vscode-remote.remote-ssh
    alexcvzz.vscode-sqlite
    streetsidesoftware.code-spell-checker
    usernamehw.errorlens
)
for ext in "${extensions[@]}"; do code --install-extension "$ext" --force; done
```

### 5. Install Python Toolchain

```bash
# pyenv
curl https://pyenv.run | bash

# Reload shell, then:
pyenv install 3.12.0
pyenv global 3.12.0

# uv (fast package installer)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Python tools
pip install --upgrade black tox nox pytest
```

### 6. Install Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
rustup component add rustfmt clippy
```

### 7. Install C Toolchain

```bash
sudo apt install -y gcc g++ clang cmake clang-format
```

For embedded development (QEMU / Wokwi):

```bash
sudo apt install -y qemu qemu-system
# Wokwi CLI: https://docs.wokwi.com/wokwi-ci/getting-started
```

### 8. Install Node.js

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# Reload shell, then:
nvm install --lts
nvm use --lts
npm install -g prettier
```

### 9. Configure Git

```bash
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
git config --global core.editor "nano"
git config --global core.autocrlf input
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global color.ui auto
```

Or copy [`git/.gitconfig.template`](../git/.gitconfig.template) to `~/.gitconfig`
and fill in your details.

### 10. Generate SSH Key

```bash
ssh-keygen -t ed25519 -C "you@example.com"
# Add the public key to GitHub: Settings → SSH and GPG keys → New SSH key
cat ~/.ssh/id_ed25519.pub
```

Copy [`ssh/config.example`](../ssh/config.example) to `~/.ssh/config` and adjust:

```bash
cp ssh/config.example ~/.ssh/config
chmod 600 ~/.ssh/config
```

### 11. Install Brave Browser

```bash
curl -fsS https://dl.brave.com/install.sh | sh
```

### 12. Install ProtonVPN

```bash
wget -qO /tmp/protonvpn.deb \
    "https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb"
sudo dpkg -i /tmp/protonvpn.deb
sudo apt update && sudo apt install -y proton-vpn-gnome-desktop
```

### 13. Install Additional Apps

```bash
# Email
sudo apt install -y thunderbird

# File Transfer
sudo apt install -y filezilla

# Database tools
sudo apt install -y sqlite3 sqlitebrowser
# MySQL Workbench
sudo apt install -y mysql-workbench
# S3 Browser (AppImage): https://s3browser.com/linux.aspx

# Notion (Flatpak)
flatpak install flathub com.notion.Notion
```

### 14. Browser Extensions

Install these in Brave:

| Extension | Purpose |
|---|---|
| Notion Web Clipper | Save web pages to Notion |
| Dark Reader | Force dark mode on any site |
| Tab Manager Plus | Organise open tabs |

### 15. Enable Dark Theme (GNOME)

```bash
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
```

---

## What to Avoid

| App | Reason |
|---|---|
| Microsoft Office | Use LibreOffice + Notion/OneNote |
| Adobe products | Use free/open-source alternatives |
| Google Chrome | Use Brave (Chromium-based, privacy-first) |

---

## NixOS / VM Setup

For a fully reproducible environment see [`nix/nixos-config.nix`](../nix/nixos-config.nix).
