# Architecture Decision Records (ADR) — MADR 4.0

**Source:** adr.github.io/madr | **Version:** MADR 4.0.0 (2024-09-17)

## Overview

Architecture Decision Records capture significant architectural decisions with their context, options considered, and outcome. Use MADR (Markdown Architectural Decision Records) format — lightweight, version-controllable, and tool-agnostic.

**When to write an ADR:**
- Choosing between two or more viable technical approaches
- Adopting a new framework, library, or service
- Establishing a cross-cutting pattern (auth, logging, error handling)
- Making a security design decision
- Any decision that would be costly to reverse

**File naming:** `docs/architecture/decisions/NNNN-short-title.md` (e.g., `0001-use-postgresql.md`)

---

## MADR 4.0 Full Template

```markdown
---
status: {proposed | rejected | accepted | deprecated | superseded by [ADR-NNNN](NNNN-example.md)}
date: YYYY-MM-DD
decision-makers: [list of names]
consulted: [list of names — two-way communication]
informed: [list of names — one-way communication]
---

# [Short title — noun phrase, present tense, e.g., "Use PostgreSQL for primary data store"]

## Context and Problem Statement

[Describe the context and problem statement in 2-4 sentences. What situation led to this decision? What constraint or requirement must be satisfied?]

<!-- Optional: Use a decision driver to frame the problem as a question -->
<!-- How do we [achieve X] while [satisfying Y constraint]? -->

## Decision Drivers

* [Key driver 1 — e.g., "Must support horizontal scaling"]
* [Key driver 2 — e.g., "Team has existing expertise with relational databases"]
* [Key driver 3 — e.g., "Must meet PCI-DSS data encryption requirements"]

## Considered Options

* [Option A — name only here, detail below]
* [Option B]
* [Option C]

## Decision Outcome

Chosen option: **"[Option X]"**, because [justification in 1-2 sentences — why this option best satisfies the decision drivers].

### Consequences

* Good: [positive consequence]
* Good: [positive consequence]
* Bad: [trade-off accepted]
* Neutral: [notable side effect]

### Security Implications

<!-- REQUIRED — do not omit -->
* [Security impact of this decision — positive or negative]
* [New attack surface introduced, if any]
* [Mitigations applied or required]
* [Relevant framework: e.g., OWASP A02 Cryptographic Failures, NIST CSF PR.DS-1]

### Confirmation

[How will we know this decision is implemented correctly? What validates it?]
* [ ] [Validation step 1]
* [ ] [Validation step 2]

## Pros and Cons of the Options

### [Option A]

* Good, because [argument]
* Good, because [argument]
* Bad, because [argument]
* Neutral, because [argument]

### [Option B]

* Good, because [argument]
* Bad, because [argument]

### [Option C]

* Good, because [argument]
* Bad, because [argument]

## More Information

[Links to relevant documentation, prior decisions, external resources]
* Related: [ADR-NNNN](NNNN-related.md)
* Reference: [external link]
```

---

## Minimal Template (for straightforward decisions)

```markdown
---
status: accepted
date: YYYY-MM-DD
decision-makers: [names]
---

# [Title]

## Context and Problem Statement

[2-3 sentences: situation and problem]

## Considered Options

* [Option A]
* [Option B]

## Decision Outcome

Chosen: **[Option A]**, because [reason].

### Security Implications

* [Security impact — required even for non-security decisions]
```

---

## ADR Status Lifecycle

```
proposed → accepted → deprecated
         ↘ rejected
           accepted → superseded by ADR-NNNN
```

- **proposed:** Under discussion, not yet decided
- **accepted:** Decision made, should be implemented
- **deprecated:** No longer relevant (context changed), not replaced
- **superseded:** Replaced by a newer ADR (link to it)
- **rejected:** Considered and deliberately not chosen

---

## Common ADR Topics for Software Architecture

| Domain | Example ADR Titles |
|---|---|
| Data | "Use PostgreSQL as primary data store", "Adopt event sourcing for order domain" |
| API | "Use REST over GraphQL for public API", "Version APIs via URL path" |
| Auth | "Delegate authentication to external OIDC provider", "Use JWT with short expiry + refresh tokens" |
| Deployment | "Containerize all services with Docker", "Use Kubernetes for container orchestration" |
| Security | "Enforce mTLS for internal service communication", "Apply Zero Trust network architecture" |
| Patterns | "Use repository pattern for data access", "Adopt CQRS for read-heavy domains" |
| Observability | "Use OpenTelemetry for distributed tracing", "Centralize logs in Elasticsearch" |

---

## Agent Instructions: Writing ADRs

1. **One ADR per decision.** Never combine unrelated decisions.
2. **Security Implications section is mandatory** — even for non-security decisions (assess impact, even if "none").
3. **Always list ≥2 options.** A decision with one option considered is not a decision — it's an assumption.
4. **Status must be set.** Default to `proposed` if not yet confirmed.
5. **Number sequentially.** Check existing ADRs in `docs/architecture/decisions/` before numbering.
6. **Link related ADRs.** If this supersedes or relates to another, link it explicitly.
7. **Date is the decision date,** not the writing date.
