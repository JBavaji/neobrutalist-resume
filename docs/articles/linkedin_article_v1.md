# The Death of the 2-Page PDF: Engineering an Open-Source Neobrutalist Developer Resume with Flutter Web & AI-Native SDLC

**By Jayeshgiri R. Bavaji**  
*Engineering Manager & Principal Technical Architect*  
*Pune, Maharashtra, India*

***

## 1. The Catalyst: Why Developers Need a Living Resume, Not a Static PDF

After 14+ years of architecting cross-platform mobile systems, leading engineering teams, and scaling platforms across FinTech, InsurTech, and enterprise innovation, I found myself facing a frustrating contradiction during senior tech hiring:

**Why are engineers and tech leaders still presenting their careers through static, 2-page black-and-white PDF resumes from 2005?**

We coach engineering teams to build reactive, accessible, data-driven platforms. We talk about CI/CD pipelines, sub-second First Contentful Paint, architectural governance, and agentic AI. 

Yet when evaluating candidates for senior roles—Engineering Managers, Mobile Leads, Principal Architects—almost everyone sends the exact same generic PDF export. It gets mangled by Applicant Tracking Systems (ATS), contains zero SEO discoverability, and provides zero verifiable proof of architectural taste or code craftsmanship.

A resume should not just be a static document; for an engineer, **your resume is software**. It should be a living, searchable, interactive proof-of-work.

I decided to engineer a flagship, open-source **Neobrutalist Developer Resume** using **Flutter Web & Dart**. Rather than treating it as a weekend hacking experiment, I built it under the rigorous governance of the **AI-Native SDLC (v2.0)** framework. 

Here is the complete behind-the-scenes story of how it was built, the architecture, the deployment trade-offs, and the step-by-step blueprint so you can fork and deploy your own.

***

## 2. 🏛️ AI-SDLC Execution Audit (Stages 1 – 6)

Unregulated AI development produces what I call **"AI Code Vomit"**: massive 1,000-line monolithic files, hallucinations, brittle tests, and hidden architectural debt. 

To ensure production-grade software craftsmanship, the project was governed through the 6 formal stages of the **AI-Native SDLC**:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       AI-Native SDLC (v2.0) Stages                          │
└──────┬──────────────┬──────────────┬──────────────┬──────────────┬──────────┘
       ▼              ▼              ▼              ▼              ▼
 ┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐
 │  Stage 1  │  │  Stage 2  │  │  Stage 3  │  │  Stage 4  │  │Stage 5 & 6│
 │ Intent &  │  │ Spec &    │  │ Vertical  │  │ TDD &     │  │ Review &  │
 │ Grill-Me  │  │ STRIDE    │  │ Slicing   │  │ Prove-It  │  │ Deploy    │
 └───────────┘  └───────────┘  └───────────┘  └───────────┘  └───────────┘
