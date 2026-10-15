---
name: incremental-implementation
description: Delivers changes incrementally in thin, verifiable slices. Use when implementing any feature or change that touches more than one file, or when picking up the next task from a plan. Use when rolling a change out behind a feature flag, when you're about to write a large amount of code at once, or when a task feels too big to land in one step.
---

# Incremental Implementation

## Overview
Build in thin vertical slices — implement one piece, test it, verify it, then expand. Avoid implementing an entire feature in one pass. Each increment should leave the system in a working, testable state.

## Rule 0: Simplicity First (Anti-Abstraction Guard)
Before writing any code, ask: *"What is the simplest thing that could work?"*
- Can this be done in fewer lines?
- Are these abstractions earning their complexity?
- Am I building for hypothetical future requirements or the current task?

### Simplicity Checks
- ✗ Generic EventBus with middleware pipeline for one notification $\longrightarrow$ ✓ Simple function call.
- ✗ Abstract factory pattern for two similar components $\longrightarrow$ ✓ Two straightforward components with shared utilities.
- ✗ Config-driven dynamic form engine for three forms $\longrightarrow$ ✓ Three clean form components.

## Slicing Strategies

### 1. Vertical Slices (Default)
Build one complete path through the stack:
- *Slice 1*: Create a resource (DB + API + basic UI) $\to$ Tests pass, functional end-to-end.
- *Slice 2*: List resources (query + API + UI) $\to$ Tests pass, verified.
- *Slice 3*: Edit/Delete resources $\to$ Tests pass, full CRUD complete.

### 2. Risk-First Slicing
Tackle the riskiest or most uncertain piece first to fail fast before investing in downstream components:
- *Slice 1*: Prove WebSocket or third-party connection works (Highest Risk).
- *Slice 2*: Build domain logic on top of the proven connection.
- *Slice 3*: Add resilience, reconnects, and UI state.

### 3. Contract-First Slicing (Parallel Development)
When backend and frontend work in parallel across subagents:
- *Slice 0*: Define API contracts (OpenAPI / types / interfaces).
- *Slice 1a*: Backend agent implements logic against contract + API tests.
- *Slice 1b*: Frontend agent implements UI against mock data matching contract.
- *Slice 2*: Integrate and verify end-to-end.
