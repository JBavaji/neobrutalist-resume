# Business Requirements Document (BRD)
## Project: Flutter Neobrutalist Resume & Portfolio Showcase
**Document Version:** 1.0.0  
**Author / Engineering Lead:** Jayeshgiri R. Bavaji  
**Status:** Approved for Production  
**Target Release:** Q4 2026  

---

## 1. Executive Summary
The **Flutter Neobrutalist Resume** initiative addresses the homogenization of developer portfolios and resumes in the modern tech hiring landscape. Standard PDF templates, LinkedIn exports, and generic minimalist themes fail to communicate technical seniority, design sophistication, and modern architectural capabilities.

This project delivers a flagship, production-grade, open-source resume template built with **Flutter Web and Dart**. It uniquely marries the punchy visual language of **Neobrutalism and Warm Editorial typography** with an enterprise-grade **zero-bloat, data-driven architecture**. Anyone can fork the repository, update a single JSON configuration, and publish their personal site to GitHub Pages in under three minutes—complete with in-browser live editing and 300+ DPI vector PDF export.

---

## 2. Business Problem & Market Analysis

### 2.1 The Problem
1. **Resume Fatigue**: Hiring managers and engineering directors review hundreds of identical resumes formatted in standard black-and-white Word templates or cookie-cutter templates.
2. **Disconnect Between Skill & Presentation**: Mobile and frontend architects often have impressive accomplishments (10+ years of leading architectures, scaling platforms, agentic AI systems), but their resumes look visually indistinguishable from entry-level applicants.
3. **High Maintenance Overhead**: Traditional custom portfolio websites require complex headless CMS setups, backend databases, or extensive CSS/HTML refactoring whenever an accomplishment or role changes.
4. **Export Disparity**: Most web resumes look terrible when printed or saved as PDF due to missing media print rules, broken page splits, and rasterized blur.

### 2.2 Market Opportunity & Positioning
* **Target Audience**: Mobile Engineers, Flutter/Dart Developers, Technical Architects, Engineering Managers, and Tech Leads.
* **Value Proposition**: A distinctive, high-recall personal branding engine that doubles as a verifiable proof-of-work codebase demonstrating Clean Architecture and modern AI-Native SDLC practices.

---

## 3. User Personas

| Persona | Role | Primary Goals | Key Pain Points |
| :--- | :--- | :--- | :--- |
| **P1: The Candidate (Senior/Lead Engineer)** | Engineering Manager / Technical Architect | Showcase career milestones, technical leadership, and engineering standards in an unforgettable format. | Doesn't want to spend weekends tweaking CSS or managing hosting servers. Needs rapid updates. |
| **P2: The Recruiter / Talent Sourcer** | Executive Technical Recruiter | Quickly identify tenure, core competencies, previous organizations, and contact links in < 30 seconds. | Frustrated by unreadable artistic layouts that obscure basic contact info or omit dates. |
| **P3: The Hiring Manager / Director** | VP of Engineering / Director | Evaluate candidate's technical depth, architectural taste, code quality, and ability to adopt cutting-edge methodology (AI-SDLC). | Skeptical of candidates who claim senior architecture but provide disorganized, monolithic codebases. |

---

## 4. Business & Product Objectives

```
                        ┌──────────────────────────────────────────────┐
                        │              Business Objectives             │
                        └──────────────────────┬───────────────────────┘
                                               │
             ┌─────────────────────────────────┼─────────────────────────────────┐
             ▼                                 ▼                                 ▼
┌───────────────────────────┐     ┌───────────────────────────┐     ┌───────────────────────────┐
│     High Visual Recall    │     │      Zero-Friction Fork   │     │    Dual Export Parity     │
│  Neobrutalist editorial   │     │    Data-driven JSON layer │     │  Browser print & vector   │
│  identity with >90%       │     │    deploys to GitHub      │     │  PDF with 100% typography │
│  interviewer recall rate  │     │    Pages in < 3 minutes   │     │  and layout consistency   │
└───────────────────────────┘     └───────────────────────────┘     └───────────────────────────┘
```

