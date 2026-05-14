# Windows Setup Guide

A step-by-step guide to setting up a fresh Windows machine for development.

## Prerequisites

- Windows 10 (21H2+) or Windows 11
- Administrator access
- Internet connection

## Automated Setup (Recommended)

Open **PowerShell as Administrator** and run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
cd path\to\this\repo\windows
.\setup.ps1
```

The script handles everything below automatically. The manual steps are provided
for reference or if you prefer to install individual components.

---

## Manual Step-by-Step

### 1. Create Folder Structure

```powershell
New-Item -ItemType Directory C:\ig_dev, C:\ig_repos, C:\ig_personal
```

### 2. Install winget (if not already available)

winget ships with Windows 11 and recent Windows 10 builds.  
If missing, install the **App Installer** from the Microsoft Store.

### 3. Install Core Applications

```powershell
# Browsers
winget install Brave.Brave
winget install Mozilla.Firefox

# Editors
winget install Microsoft.VisualStudioCode
winget install Notepad++.Notepad++

# Terminal
winget install Microsoft.WindowsTerminal
winget install Microsoft.PowerShell           # PowerShell 7

# Version Control
winget install Git.Git
winget install WinMerge.WinMerge

# File Transfer & Remote
winget install WinSCP.WinSCP
winget install TimKosse.FileZilla.Client

# Email
# Outlook is available through Microsoft 365; install from the Microsoft Store
winget install Mozilla.Thunderbird            # optional Linux-compatible client

# VPN
winget install ProtonTechnologies.ProtonVPN

# Notes
winget install Notion.Notion
# OneNote: install from the Microsoft Store

# Database
winget install DBBrowserForSQLite.DBBrowserForSQLite
winget install Oracle.MySQLWorkbench
# S3 Browser: https://s3browser.com (manual download)
```

### 4. Install Development Tools

```powershell
# Python
winget install Python.Python.3.12
pip install --upgrade uv black tox nox pytest

# pyenv-win
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" `
    -OutFile "$env:TEMP\install-pyenv-win.ps1"
& "$env:TEMP\install-pyenv-win.ps1"

# Rust
winget install Rustlang.Rustup
rustup toolchain install stable
rustup component add rustfmt clippy

# Node.js
winget install OpenJS.NodeJS.LTS
npm install -g prettier

# C toolchain
winget install cmake.cmake
# GCC via MSYS2 (https://www.msys2.org) or via winget:
winget install MSYS2.MSYS2
# Inside MSYS2: pacman -S mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-clang
```

### 5. Set Up VS Code

Copy [`vscode/settings.json`](../vscode/settings.json) to:

```
%APPDATA%\Code\User\settings.json
```

Install extensions:

```powershell
$extensions = @(
    "eamodio.gitlens",
    "bierner.markdown-mermaid",
    "esbenp.prettier-vscode",
    "redhat.vscode-yaml",
    "github.copilot",
    "github.copilot-chat",
    "ms-python.python",
    "ms-python.black-formatter",
    "ms-python.vscode-pylance",
    "rust-lang.rust-analyzer",
    "ms-vscode.cpptools",
    "xaver.clang-format",
    "ms-vscode.cmake-tools",
    "ms-vscode-remote.remote-ssh",
    "alexcvzz.vscode-sqlite",
    "streetsidesoftware.code-spell-checker",
    "usernamehw.errorlens"
)
$extensions | ForEach-Object { code --install-extension $_ --force }
```

### 6. Set Up PowerShell Profile

Copy [`windows/powershell/Microsoft.PowerShell_profile.ps1`](../windows/powershell/Microsoft.PowerShell_profile.ps1)
to the location shown by `$PROFILE` in PowerShell.

Install Oh My Posh for a nice prompt:

```powershell
winget install JanDeLaune.OhMyPosh
oh-my-posh font install Meslo
```

Then set **MesloLGM Nerd Font** in Windows Terminal settings.

### 7. Configure Git

```powershell
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
git config --global core.editor "code --wait"
git config --global core.autocrlf true
git config --global init.defaultBranch main
git config --global pull.rebase false
```

Or copy [`git/.gitconfig.template`](../git/.gitconfig.template) to `~/.gitconfig`
and fill in your details.

### 8. Generate SSH Key

```powershell
ssh-keygen -t ed25519 -C "you@example.com"
# Add the public key to GitHub: Settings → SSH and GPG keys → New SSH key
Get-Content "$env:USERPROFILE\.ssh\id_ed25519.pub"
```

### 9. Browser Extensions

Install these in Brave (and Firefox where applicable):

| Extension | Store Link |
|---|---|
| Notion Web Clipper | Chrome Web Store → Brave |
| Dark Reader | Chrome Web Store → Brave |
| Tab Manager Plus | Chrome Web Store → Brave |

### 10. Windows Terminal Dark Theme

Open Windows Terminal → Settings → Color schemes → Add:

Use a dark preset such as **One Half Dark** or import a Dracula/Catppuccin theme.

---

## What to Avoid

| App | Reason |
|---|---|
| Microsoft Office | Use OneNote / Notion for notes; LibreOffice if a suite is needed |
| Adobe products | Use free/open-source alternatives |
| Google Chrome | Use Brave (Chromium-based, privacy-first) |
| Microsoft Edge | Use Brave |
