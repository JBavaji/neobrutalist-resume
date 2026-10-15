# Feature Catalog & Functional Specifications
## Project: Flutter Neobrutalist Resume
**Version:** 1.0.0  
**Maintainer:** Jayeshgiri R. Bavaji  

---

## 1. Feature Map Overview

```
Neobrutalist Resume Features
 ├── 1. Core Data Engine & Decoupling
 │    ├── JSON Schema Definition (assets/data/resume_data.json)
 │    ├── Starter Blank Template (assets/data/template_resume_data.json)
 │    └── Resilient Fallback Repository (ResumeRepository)
 ├── 2. Neobrutalist Design System
 │    ├── Design Tokens (AppColors, AppTypography, AppDecorations)
 │    ├── Custom Canvas Vector Painters (BrutalistSmileyWidget, AsteriskIconWidget)
 │    └── Tilted Sticker Badges (Transform.rotate -3.5 deg)
 ├── 3. Interactive In-Browser WYSIWYG Editor
 │    ├── InlineEditableText Component (contenteditable parity)
 │    ├── Real-time Focus & Hover State Transitions
 │    └── Two-way Reactive State Propagation
 ├── 4. State Management & Local Persistence
 │    ├── SharedPreferences Local Storage Sync
 │    ├── Auto-Save on Keystroke
 │    └── 1-Click State Reversion (↺ Reset)
 ├── 5. Dual PDF & Print Export Engine
 │    ├── Browser Print Dialog via Printing.layoutPdf
 │    └── 300+ DPI Vector PDF Generation via package:pdf
 ├── 6. Responsive Layout Engine
 │    ├── 2-Column Editorial Desktop Grid (> 768px)
 │    └── Fluid Single-Column Mobile Layout (≤ 768px)
 └── 7. DevOps & CI/CD Automation
      ├── GitHub Actions Auto-deploy (.github/workflows/deploy.yml)
      └── Deterministic Command Harness (Makefile)
```

---

## 2. Detailed Feature Specifications

### Feature 1: Core Data Engine & JSON Decoupling
* **Summary**: All content displayed in the resume is completely decoupled from UI code and driven by typed JSON schemas.
* **Architecture**:
  * Entity models in `lib/models/resume_model.dart` (`ResumeData`, `ExperienceItem`, `ProjectItem`, `EducationItem`, `CertificationItem`, `ContactInfo`).
  * `fromJson` and `toJson` methods with defensive type-casting and null-safe fallbacks.
  * `ResumeRepository.loadFromAsset(...)` reads bundled assets via `rootBundle.loadString`.
* **User Value**: Forkers never have to search through Flutter widget code to replace hardcoded strings.

### Feature 2: Neobrutalist Design System
* **Summary**: Authentic Neobrutalist aesthetics fused with Warm Editorial print elegance.
* **Tokens**:
  * Background Canvas: `#ECE8DF` (organic warm parchment).
  * Main Resume Card: `#DBD7CE` (stone paper).
  * Ink & Borders: `#111111` (deep charcoal black with 1.8px - 2.2px thickness).
  * Focus Accent: `#3B82F6` (brutal blue).
* **Custom Vector Graphics**:
  * `BrutalistSmileyWidget`: Zero-dependency `CustomPainter` rendering a vector smiley with geometric bezier arcs.
  * `AsteriskIconWidget`: 8-point geometric star drawn with rotational math on Flutter's Canvas.
* **Angled Sticker**:
  * Top name banner tilted at `-3.5°` using `Transform.rotate` with hard drop-shadow (`Offset(-1, 2)`).

### Feature 3: Interactive In-Browser WYSIWYG Editor
* **Summary**: Allows live inline editing of every text element directly inside the browser, matching the HTML `contenteditable` user experience.
* **Component (`InlineEditableText`)**:
  * Unfocused / Idle: Renders as seamless typography with zero visual intrusion.
  * Hover: Renders a soft translucent white highlight (`rgba(255, 255, 255, 0.5)`).
  * Focused: Renders an active `#3B82F6` focus outline with white background and live cursor.
  * Supports single-line (names, dates, pills) with `IntrinsicWidth` and multi-line (bio, bullets, descriptions).

### Feature 4: Local Storage Auto-Save & Reset
* **Summary**: Edits are persistently cached in the browser's `localStorage` via `shared_preferences`.
* **Capabilities**:
  * Every keystroke automatically syncs to `neobrutalist_resume_saved_v1`.
  * Page refresh or reopening the browser instantly restores user modifications.
  * `↺ Reset` button in the floating toolbar clears cache and reloads default asset JSON with confirmation toast.

### Feature 5: Dual Export Engine (Print & Vector PDF)
* **Summary**: Flexible export workflows accommodating both quick browser printing and high-res vector PDF generation.
* **Capabilities**:
  * **Option A (Browser Print)**: Triggers system print dialog. Hides the floating toolbar, removes card shadows, and normalizes margins for paper printing.
  * **Option B (Vector PDF)**: Programmatically builds a vector PDF using `package:pdf/widgets.dart` embedding *Plus Jakarta Sans* and *Space Mono* fonts. Vector elements render sharply at 300+ DPI.

### Feature 6: Responsive Layout Engine
* **Summary**: Adapts fluidly between desktop editorial spreads and vertical mobile scrolls.
* **Breakpoints**:
  * **Desktop (`> 768px`)**: Max-width `840px` card container, 2-column header (sticker left, bio right), 210px left title column with right content, 2-column project and education cards.
  * **Mobile (`≤ 768px`)**: Full-width card with 16px/20px padding, vertically stacked badges and bio, single-column sections, wrapped footer contact links.

### Feature 7: Automated GitHub Pages CI/CD
* **Summary**: Zero-configuration build and deployment on push to `main`.
* **Workflow (`.github/workflows/deploy.yml`)**:
  * Sets up Flutter stable channel.
  * Runs pre-flight static analysis (`flutter analyze`) and unit test suite (`flutter test`).
  * Compiles release web bundle with dynamic base-href (`--base-href "/${{ github.event.repository.name }}/"`).
  * Deploys directly to GitHub Pages without third-party services.