1. **Brand Recall**: Stand out in the top 1% of applicant pools through distinctive Neobrutalist design tokens (hard borders, angled sticker badges, Space Mono code typography).
2. **Frictionless Adoption**: Enable any developer to personalize their resume in 60 seconds by editing `resume_data.json` without modifying widget trees.
3. **Zero Operating Cost**: Serverless, static-asset hosting on GitHub Pages with automated CI/CD deployment via GitHub Actions.
4. **Dual Export Fidelity**: Support both native browser print dialogs (`window.print`) and high-resolution vector PDF generation via `package:pdf`.

---

## 5. Scope & Boundary Matrix

### 5.1 In-Scope (Phase 1)
- Data-driven Clean Architecture with JSON asset loader and in-memory fallback.
- True Neobrutalist & Warm Editorial theme (colors, borders, shadows, sticker badges).
- Full inline WYSIWYG live edit mode with browser `localStorage` persistence.
- Interactive controls toolbar (Edit toggle, profile/template switcher, reset, print, vector PDF).
- Responsive breakpoint engine (2-column desktop grid >768px, adaptive mobile column <=768px).
- Turnkey GitHub Actions CI/CD pipeline for GitHub Pages.
- 100% test coverage for data serialization and core widget rendering.

### 5.2 Out-of-Scope (Explicit Non-Goals)
- **Dynamic Multi-tenant Backend**: Intentionally static to preserve free, zero-maintenance hosting.
- **Heavy Database / Auth Systems**: No login required; all state is local-first.
- **Multi-page Routing / Blog Engine**: Intentionally focused as an executive single-page resume document.

---

## 6. Functional Requirements (FR)

- **FR-01 (Data Decoupling)**: The application MUST load all resume content from `assets/data/resume_data.json` at launch.
- **FR-02 (Offline Fallback)**: If asset loading fails or during unit testing, the system MUST gracefully fall back to a hardcoded data model without throwing uncaught exceptions.
- **FR-03 (Inline Editing)**: In Edit Mode (`isEditing: true`), every text field MUST allow direct inline editing with visual focus indicators.
- **FR-04 (Local Persistence)**: Edits made in the browser MUST automatically persist to `localStorage` across page refreshes.
- **FR-05 (Profile / Template Toggle)**: The toolbar MUST allow users to preview between a filled real-world profile and a clean placeholder template.
- **FR-06 (Browser Print)**: The toolbar MUST trigger a native print dialog with print-specific stylesheets hiding UI controls and removing shadows.
- **FR-07 (Vector PDF Export)**: The system MUST generate a downloadable vector PDF document matching the visual styling at 300+ DPI.

---

## 7. Non-Functional Requirements (NFR)

- **NFR-01 (Performance)**: First Contentful Paint (FCP) on Flutter Web < 1.8s on standard broadband.
- **NFR-02 (Accessibility & Contrast)**: Text contrast ratio MUST exceed 7:1 (WCAG AAA compliant: `#111111` on `#DBD7CE`).
- **NFR-03 (Responsive Adaptability)**: Fluid rendering across screen widths from 360px (mobile) up to 2560px (ultra-wide desktop).
- **NFR-04 (Reliability & Testing)**: Zero regressions; 100% pass rate on `make lint` and `make test`.
- **NFR-05 (Security)**: Zero third-party tracker scripts; external links dispatched safely via `url_launcher` with validated URI protocols.

---

## 8. Success Metrics & KPIs

| Metric | Target | Measurement Method |
| :--- | :--- | :--- |
| **Fork-to-Deploy Duration** | < 3 Minutes | Manual verification from clean repo fork to live GitHub Pages URL |
| **Bundle Size Efficiency** | < 2.5 MB (gzipped) | Production web build audit (`make build`) |
| **Test Suite Pass Rate** | 100% (0 errors) | Automated CI runner (`flutter test`) |
| **Static Analysis Score** | 0 warnings / 0 lints | Automated CI runner (`flutter analyze`) |
| **Aesthetic Parity** | 100% visual fidelity | Parity audit with original Neobrutalist design spec |
