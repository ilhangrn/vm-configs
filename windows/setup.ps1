#!/usr/bin/env pwsh
# =============================================================================
# Windows Machine Setup Script
# Run from an elevated PowerShell session:
#   Set-ExecutionPolicy Bypass -Scope Process -Force
#   .\setup.ps1
# =============================================================================

param(
    [string]$Username = $env:USERNAME
)

$ErrorActionPreference = "Stop"

function Print-Step { param([string]$msg) Write-Host "`n==> $msg" -ForegroundColor Cyan }

# ─── 1. Create Folder Structure ──────────────────────────────────────────────
Print-Step "Creating folder structure"
@("C:\ig_dev", "C:\ig_repos", "C:\ig_personal") | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ | Out-Null
        Write-Host "  Created: $_"
    } else {
        Write-Host "  Exists:  $_"
    }
}

# ─── 2. Install Winget Packages ──────────────────────────────────────────────
Print-Step "Installing applications via winget"

$packages = @(
    # Browsers
    @{ id = "Brave.Brave";                  name = "Brave Browser" },
    @{ id = "Mozilla.Firefox";              name = "Firefox" },

    # Editors & IDEs
    @{ id = "Microsoft.VisualStudioCode";   name = "VS Code" },
    @{ id = "Notepad++.Notepad++";          name = "Notepad++" },

    # Version Control
    @{ id = "Git.Git";                      name = "Git" },
    @{ id = "WinMerge.WinMerge";            name = "WinMerge" },

    # Terminal
    @{ id = "Microsoft.WindowsTerminal";    name = "Windows Terminal" },
    @{ id = "Microsoft.PowerShell";         name = "PowerShell 7" },

    # Languages & Runtimes
    @{ id = "Python.Python.3.12";           name = "Python 3.12" },
    @{ id = "Rustlang.Rustup";              name = "Rustup (Rust)" },
    @{ id = "OpenJS.NodeJS.LTS";            name = "Node.js LTS" },
    @{ id = "cmake.cmake";                  name = "CMake" },

    # AI & Cloud
    @{ id = "GitHub.GitHubDesktop";         name = "GitHub Desktop" },

    # Communication & Notes
    @{ id = "Microsoft.Teams";              name = "Teams" },
    @{ id = "XPFFTQ037JWVOF";              name = "OneNote" },   # MS Store
    @{ id = "Notion.Notion";               name = "Notion" },
    @{ id = "Mozilla.Thunderbird";          name = "Thunderbird" },

    # File Transfer & Remote
    @{ id = "WinSCP.WinSCP";               name = "WinSCP" },
    @{ id = "TimKosse.FileZilla.Client";    name = "FileZilla" },

    # Database Tools
    @{ id = "DBBrowserForSQLite.DBBrowserForSQLite"; name = "DB Browser for SQLite" },
    @{ id = "Oracle.MySQLWorkbench";        name = "MySQL Workbench" },

    # VPN
    @{ id = "ProtonTechnologies.ProtonVPN"; name = "ProtonVPN" },

    # Utilities
    @{ id = "JanDeLaune.OhMyPosh";         name = "Oh My Posh" }
)

foreach ($pkg in $packages) {
    Write-Host "  Installing $($pkg.name)..."
    winget install --id $pkg.id --silent --accept-source-agreements --accept-package-agreements 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "  Could not install $($pkg.name) (may already be installed or unavailable)"
    }
}

# ─── 3. Install Rust Toolchain ────────────────────────────────────────────────
Print-Step "Configuring Rust toolchain"
if (Get-Command rustup -ErrorAction SilentlyContinue) {
    rustup toolchain install stable
    rustup component add rustfmt clippy
    Write-Host "  Rust stable toolchain ready"
} else {
    Write-Warning "  rustup not found; install it via winget and re-run"
}

# ─── 4. Install Python Global Tools (uv, pyenv-win) ─────────────────────────
Print-Step "Installing Python tools"
if (Get-Command pip -ErrorAction SilentlyContinue) {
    pip install --upgrade uv black tox nox pytest 2>$null
}
# pyenv-win
$pyenvDir = "$env:USERPROFILE\.pyenv"
if (-not (Test-Path $pyenvDir)) {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" `
        -OutFile "$env:TEMP\install-pyenv-win.ps1"
    & "$env:TEMP\install-pyenv-win.ps1"
    Write-Host "  pyenv-win installed"
}

# ─── 5. Install VS Code Extensions ───────────────────────────────────────────
Print-Step "Installing VS Code extensions"
if (Get-Command code -ErrorAction SilentlyContinue) {
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
    foreach ($ext in $extensions) {
        code --install-extension $ext --force 2>$null
        Write-Host "  Installed: $ext"
    }
} else {
    Write-Warning "  VS Code 'code' CLI not found; add it to PATH manually"
}

# ─── 6. Copy PowerShell Profile ───────────────────────────────────────────────
Print-Step "Setting up PowerShell profile"
$profileDir = Split-Path $PROFILE
if (-not (Test-Path $profileDir)) { New-Item -ItemType Directory -Path $profileDir | Out-Null }
$src = Join-Path $PSScriptRoot "powershell\Microsoft.PowerShell_profile.ps1"
if (Test-Path $src) {
    Copy-Item $src $PROFILE -Force
    Write-Host "  Profile copied to $PROFILE"
}

# ─── 7. Configure Git ─────────────────────────────────────────────────────────
Print-Step "Configuring Git"
$gitName  = Read-Host "Enter your Git user.name (e.g. John Doe)"
$gitEmail = Read-Host "Enter your Git user.email"
git config --global user.name  "$gitName"
git config --global user.email "$gitEmail"
git config --global core.editor "code --wait"
git config --global core.autocrlf true
git config --global init.defaultBranch main
git config --global pull.rebase false
Write-Host "  Git configured"

Print-Step "Setup complete!"
Write-Host "Restart your terminal and open VS Code to get started." -ForegroundColor Green
