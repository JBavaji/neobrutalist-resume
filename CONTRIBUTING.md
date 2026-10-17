# 🤝 Contributing to Flutter Neobrutalist Resume

First off, thank you for considering contributing to the **Flutter Neobrutalist Resume**! 🎉

This project is a flagship, open-source initiative designed to prove that a modern developer resume should be **living, interactive software** rather than a static 2-page PDF. It is engineered under the **AI-Native SDLC (v2.0)** framework with rigorous standards for clean architecture, mathematical quality gates, and Neobrutalist design tokens.

---

## 📜 Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Our Architectural Invariants](#our-architectural-invariants)
- [Local Development Setup](#local-development-setup)
- [The Deterministic Make Interface](#the-deterministic-make-interface)
- [The "Prove-It" Pattern (Bug Fixes)](#the-prove-it-pattern-bug-fixes)
- [Design Token Discipline](#design-token-discipline)
- [Git Commit Guidelines](#git-commit-guidelines)
- [Pull Request Process](#pull-request-process)

---

## 🛡️ Code of Conduct

All contributors and participants agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md). Please read it to understand our community standards.

---

## 🏛️ Our Architectural Invariants

Before writing or proposing any code, please familiarize yourself with these core invariants:

1. **Rule 0: Simplicity First:** What is the simplest architecture that solves the problem? Reject premature abstractions, heavy external state dependencies, or monolithic widgets.
2. **The Zero-Bloat Data Layer:** Personal career data must remain strictly decoupled in `assets/data/resume_data.json`. **Never hardcode resume text into UI widgets.**
3. **Defensive Deserialization:** All JSON parsing in `ResumeData.fromJson` must have null-safe fallback defaults to ensure empty or missing keys never trigger runtime crashes.
4. **Authentic Neobrutalism:** Hard black borders (`2.2px`), tactile drop shadows (`4px 4px 0px #111111`), warm stone/paper tones (`#ECE8DF`, `#DBD7CE`), and high-contrast typography (*Plus Jakarta Sans* + *Space Mono*).

---

## 💻 Local Development Setup

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Channel: `stable`, 3.24+)
- Google Chrome (for Flutter Web debugging)
- Make (standard on macOS and Linux)

### Quick Start
```bash
# 1. Clone your fork
git clone https://github.com/<your-username>/neobrutalist-resume.git
cd neobrutalist-resume

# 2. Verify SDK and tooling environment
make check-env

# 3. Install dependencies
flutter pub get

# 4. Launch the local Flutter Web development server
make run
```

---

## 🛠️ The Deterministic Make Interface

All verification in this repository is governed through deterministic `make` commands:

```bash
make check-env     # Verifies Flutter & Dart SDK paths
make lint          # Executes dart analyze (Zero warnings policy)
make test          # Runs unit and widget test suites
make fix           # Formats Dart code and applies auto-fixes
make token-audit   # Scans for visual token violations & hardcoded hex values
make build         # Compiles the production Flutter Web release bundle
```

> **Mandatory Step 0 Rule:** Always verify your baseline with `make lint` and `make test` before modifying any code. Never write code on a failing baseline.

---

## 🧪 The "Prove-It" Pattern (Bug Fixes)

We follow strict Test-Driven Development (TDD) for defects:
1. **Reproduce First:** Before modifying any production code in `lib/`, write a failing unit or widget test in `test/` that cleanly reproduces the bug.
2. **Verify Red:** Run `make test` to prove that the test fails.
3. **Implement Fix:** Apply the minimal surgical fix in `lib/`.
4. **Verify Green:** Run `make test` to prove that your test passes and no regressions were introduced.

---

## 🎨 Design Token Discipline

To maintain design integrity across themes and exports, visual styles must use centralized tokens from `lib/theme/neobrutalist_theme.dart`:

- **Colors:** Use `NeobrutalistTheme.canvasColor`, `NeobrutalistTheme.cardColor`, `NeobrutalistTheme.inkColor`, and `NeobrutalistTheme.primaryAccent`.
- **Borders:** Use `NeobrutalistTheme.defaultBorder`.
- **Shadows:** Use `NeobrutalistTheme.defaultShadow`.
- **Audit Gate:** Run `make token-audit` prior to committing. If your changes leak raw hex colors or non-standard pixel values, the audit gate will reject the commit.

---

## 📝 Git Commit Guidelines

We enforce the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```text
<type>(<scope>): <short descriptive imperative summary>

[optional body explaining context and rationale]

[optional footer(s) like "Fixes #123"]
```

### Supported Types:
- `feat:` A new feature or widget component
- `fix:` A bug fix or layout correction
- `docs:` Documentation updates, articles, or diagrams
- `style:` Formatting changes that do not affect the meaning of code
- `refactor:` Code refactoring that neither fixes a bug nor adds a feature
- `test:` Adding missing tests or correcting existing tests
- `chore:` Maintenance tasks, dependency bumps, or CI updates

**Example:**
```text
feat(widgets): add tilted sticker tag for certification items
fix(layout): wrap inline text editor in intrinsic width to avoid overflow
docs(readme): add link to published architecture case study
```

---

## 🚀 Pull Request Process

1. **Branching:** Create a descriptive branch off `main`:
   ```bash
   git checkout -b feat/export-json-button
   ```
2. **Quality Gates:** Verify all automated gates locally:
   ```bash
   make lint && make test && make token-audit && make build
   ```
3. **PR Template:** Open your Pull Request against `main`. Fill out the structured PR template completely, attaching visual screenshots or GIFs for UI changes.
4. **CI Review:** Our automated GitHub Actions workflow will execute `lint`, `test`, `token-audit`, and `build` on Ubuntu runners.
5. **Review SLA:** Maintainers typically review PRs within 24–48 hours.

Thank you for helping keep the Neobrutalist Resume the gold standard of living developer portfolios! 🚀
