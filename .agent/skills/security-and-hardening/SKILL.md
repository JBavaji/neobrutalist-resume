---
name: security-and-hardening
description: Hardens code against vulnerabilities using threat modeling (STRIDE), boundary validation, and secure defaults. Use when handling user input, auth, external integrations, or reviewing security risk.
---

# Security and Hardening

## Overview
Security-first development practices. Treat every external input as hostile, every secret as sacred, and every authorization check as mandatory. Security is an architectural constraint across every line of code touching user data, authentication, or external systems.

## Process: Threat Model First
Controls bolted on without a threat model are guesses. Before writing code:

1. **Map Trust Boundaries**: Identify where untrusted data crosses into the system: HTTP endpoints, file uploads, webhooks, third-party APIs, and **LLM outputs**.
2. **Name the Assets**: What is worth stealing or corrupting? Credentials, PII, session tokens, money movement.
3. **Run STRIDE Analysis**:
   - **S**poofing: Can someone impersonate a user/service? (Auth, signature verification)
   - **T**ampering: Can data be altered? (Integrity checks, parameterized queries)
   - **R**epudiation: Can actions be denied? (Immutable security audit logs)
   - **I**nformation Disclosure: Can data leak? (Field allowlists, generic error messages)
   - **D**enial of Service: Can it be overwhelmed? (Rate limiting, input size limits, timeouts)
   - **E**levation of Privilege: Can a user gain rights they shouldn't? (Resource-level authz)
4. **Write Abuse Cases Next to Use Cases**: Ask "how would an attacker misuse this?" — then make that your first test.

## The Three-Tier Security Boundary System

### Always Do (No Exceptions)
- **Validate all external input** with schemas at boundaries (allowlisted shapes, lengths, formats).
- **Parameterize all database queries** — never concatenate user input into queries.
- **Encode output** to prevent XSS (rely on framework auto-escaping).
- **Enforce HTTPS** and strict security headers (CSP, HSTS, X-Frame-Options).
- **Hash passwords** with bcrypt (>=12 rounds), scrypt, or argon2.
- **Use httpOnly, secure, sameSite cookies** with bounded maxAge.
- **Audit lockfiles** with package manager security scanners.

### Ask First (Requires Human Approval Gate)
- Adding new authentication flows or modifying auth logic.
- Storing new categories of sensitive data (PII, payment info).
- Adding new external service integrations.
- Modifying CORS policies or rate limiting rules.
- Adding file upload handlers.
- Granting elevated permissions or roles.

### Never Do
- **Never commit secrets** (API keys, passwords, private keys).
- **Never log sensitive data** (passwords, tokens, credit card details).
- **Never trust client-side validation** as a security boundary.
- **Never use `eval()` or `innerHTML`** with untrusted user input.
- **Never store auth tokens in client-accessible storage** (localStorage).
- **Never expose internal stack traces** or database errors to end users.
