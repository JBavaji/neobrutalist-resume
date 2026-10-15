---
name: ci-cd-and-automation
description: Automates CI/CD pipeline setup. Use when setting up or modifying build and deployment pipelines. Use when you need to automate quality gates, configure test runners in CI, or establish deployment strategies.
---

# CI/CD and Automation

## Overview
Automate quality gates so no change reaches production without passing static analysis, tests, type checking, and builds. CI/CD is the deterministic enforcement mechanism for every other skill.

## Shift Left
Catch problems as early in the pipeline as possible:
$$\text{Lint / Format (Seconds)} \longrightarrow \text{Typecheck} \longrightarrow \text{Unit Tests} \longrightarrow \text{Build} \longrightarrow \text{Integration} \longrightarrow \text{Security Audit} \longrightarrow \text{Deploy}$$

A bug caught in linting costs minutes; the same bug caught in production costs hours.

## The Quality Gate Pipeline Rules
- **No Gate Can Be Skipped**: If lint fails, fix lint — don't disable the rule. If a test fails, fix code — never skip the test.
- **Faster is Safer**: Smaller batches and frequent releases reduce risk.
- **Fail Fast**: Run the cheapest static checks first, followed by unit tests, before spinning up heavy integration databases or browser containers.
