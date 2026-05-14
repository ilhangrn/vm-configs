$PSModuleAutoLoadingPreference = 'All'

Import-Module Terminal-Icons -ErrorAction SilentlyContinue
Import-Module PSReadLine

$ompConfig = "$HOME\.config\powerlevel10k_lean.omp.json"
if ((Get-Command oh-my-posh -ErrorAction SilentlyContinue) -and (Test-Path $ompConfig)) {
	oh-my-posh init pwsh --config $ompConfig | Invoke-Expression
}

$env:PYENV = "$env:USERPROFILE\.pyenv\pyenv-win\"
$env:PYENV_ROOT = "$env:USERPROFILE\.pyenv\pyenv-win\"
$env:PYENV_HOME = "$env:USERPROFILE\.pyenv\pyenv-win\"

# Add pyenv to PATH if it's not already there
if ($env:PATH -notlike "*pyenv-win\bin*") {
    $env:PATH = "$env:PYENV\bin;$env:PYENV\shims;$env:PATH"
}
