"""
Nox configuration for running tests, linting, and formatting.
Usage:
    nox                    # run all default sessions
    nox -s tests           # run tests only
    nox -s lint            # run linters only
    nox -s format          # auto-format code
    nox -s type_check      # run mypy
"""

import nox

PYTHON_VERSIONS = ["3.11", "3.12"]
SRC_PATHS = ["src", "tests"]


@nox.session(python=PYTHON_VERSIONS)
def tests(session: nox.Session) -> None:
    """Run the test suite with pytest."""
    session.install("pytest", "pytest-cov")
    session.install("-e", ".")
    session.run(
        "pytest",
        "--cov=src",
        "--cov-report=term-missing",
        "--tb=short",
        *session.posargs,
    )


@nox.session(python="3.12")
def lint(session: nox.Session) -> None:
    """Run linters: ruff and black (check mode)."""
    session.install("ruff", "black", "isort")
    session.run("ruff", "check", *SRC_PATHS)
    session.run("black", "--check", *SRC_PATHS)
    session.run("isort", "--check-only", *SRC_PATHS)


@nox.session(python="3.12")
def format(session: nox.Session) -> None:
    """Auto-format source code with black and isort."""
    session.install("black", "isort")
    session.run("black", *SRC_PATHS)
    session.run("isort", *SRC_PATHS)


@nox.session(python="3.12")
def type_check(session: nox.Session) -> None:
    """Run mypy static type checker."""
    session.install("mypy", "types-requests")
    session.install("-e", ".")
    session.run("mypy", "src")