```

### Stage 1: Intent & Alignment (The 4-Pillar "Grill-Me" Protocol)
Before writing a single line of Dart, I executed a mandatory 4-pillar architectural interview with the AI agent:
* **Scope & Boundaries:** Dedicated to building an open-source, mobile-first Developer Resume (not a broad portfolio) deployable to GitHub Pages in under 60 seconds.
* **Architecture & State:** Enforced **Rule 0: Simplicity First**. Rejected heavy state management libraries (BLoC/Riverpod) in favor of lightweight `StatefulWidget` + `ValueNotifier` to ensure forkers don't drown in boilerplate.
* **Export Engine:** Defined requirements for dual-export parity: instant browser print + 300+ DPI vector PDF generation.
* **Proof of Acceptance:** Defined deterministic verification via `make lint`, `make test`, `make token-audit`, and `make build`.

### Stage 2: Technical Specification & Threat Model (STRIDE)
In client-side web apps, security is often ignored. In Stage 2, we performed threat modeling upfront:
* **Tampering:** Guarded against local storage corruption by implementing defensive deserialization in `ResumeData.fromJson` with null-safe fallbacks.
* **Elevation of Privilege:** Protected external link launching in `ResumeFooterWidget` by validating URI schemes against allowed protocols (`http`, `https`, `mailto`, `tel`) to prevent `javascript:` or `file:` script injection.

### Stage 3: Task Breakdown & Vertical Slicing
The implementation was broken into thin, testable vertical slices:
* *Slice 1:* Core Data Models & JSON Deserialization (`lib/models/resume_model.dart`).
* *Slice 2:* Neobrutalist Theme & Custom Vector Painters (`BrutalistSmileyWidget`, `AsteriskIconWidget`).
* *Slice 3:* Responsive Layout & WYSIWYG Inline Editing (`InlineEditableText`, `FloatingToolbar`).
* *Slice 4:* Dual PDF Export & Automated CI/CD.

### Stage 4: Test-Driven Development (The "Prove-It" Pattern)
During development, we encountered real-world layout defects. Rather than guessing, we applied the **Prove-It Pattern**:
* *The Bug:* A `TextField` embedded inside a `Wrap` widget threw an unbounded horizontal width assertion.
* *The Prove-It Fix:* Wrapped the editor in an `IntrinsicWidth` with `ConstrainedBox(minWidth: 40)` and proved resolution via widget test assertions.

### Stage 5: 5-Axis Code Review
Before merging, the code was audited across 5 critical axes:
1. **Correctness:** 100% test pass rate across models and UI widgets.
2. **Readability:** Clean separation of concerns with descriptive naming.
3. **Architecture:** Zero coupling between UI widgets and raw JSON files.
4. **Security:** Scheme validation on all external URL dispatches.
5. **Performance:** Hardcoded CSS token audit via `make token-audit` with 0 hex-color leaks.

### Stage 6: Operationalization & Release
Staged the repository as a disciplined 7-commit Agile showcase, configured automated GitHub Actions, and deployed to GitHub Pages.

***

## 3. 📂 Repository File Structure

The project follows Clean Architecture principles, ensuring that data, domain models, presentation widgets, and export services remain strictly decoupled:

```text
neobrutalist-resume/
├── .agent/                      # AI-SDLC meta-governance & security audit scripts
│   ├── rules/inversion-protocol.md
│   └── security/token-audit.sh
├── .github/
│   └── workflows/deploy.yml     # Automated GitHub Pages CI/CD pipeline
├── assets/
│   ├── images/banner.png        # Official 16:9 editorial banner image
│   └── data/
│       ├── resume_data.json          # Live profile dataset (single source of truth)
│       └── template_resume_data.json # Blank starter template for forkers
├── docs/                        # Complete enterprise lifecycle documentation
│   ├── intent.md                # Vision & scope
│   ├── spec.md                  # STRIDE threat model & technical spec
│   ├── plan.md                  # Vertical task breakdown
│   ├── REVIEW.md                # 5-axis review rubric
│   └── product/
│       ├── BRD.md               # Business Requirements Document
│       └── FEATURE_CATALOG.md   # Functional specs (FEAT-001 – FEAT-007)
├── lib/
│   ├── models/
│   │   └── resume_model.dart    # Immutable typed models (fromJson/toJson/copyWith)
│   ├── services/
│   │   ├── resume_repository.dart # Asset loader & SharedPreferences persistence
│   │   └── pdf_export_service.dart# 300+ DPI vector PDF generator via package:pdf
│   ├── theme/
│   │   └── neobrutalist_theme.dart# Centralized tokens (Colors, Typography, Borders)
│   ├── widgets/
│   │   ├── brutalist_badge.dart      # Tilted sticker badge (-3.5 deg)
│   │   ├── custom_icons.dart        # Vector CustomPainter smiley & asterisk
│   │   ├── floating_toolbar.dart    # Capsule controls (Edit, Template, Print, Reset)
│   │   ├── inline_editable_text.dart# WYSIWYG editor with intrinsic width protection
│   │   ├── resume_content_widgets.dart # Modular section cards (Experience, Skills, etc.)
│   │   └── section_row.dart         # Responsive 2-column editorial grid wrapper
│   └── main.dart                # App entrypoint & reactive state orchestration
├── test/
│   ├── resume_model_test.dart   # Unit tests for JSON round-trips & fallbacks
│   └── widget_test.dart         # Widget tests for layout & section rendering
├── web/
│   └── index.html               # Web host shell with instant CSS pre-loader
├── Makefile                     # Deterministic build & quality verification harness
└── pubspec.yaml                 # Dependencies (google_fonts, pdf, printing, etc.)
```

***

## 4. Hosting & Deployment: Where Should You Host?

When deploying a web-based developer resume, choosing the right hosting platform dictates maintenance overhead, cost, and reliability. We evaluated the two leading serverless platforms:

### 🏆 Recommendation #1: GitHub Pages via GitHub Actions (Strongest Recommendation)
* **Cost:** 100% Free forever (no bandwidth caps for personal use).
* **Workflow:** Git push to `main` triggers `.github/workflows/deploy.yml` which tests, builds, and deploys.
* **Why it Wins:** Your code, issues, commits, and live website live in the **exact same GitHub repository**. Recruiters can inspect the live site and immediately click "View on GitHub" to audit your code quality and commit history in one unified location.

### 🥈 Recommendation #2: Firebase Hosting (Best for Custom Previews & Google Ecosystem)
* **Cost:** Generous free Spark tier (10 GB storage, 360 MB/day bandwidth).
* **Workflow:** Deploy via `firebase deploy --only hosting` or GitHub Actions preview channels.
* **When to Choose:** If you want ephemeral preview URLs for every pull request, custom domain SSL provisioning in 30 seconds, or integration with Firebase Analytics to track recruiter views.

### 📊 Quick Comparison

| Feature | 🏆 GitHub Pages | 🥈 Firebase Hosting | Vercel / Netlify |
| :--- | :--- | :--- | :--- |
| **Hosting Cost** | **$0 / month** | $0 / month (Spark Tier) | $0 / month |
| **Setup Overhead** | **Zero CLI tools needed** | Requires `firebase-tools` CLI | Requires external account link |
| **All-in-One Repo Integration** | **Native (Code + Site unified)**| External GCP console | External dashboard |
| **Custom Domains** | Yes (`CNAME`) | Yes (with auto SSL) | Yes |
| **PR Preview Channels** | No (single branch) | **Yes (Ephemeral URLs)** | Yes |
| **Maintenance Burden** | **Zero maintenance** | Low | Low |

***

## 5. 🌐 How GitHub Pages Routes Multiple Projects Without Collisions

A common architectural question I get from senior developers:

> *"I already have a personal portfolio website at `https://jbavaji.github.io/`. Will deploying this resume overwrite my main website?"*

