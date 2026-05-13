# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Full development environment configuration for Windows and Linux
- `vscode/settings.json` — VS Code user settings (dark theme, formatters, language configs)
- `vscode/extensions.json` — recommended extensions (GitLens, Prettier, YAML, Copilot, etc.)
- `windows/setup.ps1` — one-shot Windows setup script (winget packages + VS Code extensions + Git config)
- `windows/powershell/Microsoft.PowerShell_profile.ps1` — PowerShell 7 profile with aliases and helpers
- `linux/setup.sh` — one-shot Ubuntu/Debian setup script
- `linux/zsh/.zshrc` — Zsh configuration with Oh My Zsh, pyenv, uv, Rust, Node helpers, and aliases
- `python/pyproject.toml` — black, pytest, mypy, ruff configuration
- `python/tox.ini` — tox environments (test, lint, type, format)
- `python/noxfile.py` — nox sessions for tests, lint, format, type check
- `rust/rustfmt.toml` — rustfmt code-style settings
- `c/.clang-format` — Clang formatter settings for C/C++
- `node/.prettierrc` — Prettier configuration for JS/TS/JSON/YAML/Markdown
- `git/.gitconfig.template` — global Git config template with aliases and VS Code integration
- `ssh/config.example` — SSH client config template (GitHub, remote servers, jump hosts)
- `nix/nixos-config.nix` — full NixOS VM configuration (dark theme, all toolchains, folder structure)
- `docs/windows-setup.md` — Windows step-by-step manual setup guide
- `docs/linux-setup.md` — Linux/Ubuntu step-by-step manual setup guide
- Updated `docs/getting-started.md` with the new purpose and structure
- Updated `README.md` with comprehensive overview of the configs repository

### Changed
- Transformed the repository from a project template into a machine-setup configuration repository

---

<!-- Add new releases above this line in the format below:

## [x.y.z] - YYYY-MM-DD

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

-->
