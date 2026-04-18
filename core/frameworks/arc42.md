# arc42 Architecture Document Template

**Source:** arc42.org | **Version:** Current (actively maintained)

## Overview

arc42 is a pragmatic, tool-agnostic template for architecture documentation. It has 12 sections — use only those that add value. Sections 5, 6, and 7 form the structural core.

**File location:** `docs/architecture/arc42/` or `docs/architecture/README.md`

---

## Template

```markdown
# Architecture Documentation: [System Name]

**Version:** x.y
**Date:** YYYY-MM-DD
**Status:** {Draft | Review | Approved}
**Authors:** [names]

---

## 1. Introduction and Goals

### Requirements Overview
[Short description of the top 3-5 functional requirements driving the architecture. Not an exhaustive spec — just the ones that have architectural impact.]

### Quality Goals
[Top 3-5 quality attributes (NFRs) with measurable targets]

| Priority | Quality Attribute | Scenario | Target |
|---|---|---|---|
| 1 | Availability | System must handle payment processing 24/7 | 99.95% uptime |
| 2 | Security | All PII must be encrypted at rest and in transit | AES-256, TLS 1.3 |
| 3 | Performance | API response time under load | p95 < 200ms at 1000 RPS |

### Stakeholders
| Role | Concern | Contact |
|---|---|---|
| Engineering Lead | Technical correctness, maintainability | |
| Product Manager | Feature delivery, user impact | |
| Security Team | Compliance, threat surface | |
| Operations | Deployability, observability | |

---

## 2. Architecture Constraints

### Technical Constraints
| Constraint | Background / Reason |
|---|---|
| Must run on AWS | Existing infrastructure investment |
| Must use PostgreSQL | Data team standardized tooling |
| Must support SOC 2 Type II | Customer contractual requirement |

### Organizational Constraints
| Constraint | Background / Reason |
|---|---|
| Team of 5 engineers | Limits complexity of distributed systems |
| 3-month delivery window | MVP scope constrained |

### Conventions
| Convention | Background |
|---|---|
| REST APIs use OpenAPI 3.1 | API-first development standard |
| All services containerized | Platform team requirement |

---

## 3. System Scope and Context

### Business Context
[Who uses the system and how. Include diagram from C4 Level 1.]

```mermaid
C4Context
  [Insert Level 1 System Context diagram here]
```

### Technical Context
[External systems and protocols. Which protocols cross which boundaries?]

| Neighbor | Protocol | Direction | Data Exchanged |
|---|---|---|---|
| Auth Provider | OIDC/HTTPS | Inbound (token validation) | JWT claims |
| Payment Gateway | REST/HTTPS | Outbound | Payment instructions |
| Email Service | REST/HTTPS | Outbound | Notification payloads |

---

## 4. Solution Strategy

[3-5 bullet points: the fundamental decisions that shaped the architecture. Link to relevant ADRs.]

* **[Decision 1]** — [1-sentence rationale] → [ADR-0001](../decisions/0001-*.md)
* **[Decision 2]** — [1-sentence rationale] → [ADR-0002](../decisions/0002-*.md)
* **[Security posture]** — Zero Trust network model; all internal service calls require mTLS → [ADR-0003](../decisions/0003-*.md)

---

## 5. Building Block View

### Level 1 — Overall System
[C4 Container diagram: main containers and their responsibilities]

```mermaid
C4Container
  [Insert Level 2 Container diagram here]
```

| Container | Responsibility | Technology |
|---|---|---|
| Web App | Serves UI, handles user interaction | React + Next.js |
| API Service | Business logic, orchestration | Node.js + Express |
| Database | Persistent data store | PostgreSQL 15 |

### Level 2 — [Container Name] Internals
[Only for complex containers. C4 Component diagram.]

```mermaid
C4Component
  [Insert Level 3 Component diagram here — only if needed]
```

---

## 6. Runtime View

[Show how containers collaborate at runtime for the most important use cases. Use sequence diagrams.]

### Use Case 1: [Name — e.g., User Authentication]

```mermaid
sequenceDiagram
  [Insert sequence diagram here]
```

### Use Case 2: [Name — e.g., Payment Processing]

```mermaid
sequenceDiagram
  [Insert sequence diagram here]
```

---

## 7. Deployment View

[How and where is the system deployed? Infrastructure, environments, scaling.]

```mermaid
C4Deployment
  [Insert deployment diagram here]
```

| Environment | Purpose | Notes |
|---|---|---|
| Development | Local developer machines | Docker Compose |
| Staging | Pre-production validation | Mirrors prod, reduced capacity |
| Production | Live traffic | Multi-AZ, auto-scaling |

---

## 8. Crosscutting Concepts

### 8.1 Security (REQUIRED)
[Security patterns applied throughout the system. Not optional.]

**Authentication & Authorization:**
* Pattern: [e.g., OAuth2 + OIDC, JWT bearer tokens, RBAC]
* Every API endpoint requires a valid bearer token (except health checks)
* Authorization: [RBAC / ABAC / scoped claims] — describe the model

**Encryption:**
* In transit: TLS 1.3 minimum on all connections
* At rest: AES-256 for database and object storage
* Secrets: [secret management approach — e.g., AWS Secrets Manager, Vault]

**Input Validation:**
* All user inputs validated at API boundary before processing
* Parameterized queries only — no string concatenation in DB calls
* Reference: OWASP A03 Injection

**Zero Trust:**
* No implicit trust between services — all internal calls authenticated
* Reference: NIST SP 800-207

**Compliance posture:**
* [List applicable: PCI-DSS, HIPAA, ISO 27001, SOC 2]
* [1 sentence on how the architecture addresses each]

### 8.2 Observability
* Logging: structured JSON logs, correlation IDs on all requests
* Tracing: OpenTelemetry distributed tracing
* Metrics: [Prometheus / CloudWatch / Datadog]
* Alerting: [on-call rotation, SLO-based alerts]

### 8.3 Error Handling
* [Pattern: e.g., fail fast, circuit breakers, retry with backoff]
* [User-facing errors never expose internals — generic messages only]

### 8.4 Configuration Management
* [Environment variables via .env / secrets manager]
* [No secrets in source code or container images]

---

## 9. Architecture Decisions

[Index of ADRs — do not duplicate content, just link]

| ADR | Title | Status | Date |
|---|---|---|---|
| [ADR-0001](../decisions/0001-*.md) | [Title] | Accepted | YYYY-MM-DD |
| [ADR-0002](../decisions/0002-*.md) | [Title] | Accepted | YYYY-MM-DD |

---

## 10. Quality Requirements

### 10.1 Quality Overview
[Quality tree or table mapping quality attributes to architectural measures]

| Quality Attribute | Measure | Architectural Approach |
|---|---|---|
| Availability | 99.95% uptime | Multi-AZ deployment, health checks, auto-restart |
| Security | Zero critical vulnerabilities | SAST in CI, DAST quarterly, pen test annually |
| Performance | p95 < 200ms | Caching layer, DB indexing, async processing |

### 10.2 Quality Scenarios
[Specific scenarios that validate quality goals]

| ID | Quality | Scenario | Expected Response |
|---|---|---|---|
| QS-01 | Availability | Database primary fails | Failover to replica < 30s, zero data loss |
| QS-02 | Security | Attacker attempts SQL injection | Request rejected, 400 returned, attempt logged |
| QS-03 | Performance | 1000 concurrent users hit API | p95 response < 200ms, no errors |

---

## 11. Risks and Technical Debt

### Risks (REQUIRED — include security risks)
| ID | Risk | Probability | Impact | Mitigation | Owner |
|---|---|---|---|---|---|
| R-01 | [e.g., Third-party auth provider outage] | Medium | High | Fallback auth, SLA monitoring | Platform |
| R-02 | [e.g., SQL injection in legacy endpoint] | Low | Critical | Code audit, parameterized queries | Security |
| R-03 | [e.g., PCI-DSS scope creep] | Medium | High | Isolate cardholder data environment | Architect |

### Technical Debt
| ID | Description | Impact | Resolution Plan |
|---|---|---|---|
| TD-01 | [e.g., Authentication bypasses in admin panel] | High | Sprint 12 |
| TD-02 | [e.g., No rate limiting on public API] | Medium | Next quarter |

---

## 12. Glossary

| Term | Definition |
|---|---|
| [Term] | [Definition] |
| Bounded Context | A DDD concept: a boundary within which a domain model is defined and consistent |
| Zero Trust | Security model: never trust, always verify — no implicit trust based on network location |
| ADR | Architecture Decision Record — a document capturing a significant architectural decision |
```

---

## Agent Instructions: Producing arc42 Documents

1. **Always include sections 1, 2, 3, 5, 8, 11** — minimum viable arc42 doc.
2. **Section 8.1 Security is mandatory** — never omit it.
3. **Section 11 Risks must include security risks** — list at least R-01 as a security risk.
4. **Use C4 diagrams** in sections 3, 5, 6, 7 — embed as Mermaid code blocks.
5. **Link ADRs** in sections 4 and 9 — don't duplicate, just reference.
6. **Scale to project size** — a microservice needs a shorter doc than a platform.
7. **File location:** `docs/architecture/arc42.md` or `docs/architecture/README.md`
