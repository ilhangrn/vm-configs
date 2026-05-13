# templateRepo

A clean, multi-purpose project template for **Python · Rust · Web · Mobile · AI/ML · Agentic** solutions.

## Repository Structure

```
templateRepo/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md        # Bug report template
│   │   └── feature_request.md  # Feature request template
│   ├── workflows/
│   │   └── ci.yml               # CI pipeline (enable steps for your stack)
│   └── PULL_REQUEST_TEMPLATE.md
├── docs/
│   └── getting-started.md       # Step-by-step setup guide
├── .gitignore                   # Covers Python, Rust, Web, Mobile, AI/ML
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE                      # Apache 2.0
└── README.md
```

## Branching Model

| Branch | Purpose |
|---|---|
| `main` | Stable, production-ready code |
| `development` | Active integration — all feature branches merge here first |

## Quick Start

1. Click **"Use this template"** to create a new repository.
2. See **[docs/getting-started.md](docs/getting-started.md)** for language-specific setup steps.
3. Uncomment the relevant block in **`.github/workflows/ci.yml`** for your stack.
4. Configure branch-protection rulesets in your repository settings.

## Supported Stacks

| Domain | Key Tools |
|---|---|
| Python | pip, venv, ruff, mypy, pytest |
| Rust | cargo, rustfmt, clippy |
| Web | Node, Vite, TypeScript, ESLint, Prettier |
| Mobile | Flutter / React Native |
| AI / ML | PyTorch, Transformers, LangChain |
| Agentic | OpenAI, Anthropic, LangGraph |

## License

[Apache 2.0](LICENSE)
