# Copilot Instructions (Balanced Reusable Baseline)

Use this as the default for most repositories. It is intentionally practical: specific enough to guide implementation quality, but generic enough to reuse across projects.

## Core Engineering Principles

- Prefer small, safe, incremental changes that are easy to review and rollback.
- Reuse existing modules and conventions before introducing new patterns.
- Keep architecture layered: interface layer (API/UI), domain logic, data access.
- Centralize configuration and runtime flags; avoid scattered constants and ad-hoc environment lookups.
- Keep behavior deterministic and observable with useful logs, health checks, and explicit error handling.

## Architecture and Contracts

- Treat API request/response schemas and shared enums as contracts; version or coordinate updates across all consumers.
- Keep frontend request parameters aligned with backend expectations.
- Isolate data ingestion/staging from serving/storage optimized for API reads.
- Prefer shared query/data-access modules over inline SQL in handlers.
- Keep path and filesystem handling centralized through helper modules rather than hard-coded absolute paths.

## Security and Access Control

- Enforce authentication and authorization on the server for every protected endpoint.
- Never rely on client-side gating as the source of truth.
- Validate and sanitize external input at boundaries (HTTP, files, queues, integrations).
- Keep secrets out of code; use approved config or secret-management layers.
- Use least-privilege defaults for service roles and endpoint access policies.

## Reliability and Operations

- Provide a health endpoint and document service-level smoke checks.
- Use explicit timeouts/retries/backoff for network and IO operations.
- Keep restart/deploy scripts deterministic and idempotent where practical.
- Rotate logs and avoid noisy logging that obscures production signals.
- Keep one documented local run path and one production-parity run path.

## Testing and Quality Gates

- Add or update tests for new features and bug fixes when feasible.
- Keep one documented test command for quick local verification.
- Run formatter, linter, and tests before commit.
- Pin dependencies and keep lock/requirements files deterministic.
- Treat warnings as actionable unless intentionally documented.

## Language-Specific Guidelines

### Python

- Follow PEP 8 naming and structure conventions.
- Format Python with black -S when the repository standard uses it.
- Use ruff/flake8 (or the repo default linter) to catch correctness and style issues.
- Prefer type hints at module boundaries and critical domain logic.
- Keep modules cohesive; avoid large files that mix API, business, and persistence logic.

### JavaScript / TypeScript

- Use prettier/eslint (or the repo defaults) and keep formatting automated.
- Favor explicit types in TypeScript, especially for API contracts and shared models.
- Keep async flows explicit; handle promise rejections and network failures.
- Avoid state mutation patterns that make UI behavior hard to reason about.

### SQL and Data Access

- Keep data-access code centralized and parameterized.
- Avoid N+1 patterns and unbounded queries on hot paths.
- Add indexes based on measured query behavior, not assumptions.
- Keep migration/data-update scripts repeatable and safe to rerun.

## Coding Style and Maintainability

- Prefer clarity over cleverness; avoid dense one-liners and hidden side effects.
- Use descriptive names for functions, variables, and modules.
- Keep functions focused and short enough to understand without scrolling excessively.
- Add comments/docstrings for non-obvious decisions, constraints, or invariants.
- Reduce deep nesting by extracting helper functions.
- Avoid global mutable state unless there is a documented reason.

## Do / Avoid

Do:
- Do keep commits focused on one intent (feature, fix, or refactor).
- Do preserve backward compatibility where required, or document breaking changes clearly.
- Do validate inputs early and return actionable errors.
- Do use structured, searchable logs for key operational events.
- Do prefer shared utilities and helpers to eliminate duplication.
- Do keep docs and runbooks aligned with behavior-changing code.
- Do profile before optimizing and optimize bottlenecks that are measured.
- Do ensure feature flags/config toggles are explicit and environment-safe.

Avoid:
- Avoid hard-coded credentials, absolute paths, and environment-specific assumptions.
- Avoid copy-paste logic and ad-hoc bypasses around established abstractions.
- Avoid broad exception swallowing and silent fallback behavior.
- Avoid mixing unrelated refactors with functional changes in the same PR.
- Avoid introducing dependencies without clear maintenance and security justification.
- Avoid unbounded loops, blocking calls in async paths, and missing timeout controls.
- Avoid client-only access checks for protected actions.
- Avoid over-optimization that harms readability and maintainability.

## Project Appendix (Fill Per Repository)

- Dev command:
- Test command:
- Build command:
- Deploy/restart command:
- Key folders and ownership:
- Auth model and role rules:
- Data stores and migration workflow:
- Required environment variables (names only):
- Feature flags and default values:
