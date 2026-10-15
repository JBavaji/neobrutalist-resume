---
name: planning-and-task-breakdown
description: Breaks work into ordered, testable vertical tasks. Use when you have a spec or requirements and need to break work into implementable units, when scope feels too large, or when parallelizing across multiple agents.
---

# Planning and Task Breakdown

## Overview
Decompose work into small, verifiable vertical tasks with explicit acceptance criteria. Every task should be small enough to implement, test, and verify in a single focused session without leaving the build broken.

## When to Use
- You have a spec and need to break it into implementable units
- A task feels too large, ambiguous, or risky to start directly
- Work needs to be parallelized across multiple worktrees or subagents
- You need to communicate exact scope and checkpoints to a human
- The implementation order isn't obvious

*When NOT to use*: Single-file changes with obvious scope (<50 LOC), or when a bugfix has a reproduction test.

## Core Principles

### 1. Vertical Slicing Over Horizontal Slicing
Instead of building all database tables, then all API endpoints, then all UI views:
- **Anti-Pattern (Horizontal Slicing)**:
  - Task 1: Build entire database schema
  - Task 2: Build all API endpoints
  - Task 3: Build all UI components
  - Task 4: Wire everything together (High risk of integration failure!)
- **Recommended Pattern (Vertical Slicing)**:
  - Slice 1: User Registration (Schema + Endpoint + UI + Test) → Fully working & verified.
  - Slice 2: User Login (Schema + Endpoint + UI + Test) → Fully working & verified.
  - Slice 3: Task Creation (Schema + Endpoint + UI + Test) → Fully working & verified.

Each vertical slice delivers working, testable functionality.

### 2. Identify the Dependency Graph Bottom-Up
Map dependencies before ordering work:
```
Database Schema & Migrations
    └── Core Models & Data Contracts
            └── Domain Business Logic & Services
                    └── Presentation, Handlers & UI Components
```
Build foundations first, then layer dependencies sequentially.

### 3. Checkpoints Every 2–3 Tasks
Add explicit human checkpoints in `plan.md` to review progress and verify that the system remains green:
```markdown
## Checkpoint: After Slices 1 & 2
- [ ] All unit & integration tests pass: `make test`
- [ ] Application builds without errors: `make build`
- [ ] Core user flow works end-to-end
- [ ] Review with human code owner before starting Slice 3
```

### 4. Task Sizing Guidelines
| Size | Files Touched | Scope | Example |
| :---: | :---: | :--- | :--- |
| **XS** | 1 | Single function or config tweak | Add validation rule |
| **S** | 1–2 | Single component or endpoint | Add new query endpoint |
| **M** | 3–5 | Complete vertical feature slice | User registration flow |
| **L** | 5–8 | Multi-component subsystem | Payment gateway integration |
| **XL** | 8+ | Architectural migration | Must be decomposed further! |
