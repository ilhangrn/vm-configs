# Contributing

Thank you for your interest in contributing! Please follow these guidelines to keep the process smooth.

## Branching Model

| Branch | Purpose |
|---|---|
| `main` | Stable, production-ready code |
| `development` | Integration branch — all feature work merges here first |
| `feature/<name>` | New features or improvements |
| `fix/<name>` | Bug fixes |
| `chore/<name>` | Maintenance, dependency updates, docs |

## Workflow

1. **Fork** the repository (external contributors) or create a branch from `development` (team members).
2. Write your code, keeping commits small and focused.
3. Open a **Pull Request** targeting `development`.
4. Address review feedback and ensure CI passes.
5. A maintainer will merge your PR once approved.

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <short summary>

[optional body]
[optional footer]
```

Common types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`

## Code Style

- **Python**: format with `ruff` / `black`, lint with `ruff` / `flake8`, type-check with `mypy`.
- **Rust**: format with `rustfmt`, lint with `clippy`.
- **JS / TS**: format with `prettier`, lint with `eslint`.
- **Other**: follow the conventions already present in the project.

## Reporting Issues

Use the issue templates in `.github/ISSUE_TEMPLATE/` to report bugs or request features.

## License

By contributing you agree that your contributions will be licensed under the project's [Apache 2.0 License](LICENSE).