**The Answer: No.** GitHub Pages has a distinct routing hierarchy:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        GitHub Pages Architecture                       │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
           ┌────────────────────────┴────────────────────────┐
           ▼                                                 ▼
┌──────────────────────────────────────┐  ┌──────────────────────────────────────┐
│       User/Organization Site         │  │             Project Site             │
│    https://jbavaji.github.io/        │  │https://jbavaji.github.io/neobrutalist-resume/│
│  (Repo: jbavaji/jbavaji.github.io)   │  │ (Repo: jbavaji/neobrutalist-resume)  │
│  Serves your root personal portfolio │  │ Serves the independent Flutter app   │
└──────────────────────────────────────┘  └──────────────────────────────────────┘
```

### The Critical Fix: Dynamic `--base-href`
When a Flutter Web app is hosted in a subfolder (like `/neobrutalist-resume/`), Flutter's asset loader and router must know its root path. If you do not specify this, the app attempts to load `main.dart.js` and `canvaskit/` from `https://jbavaji.github.io/main.dart.js`, causing immediate **404 Not Found** crashes.

In our `.github/workflows/deploy.yml`, we solved this dynamically:

```yaml
- name: Build Flutter Web Release
  run: flutter build web --release --base-href "/${{ github.event.repository.name }}/"
```

Because `${{ github.event.repository.name }}` dynamically resolves to your repository name, **you can name your repo whatever you want**, and GitHub Actions will automatically inject the correct base URL.

***

## 6. The Zero-Bloat Data Layer: `resume_data.json`

To ensure anyone can personalize the resume in 60 seconds without knowing Flutter widget trees, all content is decoupled into a typed JSON schema in [`assets/data/resume_data.json`](assets/data/resume_data.json):

```json
{
  "nameFirst": "JAYESHGIRII",
  "nameLast": "BAVAJI",
  "bio": "Hi, I'm Jayeshgirii, an Engineering Manager & Technical Architect based in Pune, India with 14+ years building cross-platform mobile, web, and Agentic AI solutions across FinTech, InsurTech, and enterprise innovation.",
  "experience": [
    {
      "role": "Associate Specialist Technology (Mobile)",
      "company": "Synechron Technology Pvt. Ltd.",
      "period": "2018 – Present (8+ Years)",
      "bullets": [
        "Lead architecture and deployment for Sandbox Platform (enterprise cloud-native accelerator on Azure/Kubernetes with React 19) and InfraSec.AI.",
        "Architected FinTouch touchscreen collaboration platform (Flutter/Dart) and pioneered Synechron's first-of-kind Web3/Solana employee rewards app.",
        "Lead cross-functional engineering teams, establish CI/CD release pipelines, enforce quality gates, and bridge product vision with shipped code."
      ]
    },
    {
      "role": "Software Engineer – Android",
      "company": "iCoderz Solutions Pvt. Ltd.",
      "period": "2013 – 2018 (5 Years)",
      "bullets": [
        "Architected and delivered 10+ Android applications end-to-end from concept to Google Play Store releases across consumer, B2B, and enterprise domains.",
        "Engineered real-time location tracking, Firebase cloud messaging, and robust multi-language localization features."
      ]
    }
  ],
  "skills": [
    "Mobile & Cross-Platform (Flutter / React Native / Android)",
    "Frontend & Web (React 19 / Tailwind / Redux)",
    "Agentic AI & LLMs",
    "Cloud & DevOps (Azure / Kubernetes / CI/CD)",
    "Technical Architecture & RBAC",
    "Agile Engineering Leadership"
  ],
  "projects": [
    {
      "name": "Sandbox Platform",
      "description": "Enterprise Kubernetes unified control plane on Azure with React 19, RBAC, cost governance & observability."
    },
    {
      "name": "FinTouch & InfraSec.AI",
      "description": "Touchscreen collaboration platform (Flutter/Dart) & automated security monitoring reducing MTTR."
    }
  ],
  "education": [
    {
      "degree": "Master of Computer Applications (MCA)",
      "institution": "Saurashtra University, Rajkot",
      "period": "2009 – 2012"
    }
  ],
  "certifications": [
    {
      "title": "GitHub Certified: Agentic AI Developer",
      "issuer": "GitHub",
      "year": "2026"
    },
    {
      "title": "Claude Code in Action",
      "issuer": "Anthropic",
      "year": "2026"
    }
  ],
  "contact": {
    "phone": "+91 9601833544",
    "location": "Pune, Maharashtra, India",
    "email": "jbavaji@gmail.com",
    "linkedin": "https://linkedin.com/in/jbavaji",
    "website": "https://jbavaji.github.io"
  }
}
```

