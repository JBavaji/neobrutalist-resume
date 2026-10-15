# Rule: Inversion & Proactive Clarification Protocol

Stop guessing. Invert the interaction by demanding targeted clarification whenever instructions are underspecified.

---

## 1. The Core Inversion Principle

When a user request contains ambiguity, the agent's natural failure mode is to **guess the user's intent**, author hundreds of lines of code, and force the user to debug incorrect assumptions.

The **Inversion Principle** dictates:
> When faced with underspecified requirements, the agent's primary output must **NOT** be code or architectural speculation. It must **invert the burden** by presenting a structured decision tree with bounded options and recommended defaults.

---

## 2. Inversion Rules of Engagement

1. **Never Assume Bounded Trade-offs**:
   - If a prompt says *"make search faster"*, do not silently add Redis, an in-memory Trie, or an Elasticsearch container.
   - **Invert**: Ask whether the requirement is database indexing (B-Tree), caching layer, or client-side debouncing.

2. **Present Multiple-Choice Options with a Recommended Default**:
   Always format questions with clear options so the human can approve with a single letter or word:
   ```markdown
   To proceed with rate limiting, we have two architectural options:
   - (Option A - Recommended): Token bucket sliding window backed by existing Redis cluster.
   - (Option B): In-memory sliding log (avoids Redis dependency, but does not synchronize across distributed containers).
   
   Which approach fits our production deployment model?
   ```

3. **Inversion of File Boundaries (Non-Goals)**:
   Explicitly declare what files or subsystems will **NOT** be modified:
   > *"I will implement the auth token refresh in `internal/auth/`. I will NOT modify database schemas or user session tables. Please confirm before I proceed."*

4. **Stop-and-Clarify Triggers**:
   Immediately pause and execute the Inversion Protocol if:
   - Acceptance criteria contain subjective words (*"clean"*, *"faster"*, *"better UX"*).
   - A proposed change requires a new third-party dependency.
   - The user's request would touch more than 5 existing files in a single pass.
