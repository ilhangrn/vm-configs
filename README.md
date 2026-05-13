# configs

> **One-stop configuration repository** — everything needed to set up a fresh
> development machine (Windows or Linux) and be productive in minutes.

## Philosophy

| Preference | Choice |
|---|---|
| Theme | Always **dark** |
| Code editor | **VS Code** |
| Windows terminal | **PowerShell 7** |
| Linux terminal | **Zsh** (Oh My Zsh) |
| Text editor | **Notepad++** (Windows) · **nano** (Linux) |
| AI assistants | **GitHub Copilot** · opencode Zen models |
| Browser | **Brave** (primary) · Firefox (secondary) |
| VPN | **ProtonVPN** |
| Notes | **OneNote** · Notion |
| Email | **Thunderbird** (Linux) · Outlook (Windows) |
| Search | **Google** |

## Repository Structure

```
configs/
├── .github/                          # GitHub workflows & templates
├── docs/
│   ├── getting-started.md            # Quickstart guide
│   ├── windows-setup.md              # Windows step-by-step
│   └── linux-setup.md                # Linux / Ubuntu step-by-step
│
├── vscode/
│   ├── settings.json                 # VS Code user settings (dark theme, formatters…)
│   └── extensions.json               # Recommended extensions list
│
├── windows/
│   ├── setup.ps1                     # One-shot Windows setup script (winget + config)
│   └── powershell/
│       └── Microsoft.PowerShell_profile.ps1   # PowerShell profile
│
├── linux/
│   ├── setup.sh                      # One-shot Ubuntu/Debian setup script
│   └── zsh/
│       └── .zshrc                    # Zsh configuration
│
├── python/
│   ├── pyproject.toml                # black, pytest, mypy, ruff settings
│   ├── tox.ini                       # tox environments (test, lint, type)
│   └── noxfile.py                    # nox sessions (tests, lint, format, type_check)
│
├── rust/
│   └── rustfmt.toml                  # Rustfmt style settings
│
├── c/
│   └── .clang-format                 # Clang formatter settings
│
├── node/
│   └── .prettierrc                   # Prettier configuration
│
├── git/
│   └── .gitconfig.template           # Global Git config template
│
├── ssh/
│   └── config.example               # SSH client config template
│
├── nix/
│   └── nixos-config.nix             # Full NixOS VM configuration
│
├── centa_ruleset.json               # GitHub branch-protection rulesets
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## Quick Start

### Windows

```powershell
# From an elevated PowerShell session
Set-ExecutionPolicy Bypass -Scope Process -Force
.\windows\setup.ps1
```

The script installs: Brave, Firefox, VS Code, Notepad++, Git, WinMerge, PowerShell 7,
Python, Rust, Node.js, CMake, WinSCP, FileZilla, Thunderbird, DB Browser for SQLite,
MySQL Workbench, ProtonVPN, and all VS Code extensions.

### Linux / Ubuntu

```bash
bash linux/setup.sh
```

The script installs: Brave, VS Code, Git, Zsh + Oh My Zsh, pyenv, uv, Rust, Node.js,
CMake, clang-format, FileZilla, Thunderbird, ProtonVPN, and all VS Code extensions.

### VS Code Only

Copy **`vscode/settings.json`** to your VS Code user settings and install extensions
listed in **`vscode/extensions.json`**:

```bash
cat vscode/extensions.json | python3 -c \
  "import json,sys; [print(e) for e in json.load(sys.stdin)['recommendations']]" \
  | xargs -I{} code --install-extension {}
```

### NixOS VM

```bash
nixos-rebuild switch --flake .#ig-dev-vm
```

See [`nix/nixos-config.nix`](nix/nixos-config.nix) for the full reproducible VM definition.

## Folder Structure

| Platform | Paths |
|---|---|
| Windows | `C:\ig_dev` · `C:\ig_repos` · `C:\ig_personal` |
| Linux | `~/ig_one/ig_dev` · `~/ig_one/ig_repos` · `~/ig_one/ig_personal` |

## VS Code Extensions

| Extension | Purpose |
|---|---|
| GitLens | Advanced Git blame, history, and insights |
| Markdown Preview Mermaid Support | Render Mermaid diagrams in Markdown preview |
| Prettier | Code formatting (JS/TS/JSON/YAML/Markdown) |
| YAML | Schema validation and formatting for YAML |
| GitHub Copilot + Chat | AI code completion and chat |
| Python + Black + Pylance | Python development and formatting |
| Rust Analyzer | Rust language server |
| clangd / Clang Format | C/C++ formatting |
| Remote - SSH | Connect to remote servers via VS Code |

## Browser Extensions

| Extension | Purpose |
|---|---|
| Notion Web Clipper | Save pages to Notion |
| Dark Reader | Force dark mode on any website |
| Tab Manager Plus | Organise and search open tabs |

## Toolchains at a Glance

| Language | Tools |
|---|---|
| Python | pyenv · uv · venv · black · tox · nox · pytest |
| Rust | rustup · cargo · rustfmt · clippy |
| C | gcc · clang · cmake · clang-format · QEMU · Wokwi |
| Node.js | nvm · npm · Prettier |
| CI/CD | Git · GitHub Actions · hooks · WinMerge |
| Database | SQLite · DB Browser for SQLite · MySQL Workbench · S3 Browser |
| Server | SSH · WinSCP · FileZilla |

## Branch Protection

`centa_ruleset.json` contains two GitHub rulesets:

| Ruleset | Target | What it enforces |
|---|---|---|
| `centa-main-protection` | `main` | PRs only from `development`; 1 approval; CI pass; linear history |
| `centa-development-protection` | `development` | PRs required; 1 approval; CI pass |

**Import:** Repository → Settings → Rules → Rulesets → New ruleset → Import ruleset.

## License

[Apache 2.0](LICENSE)
