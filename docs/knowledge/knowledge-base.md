# Neobrutalist Resume Knowledge Base

## Core Architectural Invariants
1. **Zero Hardcoded Content**: Resume data must reside exclusively in `assets/data/resume_data.json` or `template_resume_data.json`. Widgets consume `ResumeData` models.
2. **Neobrutalist Visual Identity**:
   - Palette: Canvas `#ECE8DF`, Card `#DBD7CE`, Ink `#111111`, White `#FAF9F6`, Blue Focus `#3B82F6`.
   - Typography: Google Fonts *Plus Jakarta Sans* (w700-w900) for headers/badges, *Space Mono* (w400-w700) for body/pills.
   - Borders: Strict 1.8px - 2.2px solid black borders.
   - Angled Sticker: Rotation `-3.5°` with `-1px 2px 0px` hard shadow.
3. **Dual Export Engine**:
   - Web print uses browser layout via `Printing.layoutPdf`.
   - Vector export generates high-resolution 300+ DPI PDF via `package:pdf` and `Printing.sharePdf`.
4. **Interactive Edit Mode**:
   - Uses `InlineEditableText` matching HTML `contenteditable`.
   - Edits persist to browser `SharedPreferences` under key `neobrutalist_resume_saved_v1`.
