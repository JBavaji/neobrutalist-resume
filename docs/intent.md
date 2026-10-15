# Intent: Neobrutalist Resume (Flutter / Dart Open Source Edition)

## 1. Project Management & Agile Metadata
- Issue / Initiative: `NEO-001: Flutter Neobrutalist Resume Open Source Showcase`
- Parent Initiative: `AI-Native SDLC Showcase 2026`
- Issue Type: Feature / Flagship Open Source Project
- Lead Architect / Author: Jayeshgiri R. Bavaji (@jbavaji)
- AI Pair Architect: Antigravity AI Agent
- Target Release: v1.0.0 (GitHub Pages & Open Source Community)
- Date: 2026-10-13

## 2. Problem Statement
Developers and technical architects need a distinctive, high-impact portfolio resume that stands out from generic LinkedIn/Word resumes. Neobrutalism offers high visual punch, editorial legibility, and modern dev appeal. 
While an HTML/CSS version exists, the Flutter/Dart community lacks a flagship, production-grade, open-source Neobrutalist resume template that:
1. Is completely data-driven via a single clean JSON/Dart configuration.
2. Runs natively on the Web with seamless GitHub Pages deployment.
3. Offers dual export capabilities (in-browser printing and vector PDF generation).
4. Strictly demonstrates real-world Agile AI-Native SDLC compliance as a reference implementation.

## 3. Expected Outcomes & Success Metrics
- **Metric 1 (Fork & Deploy Time)**: A developer can fork the repo, update `resume_data.json` with their info, and have a live site on GitHub Pages in < 3 minutes.
- **Metric 2 (Visual Fidelity)**: 100% parity with the warm-editorial Neobrutalist aesthetic (custom rotated badges, Space Mono / Plus Jakarta Sans typography, custom canvas icons, bold borders).
- **Metric 3 (Zero Build Failures)**: 100% pass rate on `make lint` (`dart analyze`), `make test` (`flutter test`), and `make build` (`flutter build web --release`).
- **Metric 4 (Dual Export)**: High-resolution PDF export via `package:pdf` / `printing` and clean browser `window.print` styling.

## 4. Explicit Non-Goals
- Full dynamic multi-page CMS or backend database (intentionally static-site / asset-driven for free zero-maintenance GitHub Pages hosting).
- Multi-page router with complex deep-linking (kept as a focused single-page executive resume layout).
- Native desktop/mobile app store publication pipelines in v1.0 (code remains cross-platform ready, but deployment focuses strictly on Flutter Web).

## 5. Boundaries, UX & Platform Matrix
- **Primary Target**: Flutter Web (CanvasKit & HTML renderer compatible).
- **Responsive Breakpoints**:
  - Desktop / Tablet Landscape: `> 768px` (2-column editorial grid, 840px max-width container).
  - Mobile / Small Viewport: `≤ 768px` (Single column vertical flow, adaptive padding).
- **Design Tokens**:
  - Canvas Background: `#ECE8DF`
  - Resume Card: `#DBD7CE`
  - Ink & Borders: `#111111`
  - Accent / White: `#FAF9F6`
- **Typography**: Google Fonts — *Plus Jakarta Sans* (Headings 700/800/900) & *Space Mono* (Body/Dates/Skills 400/700).

## 6. Mutual Agreement & Grill-Me Gate
- [x] **Ambiguity Cleared**: Executed the 4-pillar Grill-Me protocol covering platform targets, state architecture, PDF export, and AI-SDLC standards.
- [x] **Agent Understanding**: Verified web-first focus, JSON file asset loader, dual export mechanism, and full AI-SDLC embedding.
- [x] **Mathematical Gate**: Confidence = 99%, Clarity = 98%, Ambiguity = 2%, Assumptions = 1% (Passed).
- [x] **Human Signoff**: Confirmed by @jbavaji on 2026-10-13.
- **Agreed Verification Target**: `make lint && make test && make build`
