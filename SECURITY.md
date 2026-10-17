# 🛡️ Security Policy

## Supported Versions

We release patches and security improvements for the active `main` branch. Because this is a static client-side web application compiled via Flutter Web and hosted on GitHub Pages, security updates apply to the latest release on `main`.

| Version / Branch | Supported          |
| ---------------- | ------------------ |
| `main`           | :white_check_mark: |
| Forks / Tags     | Best effort        |

---

## 🔒 Reporting a Vulnerability

We take the security of this open-source template seriously. If you discover a security vulnerability or potential threat vector, please report it responsibly:

1. **Do NOT open a public GitHub issue.**
2. Send an email to **[jbavaji@gmail.com](mailto:jbavaji@gmail.com)** with the subject line:  
   `[SECURITY]: Vulnerability Report - Neobrutalist Resume`.
3. Include detailed steps to reproduce the vulnerability, including:
   - Affected file(s) or dependencies
   - Proof-of-concept payload or reproduction instructions
   - Expected vs actual impact
4. We will acknowledge receipt of your vulnerability report within **48 hours** and coordinate a fix prior to public disclosure.

---

## 🏛️ STRIDE Threat Model Summary

As part of our **AI-Native SDLC (Stage 2: Technical Specification & Threat Model)**, the following security controls are actively enforced in the codebase:

* **Spoofing & Script Injection:** All external hyperlinks dispatched via `ResumeFooterWidget` and social badges validate the URI scheme against an explicit whitelist (`http`, `https`, `mailto`, `tel`) to prevent `javascript:` or `file:` pseudo-protocol execution.
* **Tampering:** `ResumeData.fromJson` implements strict null-safe fallbacks for every property to guard against corrupt local storage or malformed JSON payloads.
* **Repudiation:** All code changes must pass through verified GitHub pull requests and automated CI quality gates.
* **Information Disclosure:** The repository is guarded by `make token-audit` to prevent credential, secret, or API token leaks into git history.
* **Denial of Service:** Pure client-side static compilation served over GitHub's distributed global CDN ensures zero server crash vulnerabilities.
* **Elevation of Privilege:** Zero server-side runtime code; the app executes in the browser's sandboxed WebAssembly CanvasKit runtime.
