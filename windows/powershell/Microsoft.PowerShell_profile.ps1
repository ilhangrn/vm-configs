# =============================================================================
# Windows PowerShell Profile
# Location: $PROFILE  (usually C:\Users\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1)
# =============================================================================

# ─── Prompt ──────────────────────────────────────────────────────────────────
# Install Oh My Posh if not present:
#   winget install JanDeLaune.OhMyPosh
#   oh-my-posh font install Meslo  (then set the font in Windows Terminal)
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
}

# ─── Useful Aliases ──────────────────────────────────────────────────────────
Set-Alias -Name grep   -Value Select-String
Set-Alias -Name which  -Value Get-Command
Set-Alias -Name touch  -Value New-Item
Set-Alias -Name open   -Value explorer.exe
Set-Alias -Name python -Value python3   -ErrorAction SilentlyContinue

# ─── Environment Variables ───────────────────────────────────────────────────
$env:EDITOR        = "code"
$env:VISUAL        = "code"
$env:GIT_EDITOR    = "code --wait"
# Rust / Cargo
$env:CARGO_HOME    = "$env:USERPROFILE\.cargo"
$env:RUSTUP_HOME   = "$env:USERPROFILE\.rustup"
# Add Cargo bin to PATH if not already present
if ($env:PATH -notmatch [regex]::Escape("$env:CARGO_HOME\bin")) {
    $env:PATH += ";$env:CARGO_HOME\bin"
}

# ─── Helper Functions ────────────────────────────────────────────────────────
function mkcd { param([string]$dir) New-Item -ItemType Directory -Force -Path $dir | Set-Location }
function gs   { git status }
function ga   { git add @args }
function gc   { git commit -m @args }
function gp   { git push @args }
function gl   { git pull @args }
function glog { git log --oneline --graph --decorate --all }

# Python helpers
function venv {
    param([string]$name = ".venv")
    python -m venv $name
    & "$name\Scripts\Activate.ps1"
}
function activate {
    param([string]$name = ".venv")
    & "$name\Scripts\Activate.ps1"
}

Write-Host "PowerShell profile loaded." -ForegroundColor Cyan
