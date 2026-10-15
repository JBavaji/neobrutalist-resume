---
name: test-driven-development
description: Drives development with tests using the red-green-refactor loop. Use when implementing any logic, fixing any bug, or changing any behavior. Use when you need to prove that code works, when a bug report arrives, or when modifying existing functionality.
---

# Test-Driven Development (TDD)

## Overview
Write a failing test before writing the code that makes it pass. For bug fixes, reproduce the bug with a test before attempting a fix. Tests are proof — "seems right" is not done.

## Discover the Stack First
The TDD cycle is universal; the commands are not. Before writing the first test, discover how *this* repository tests, and use its native commands for every loop:
1. **Language and build system**: `package.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `Makefile`.
2. **Checked-in wrappers**: Prefer `./gradlew`, `./mvnw`, `make test`, or local project scripts.
3. **Focused vs Full suite**: Discover how the repository runs a **single focused test** during the inner loop vs the **full test suite** before submission.
4. **Existing conventions**: Test directory layout, naming patterns (`*_test.go`, `*.test.ts`, `test_*.py`).

## The TDD Cycle

```
    RED                GREEN              REFACTOR
 Write a test    Write minimal code    Clean up the
 that fails  ──→  to make it pass  ──→  implementation  ──→  (repeat)
      │                  │                    │
      ▼                  ▼                    ▼
   Test FAILS        Test PASSES         Tests still PASS
```

- **Step 1: RED**: Write the test first. It must fail. A test that passes immediately proves nothing.
- **Step 2: GREEN**: Write the minimum code required to make the test pass. Avoid premature abstraction.
- **Step 3: REFACTOR**: Clean up naming, extract shared utilities, and remove duplication while keeping tests green.

## The Prove-It Pattern (Strict Bugfix Lifecycle)
When a bug is reported, **never start by trying to fix it in production code**:
1. Write a test that reproduces the exact failure scenario.
2. Run the test and confirm it **FAILS** (proving the bug exists).
3. Implement the fix in production code.
4. Run the test and confirm it **PASSES** (proving the fix works).
5. Run the full test suite to ensure zero regressions across the codebase.

## The Beyoncé Rule & Test Pyramid
> *If you liked it, you should have put a test on it.*
- **Unit Tests (~80%)**: Pure logic, isolated, runs in milliseconds.
- **Integration Tests (~15%)**: Component interactions, database queries, API boundaries.
- **E2E Tests (~5%)**: Full user flows, browser/device level.
