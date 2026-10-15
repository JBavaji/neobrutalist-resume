# Engineering Specification: Neobrutalist Resume (Flutter / Dart)

## 1. Architecture & Design Decisions
The application follows a lightweight Clean Architecture pattern optimized for zero-cost, serverless Flutter Web hosting:

```
lib/
├── models/             # Domain Entities (Data Contracts & JSON serializable models)
├── services/           # Data Loaders (JSON Asset loader) & PDF Export engine
├── theme/              # Design tokens (Colors, Typography, Borders, Shadows)
├── widgets/            # Reusable Neobrutalist presentation components
└── main.dart           # App root, Responsive LayoutBuilder & State management
```

### Key Decisions
1. **Data-Driven Decoupling**: Resume content lives in `assets/data/resume_data.json`. A developer personalizes the entire resume by modifying this single file without touching Flutter widget code.
2. **Graceful Fallback**: If asset JSON or local storage fails to load, the repository provides typed in-memory fallback models.
3. **State Management**: `StatefulWidget` + `ValueNotifier` — lightweight, zero external boilerplate, instantly understandable by any Dart/Flutter engineer.
4. **Dual Export Engines**:
   - Web Native Print: Calls `Printing.layoutPdf` for instant browser-based PDF printing.
   - Vector PDF Generation: Uses `package:pdf` to render a high-definition vector document matching the visual styling.

---

## 2. Threat Model First (STRIDE & Abuse Cases)

### Trust Boundaries & Assets
- **Trust Boundaries**: Public Browser DOM -> Flutter Web Engine -> Local Storage (`SharedPreferences`) -> External Link Dispatcher (`url_launcher`).
- **Assets to Protect**: User browser integrity, safe external link navigation, clean PDF document rendering.

### STRIDE Threat Analysis Matrix
| Threat Category | Potential Attack Vector | Mitigation / Control |
| :--- | :--- | :--- |
| **S**poofing | Attacker claims forged profile data in local storage | App is client-side public presentation; resetting to default restores verified asset JSON. |
| **T**ampering | Corrupted or malformed JSON stored in `localStorage` | `ResumeData.fromJson` uses defensive type-casts and null fallbacks for all fields. |
| **R**epudiation | Denying modifications in local session | Client-only interactive session; not applicable. |
| **I**nformation Disclosure | Internal stack traces leaked in UI on render error | Flutter release mode suppresses verbose framework stack traces; displays clean fallback. |
| **D**enial of Service | Enormous paste buffer in inline `TextField` (e.g. 50MB string) | Flutter Web canvas renders text efficiently; bounds enforced on layout. |
| **E**levation of Privilege | Malicious URI injection in links (e.g. `javascript:`, `file:`) | `ResumeFooterWidget` validates URIs via `Uri.tryParse` and restricts execution to `http`, `https`, `mailto`, `tel`. |

### Primary Abuse Case (First Test Case)
- **Abuse Scenario**: User inputs an unsafe URI into the website field (e.g. `javascript:eval(...)`).
- **Expected Defense**: `_launchUrl` safely rejects execution; external browser launch does not execute arbitrary scripts.

---

## 3. Visual Design & UI Component Contracts

### Design Tokens & Theme Mapping
| Token Name | Value | Purpose |
| :--- | :--- | :--- |
| `AppColors.canvasBg` | `#ECE8DF` | Outer page backdrop |
| `AppColors.cardBg` | `#DBD7CE` | Warm paper resume card background |
| `AppColors.ink` | `#111111` | Primary text and borders |
| `AppColors.accentWhite`| `#FAF9F6` | Highlights & button cards |
| `AppColors.blueAccent` | `#3B82F6` | Active focus ring in Edit Mode |
| `AppColors.borderWidth`| `1.8 - 2.2` px | Bold Neobrutalist borders |
| `AppColors.cardRadius` | `36.0` px (Desktop) / `20.0` px (Mobile) | Rounded outer container |
| `AppTypography.heading`| `Plus Jakarta Sans` (w700, w800, w900) | Editorial headlines & badges |
| `AppTypography.mono`   | `Space Mono` (w400, w700) | Technical roles, dates, pills, body |

### Component Contract & State Matrix
| Component | Supported Modes | Visual Specs |
| :--- | :--- | :--- |
| `BrutalistBadge` | View / Edit | Tilted top badge (-3.5 deg) + bottom badge with circular smiley SVG |
| `InlineEditableText`| View / Edit | Seamless text when idle; translucent hover; `#3B82F6` blue focus outline when active |
| `SectionRow` | 2-Column Desktop / 1-Column Mobile | 210px left title header with 2.5px underline, flexible right body |
| `SkillPill` | View / Edit | 1.8px black border, 5px/12px padding, Space Mono font |
| `FloatingToolbar` | Fixed Top / Floating | Frosted blur capsule, Edit toggle, Profile/Template switch, PDF download & Print actions |

---

## 4. Public Interfaces & Data Contracts

### 4.1 JSON Data Schema (`assets/data/resume_data.json`)
```json
{
  "nameFirst": "JAYESHGIRI",
  "nameLast": "BAVAJI",
  "bio": "Hi, I'm Jayesh, an Engineering Manager & Technical Architect...",
  "experience": [
    {
      "role": "Associate Specialist Technology (Lead)",
      "company": "Synechron",
      "period": "2018 – Present (8+ Years)",
      "bullets": [
        "Lead architecture and deployment for Sandbox Platform...",
        "Architected FinTouch touchscreen collaboration platform..."
      ]
    }
  ],
  "skills": [
    "Mobile & Cross-Platform (Flutter / React Native)",
    "Frontend & Web (React 19 / Tailwind / Redux)",
    "Agentic AI & LLMs"
  ],
  "projects": [
    {
      "name": "Sandbox Platform",
      "description": "Enterprise Kubernetes unified control plane on Azure with React 19..."
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

---

## 5. Security & Boundary Compliance Checklist
- [x] **Always Do**: All inputs defensively casted in `fromJson`; URLs validated before dispatching to `launchUrl`.
- [x] **Ask First**: If adding third-party network APIs or analytics trackers, require user signoff in `plan.md`.
- [x] **Never Do**: No secrets committed; no PII logged to analytics; no raw shell code in client runtime.
- [x] Screen reader accessibility labels and high contrast ratios (>7:1) meeting WCAG AA standards.
