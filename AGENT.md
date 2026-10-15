# AGENT Memory Bank: Flutter Neobrutalist Resume

## Project Overview
- Purpose: Flagship open-source Neobrutalist Resume template built in Flutter & Dart.
- Supported AI Environments: Antigravity, Claude Code, GitHub Copilot, Cursor, Windsurf, Codex.
- Architecture: Clean Architecture (Domain Models, Asset JSON Loader, Neobrutalist UI, PDF Export).
- Primary Target: Flutter Web (responsive desktop & mobile web, GitHub Pages).
- Meta-Governance: Orchestrated via `.agent/skills/using-agent-skills/SKILL.md`

## Deterministic Build & Verification Commands
- Check Environment: `make check-env`
- Format & Fix: `make fix`
- Format Check & Lint: `make lint`
- Run All Tests: `make test`
- Build Flutter Web: `make build`
- Run Local Web Server: `make run`
- Token Audit: `make token-audit`

## Mandatory Pre-Flight Health Check (Step 0)
- Before modifying or adding code, verify baseline with `make lint` and `make test`.
- Never write code on a broken baseline without halting and reporting first.

## Operating Invariants & Meta-Routing
- **Route Before Execution**: Route tasks through `.agent/skills/using-agent-skills/` to load the matching phase skill.
- **Surface Assumptions**: Explicitly state assumptions before implementation; never silently guess.
- **Active Confusion Management**: If requirements conflict with code or spec, STOP and resolve immediately.
- **Push Back When Warranted**: Act as a senior engineering partner. Challenge bad architecture and suggest simpler paths.

## Triage & Complexity Tiering
- **Tier 1 (Fast Path)**: Minor text or asset typo fixes (<50 LOC). Bypass grilling; repro test -> fix -> `make test`.
- **Tier 2 (Standard Feature)**: 1-2 targeted questions. Scaffold in `docs/features/<TICKET-ID>/`.
- **Tier 3 (Architectural)**: Mandatory 4-pillar "Grill-Me" protocol with written mutual signoff.

## Execution Rules & Quality Gates
- **Mathematical Gate**: Confidence >= 95, Clarity >= 95, Ambiguity <= 5, Assumptions <= 5.
- **Rule 0: Simplicity First**: What is the simplest thing that works? Reject premature abstractions.
- **The Prove-It Pattern**: Write a failing reproduction test FIRST before modifying production code.
- **Zero-Bloat Data Layer**: Content changes must be configurable in `assets/data/resume_data.json`.
- **Plan Adherence**: Follow `docs/plan.md` sequentially. If unexpected deviations occur, STOP and notify user.
- **Git Safety**: Never push directly to `main`/`master` without approval; never force push.

## Knowledge Retention & Continuity
- Consult `docs/knowledge/knowledge-base.md` before starting work.
- Update `docs/knowledge/lessons-learned.md` after rework or significant pattern discoveries.

## Watchlist & Anti-Patterns (Strictly Enforced)
- Do NOT hardcode resume content into UI widgets; keep widgets generic and data-driven.
- Do NOT delete or weaken unit tests to force a failing suite to pass.
- Preserve Neobrutalist design tokens (hard borders, high contrast, offset angles, custom icons).
- Never commit secrets, build cache (`.dart_tool/`, `build/`), or API keys.
