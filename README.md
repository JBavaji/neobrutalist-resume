# ⚡ Flutter Neobrutalist Resume

[![Flutter Web](https://img.shields.io/badge/Flutter-Web%20Ready-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![AI-SDLC Compliant](https://img.shields.io/badge/AI--SDLC-Compliant%20v1.0-4F46E5?style=for-the-badge)](docs/intent.md)
[![Deploy to GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Automated%20CI%2FCD-181717?style=for-the-badge&logo=github)](https://pages.github.com/)

A flagship, open-source **Neobrutalist & Warm Editorial** executive resume and developer portfolio template built with **Flutter Web and Dart**.

> 🌐 **Live Demo:** [https://jbavaji.github.io/neobrutalist-resume/](https://jbavaji.github.io/neobrutalist-resume/)

---

## ✨ Features

- **🎨 High-Impact Neobrutalist Aesthetics:** Bold black borders (`2.2px`), angled sticker badges (`-3.5°`), high-contrast typography pairing (*Plus Jakarta Sans* + *Space Mono*), and tactile warm stone/paper tones (`#DBD7CE`).
- **⚡ "Fork & Personalize in 60s":** Completely data-driven! You never have to touch Flutter widget trees. Just edit one JSON file (`assets/data/resume_data.json`).
- **🖨️ Dual PDF & Print Engine:**
  - One-click native browser print with custom print stylesheets.
  - Direct 300+ DPI high-resolution vector PDF export powered by `package:pdf` & `printing`.
- **📱 Fully Responsive:** Adaptive layout switching between an editorial 2-column desktop grid (`> 768px`) and a sleek single-column mobile view (`≤ 768px`).
- **🤖 Flagship AI-Native SDLC Implementation:** Built from the ground up using real-world Agile AI-SDLC methodology — complete with a deterministic `Makefile` harness, Stage 1–6 audit docs, and universal multi-agent memory bank (`AGENT.md`).

---

## 🚀 Fork & Deploy in 1 Minute

Get your own live Neobrutalist resume hosted on GitHub Pages for free:

```
Fork Repo ──▶ Edit resume_data.json ──▶ Push to main ──▶ Live on GitHub Pages!
```

### Step 1: Fork this Repository
Click the **Fork** button in the top-right corner of this GitHub repository to create your own copy.

### Step 2: Personalize Your Resume
Open `assets/data/resume_data.json` (or copy from `assets/data/template_resume_data.json`) and update:
- Your name & bio statement
- Work experience items & achievements
- Core skills list
- Recent projects & links
- Education & certifications
- Contact information (Email, LinkedIn, Website, Phone)

### Step 3: Enable GitHub Pages
1. In your forked repository, navigate to **Settings** > **Pages**.
2. Under **Build and deployment** > **Source**, select **GitHub Actions**.
3. Push any commit to the `main` branch.
4. Your resume will automatically build and publish at:
   ```
   https://<your-username>.github.io/<your-repo-name>/
   ```

---

## 🛠️ Local Development & AI-SDLC Commands

This repository includes a deterministic `Makefile` command interface conforming to the AI-Native SDLC standard:

| Command | Action |
| :--- | :--- |
| `make check-env` | Verifies local Flutter & Dart SDK installation |
| `make lint` | Runs `dart analyze` for static code verification |
| `make test` | Executes unit and widget test suites (`flutter test`) |
| `make fix` | Automatically formats code and applies automated fixes |
| `make build` | Compiles the optimized production web bundle in `build/web/` |
| `make run` | Starts local development server in Google Chrome |
| `make token-audit` | Scans project for visual design token violations |

---

## 📁 Project Architecture

```text
Neobrutalist-Resume/
├── .github/
│   └── workflows/
│       └── deploy.yml              # Automated GitHub Pages CI/CD workflow
├── .agent/                         # Universal AI SDLC configurations & sync scripts
├── docs/                           # Traceable AI-SDLC Lifecycle Artifacts
│   ├── intent.md                   # Stage 1: Problem statement, metrics, Grill-Me gate
│   ├── spec.md                     # Stage 2: Architecture, data contracts & design tokens
│   ├── plan.md                     # Stage 3: Mathematical quality gates & work order
│   └── REVIEW.md                   # Stage 5: Pre-merge quality & security audit
├── assets/
│   └── data/
│       ├── resume_data.json        # Populated executive profile (Live Demo)
│       └── template_resume_data.json # Clean starter template for forkers
├── lib/
│   ├── main.dart                   # Entrypoint & responsive layout shell
│   ├── models/
│   │   └── resume_model.dart       # Immutable, typed data models & JSON serializers
│   ├── services/
│   │   ├── resume_repository.dart  # Resilient asset loader with fallback data
│   │   └── pdf_export_service.dart # Vector PDF generation & print engine
│   ├── theme/
│   │   └── neobrutalist_theme.dart # Neobrutalist design tokens & typography
│   └── widgets/
│       ├── brutalist_badge.dart    # Tilted sticker header badge
│       ├── custom_icons.dart       # Vector CustomPainter smiley & asterisk icons
│       ├── floating_toolbar.dart   # Floating capsule controls (Profile/Template toggle, Print, PDF)
│       ├── resume_content_widgets.dart # Reusable content cards & footer
│       └── section_row.dart        # Responsive 2-column section layout
├── test/
│   ├── resume_model_test.dart      # Serialization & fallback data unit tests
│   └── widget_test.dart            # Layout & UI rendering tests
├── web/
│   └── index.html                  # Web container with print styles & metadata
├── AGENT.md                        # Root memory bank (<100 lines, symlinked to CLAUDE/GEMINI/Cursor)
├── Makefile                        # Deterministic build & test harness
├── pubspec.yaml                    # Flutter dependencies & asset declarations
└── LICENSE                         # MIT License
```

---

## 🤝 AI Native SDLC Compliance

This project is authored under the **AI-Native SDLC Framework** ([AI Native SDLC Playbook](docs/intent.md)), enforcing:
- **Pre-Flight Health Checks (Step 0):** Zero changes on broken baselines.
- **Grill-Me Alignment Gate:** Mutual intent signoff prior to implementation.
- **Mathematical Quality Gates:** Execution authorized only with Confidence $\ge 95\%$, Clarity $\ge 95\%$, Ambiguity $\le 5\%$.
- **Deterministic Verification:** Every stage gated by automated `make lint`, `make test`, and `make build`.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE) — free for personal and commercial use.

Authored with ❤️ by [Jayeshgiri R. Bavaji](https://linkedin.com/in/jbavaji). If you find this template helpful, please star ⭐ the repository!