***

## 7. Solving the Flutter Web Initial "Blank Screen" Performance Bug

When we first deployed the application to GitHub Pages, we observed a jarring user experience: **a 2–4 second blank beige screen on cold load**.

### The Root Cause:
In Flutter Web, before Dart code can mount its first frame, the browser must download:
1. `flutter.js` loader
2. `canvaskit.wasm` WebAssembly binary (~5–8 MB)
3. `main.dart.js` compiled application bundle (~2–3 MB)
4. Web fonts (*Plus Jakarta Sans* & *Space Mono*)

Because [`web/index.html`](web/index.html) originally had an empty `<body>`, the user saw an unstyled empty screen while the browser downloaded these assets.

### The Engineering Solution: Instant HTML/CSS Pre-Loader
We embedded a zero-dependency, pure-CSS Neobrutalist Splash Card directly inside `web/index.html`:
* **Zero Latency (< 20ms):** Displays instantly upon HTTP response before any JavaScript downloads.
* **Branded Aesthetics:** Features the warm `#ECE8DF` canvas, a tilted badge (`⚡ JAYESHGIRII BAVAJI`), and an electric blue (`#3B82F6`) progress runner.
* **Seamless Handshake:** Uses `_flutter.loader.loadEntrypoint` with a `MutationObserver` that smoothly fades the splash out (`opacity: 0` with a 300ms transition) the millisecond Flutter mounts `<flutter-view>` into the DOM.

***

## 8. 🚀 Fork & Deploy Your Own in 1 Minute

You can fork this repository and launch your own live Neobrutalist resume right now:

### Step 1: Fork the Repository
Click **Fork** on GitHub:  
👉 **[https://github.com/JBavaji/neobrutalist-resume](https://github.com/JBavaji/neobrutalist-resume)**

### Step 2: Personalize Your Data
Edit `assets/data/resume_data.json` directly in your browser or IDE with your experience, skills, and links.

### Step 3: Enable "GitHub Actions" in Repository Settings (One-Time)
1. Go to your repository's **Settings** > **Pages**.
2. Under **Build and deployment** > **Source**, change the dropdown from *Deploy from a branch* to:  
   👉 **`GitHub Actions`**

### Step 4: Push to Main
```bash
git push origin main
```

Your resume will build and publish automatically at:  
🌐 **`https://<your-username>.github.io/<your-repo-name>/`**

***

## 9. Exploring My Next Leadership Chapter

As I publish this open-source initiative, I am actively exploring my next career chapter.

I am open to conversations for:
* **Engineering Manager**
* **Mobile Engineering Leader**
* **Principal Mobile Architect**

If you are a Founder, CTO, VP of Engineering, or Talent Partner looking for a leader who bridges deep mobile engineering roots with modern Agentic AI workflows, robust DevOps governance, and scalable team architectures, my DMs are open — let's connect.

***

### 🔗 Live Links & Repository

* 🌐 **Live Interactive Resume:** [https://jbavaji.github.io/neobrutalist-resume/](https://jbavaji.github.io/neobrutalist-resume/)
* ⭐ **Open Source GitHub Repository:** [https://github.com/JBavaji/neobrutalist-resume](https://github.com/JBavaji/neobrutalist-resume)
* 💼 **LinkedIn Profile:** [https://linkedin.com/in/jbavaji](https://linkedin.com/in/jbavaji)

*If you found this case study insightful or if you fork the template for your own career, drop a star on the repo and share your thoughts in the comments!*
