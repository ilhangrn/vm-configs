# Getting Started

This is a template repository. Follow these steps to spin up a new project from it.

## 1. Use the Template

Click **"Use this template"** on GitHub and create a new repository for your project.

## 2. Clone Your New Repo

```bash
git clone https://github.com/<org>/<your-repo>.git
cd <your-repo>
```

## 3. Set Up Your Development Branch

The branching model uses two core branches:

| Branch | Purpose |
|---|---|
| `main` | Stable, production-ready |
| `development` | Active integration branch |

If `development` doesn't exist yet:

```bash
git checkout -b development
git push -u origin development
```

## 4. Project Type Quick-Start

### Python
```bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

### Rust
```bash
cargo new my_project
cd my_project
cargo run
```

### Web (Node / TypeScript)
```bash
npm create vite@latest my-app
cd my-app
npm install
npm run dev
```

### Mobile (Flutter)
```bash
flutter create my_app
cd my_app
flutter run
```

### AI / ML (Python)
```bash
python -m venv .venv
source .venv/bin/activate
pip install torch transformers datasets
```

### Agentic / LLM Applications
```bash
python -m venv .venv
source .venv/bin/activate
pip install openai anthropic langchain
```

## 5. Enable CI

The `.github/workflows/ci.yml` file contains pre-written steps for each language.  
Uncomment the relevant block for your project type.

## 6. Next Steps

- Update `README.md` with your project's details.
- Review `CONTRIBUTING.md` and adjust to your team's workflow.
- Add environment-specific config files (`.env.example`, `config/`, etc.).
- Configure branch protection rulesets in GitHub repository settings.
