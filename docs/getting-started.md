# Getting Started

This repository contains configuration files and setup scripts to bootstrap a
fresh development machine quickly. Pick the guide for your operating system:

| Platform | Guide |
|---|---|
| Windows | [docs/windows-setup.md](windows-setup.md) |
| Linux / Ubuntu | [docs/linux-setup.md](linux-setup.md) |
| NixOS VM | [`nix/nixos-config.nix`](../nix/nixos-config.nix) |

---

## 1. Clone This Repository

```bash
git clone https://github.com/ilhangrn/configs.git
cd configs
```

## 2. Run the Setup Script

### Windows (PowerShell as Administrator)

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\windows\setup.ps1
```

### Linux / Ubuntu

```bash
bash linux/setup.sh
```

Both scripts will:
1. Create the standard folder structure
2. Install all required applications and tools
3. Configure Git, Zsh/PowerShell, and VS Code
4. Generate an SSH key pair (if one doesn't exist)

---

## 3. Apply Config Files Manually (optional)

If you only want specific configs without running the full setup:

| Config | Source | Destination |
|---|---|---|
| VS Code settings | `vscode/settings.json` | `%APPDATA%\Code\User\settings.json` (Win) or `~/.config/Code/User/settings.json` (Linux) |
| PowerShell profile | `windows/powershell/Microsoft.PowerShell_profile.ps1` | Path shown by `$PROFILE` |
| Zsh config | `linux/zsh/.zshrc` | `~/.zshrc` |
| Git config | `git/.gitconfig.template` | `~/.gitconfig` (fill in your details) |
| SSH config | `ssh/config.example` | `~/.ssh/config` |
| Python (black/pytest) | `python/pyproject.toml` | project root |
| Python (tox) | `python/tox.ini` | project root |
| Python (nox) | `python/noxfile.py` | project root |
| Rust format | `rust/rustfmt.toml` | project root or `~/.rustfmt.toml` |
| C format | `c/.clang-format` | project root |
| Prettier | `node/.prettierrc` | project root |

---

## 4. Project Branching Model

| Branch | Purpose |
|---|---|
| `main` | Stable, production-ready |
| `development` | Active integration branch |

```bash
git checkout -b development
git push -u origin development
```

---

## 5. Enable CI

The `.github/workflows/ci.yml` file contains pre-written steps for each language.  
Uncomment the relevant block for your project type.

---

## 6. Next Steps

- Sign in to **GitHub Copilot** in VS Code (`Ctrl+Shift+P` → `GitHub Copilot: Sign In`).
- Configure **ProtonVPN** with your account.
- Add your SSH public key to GitHub: Settings → SSH and GPG keys.
- Install **Brave** browser extensions: Notion, Dark Reader, Tab Manager Plus.
- Import branch-protection rulesets from `centa_ruleset.json`.
