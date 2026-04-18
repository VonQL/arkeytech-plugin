# TOGAF 10 Reference

**Source:** The Open Group | **Version:** TOGAF 10 (2022), modular structure

## Overview

TOGAF (The Open Group Architecture Framework) provides a structured approach to enterprise architecture development through the Architecture Development Method (ADM). TOGAF 10 introduced a modular structure — use only the content relevant to your context.

**When to apply TOGAF:**
- Enterprise-wide architecture initiatives
- Large-scale transformation programs
- Government or regulated industry engagements
- Multi-domain architecture (business + data + application + technology)

---

## ADM Phases and Key Artifacts

| Phase | Name | Key Artifacts Produced |
|---|---|---|
| Preliminary | Preparation | Architecture Principles, Architecture Repository setup |
| A | Architecture Vision | Statement of Architecture Work, Architecture Vision doc |
| B | Business Architecture | Business capability map, value streams, org map |
| C | Information Systems Architecture | Data and Application architecture docs |
| D | Technology Architecture | Technology architecture doc, infrastructure mapping |
| E | Opportunities & Solutions | Implementation roadmap, transition architectures |
| F | Migration Planning | Migration plan, architecture contracts |
| G | Implementation Governance | Architecture contracts, compliance review |
| H | Architecture Change Management | Change requests, impact assessments |
| Requirements Management | (Continuous) | Requirements Impact Assessment |

---

## Key Artifact Templates

### Architecture Vision (Phase A)

```markdown
# Architecture Vision: [Initiative Name]

**Version:** 1.0 | **Date:** YYYY-MM-DD | **Status:** Draft

## Executive Summary
[2-3 sentences: what is being built, why, and expected business value]

## Business Goals and Drivers
| Driver | Description | Priority |
|---|---|---|
| [e.g., Digital transformation] | [Context] | High |

## Architecture Scope
* **Time horizon:** [e.g., 18-month roadmap]
* **Business domains in scope:** [list]
* **Business domains out of scope:** [list]
* **Stakeholders:** [list key stakeholders and their concerns]

## Key Architecture Requirements
| ID | Requirement | Type | Source |
|---|---|---|---|
| AR-01 | [e.g., All customer data must be encrypted] | Security | CISO |
| AR-02 | [e.g., 99.9% availability SLA] | Availability | CTO |

## Target Architecture Summary
[High-level description of the target state — 1-2 paragraphs]

## Constraints and Assumptions
* [Constraint 1]
* [Assumption 1]

## Security and Compliance Posture
* Applicable regulations: [ISO 27001 / SOC 2 / PCI-DSS / HIPAA]
* Security principles: [Zero Trust / Defense in depth / Least privilege]
* Risk appetite: [Low / Medium / High]
```

### Architecture Definition Document (ADD)

```markdown
# Architecture Definition Document: [System/Domain Name]

**Version:** 1.0 | **Date:** YYYY-MM-DD

## 1. Scope
[What architecture domains are covered: Business / Data / Application / Technology]

## 2. Architecture Principles
| ID | Principle | Rationale | Implication |
|---|---|---|---|
| P-01 | Security by Design | Embed security from inception | Security review required in every sprint |
| P-02 | API-First | All integrations via documented APIs | No direct DB-to-DB integration |
| P-03 | Zero Trust | No implicit trust by network location | All services authenticate each other |

## 3. Business Architecture
### Business Capability Map
[Table or diagram of business capabilities]

| Capability | Definition | Maturity | System Supporting |
|---|---|---|---|
| [e.g., Customer Onboarding] | [Definition] | [1-5] | [System name] |

### Value Streams
[Key end-to-end value streams — how value flows from customer need to delivery]

## 4. Data Architecture
### Conceptual Data Model
[Key entities and their relationships at business level]

### Data Classification
| Data Type | Classification | Examples | Controls Required |
|---|---|---|---|
| PII | Confidential | Name, email, SSN | Encryption, access logging, retention policy |
| Financial | Restricted | Card numbers, balances | PCI-DSS scope, tokenization |
| Operational | Internal | Logs, metrics | Standard controls |
| Public | Public | Product catalog | No special controls |

## 5. Application Architecture
[Key systems and their relationships — link to C4 diagrams]

## 6. Technology Architecture
[Infrastructure, platforms, middleware]

### Technology Standards
| Layer | Standard Technology | Approved Alternatives | Prohibited |
|---|---|---|---|
| Container runtime | Docker | Podman | None |
| Orchestration | Kubernetes | ECS | Raw VMs |
| Database | PostgreSQL 15+ | MySQL 8+ | Oracle (license cost) |

## 7. Architecture Roadmap
| Phase | Deliverable | Timeline | Dependencies |
|---|---|---|---|
| Phase 1 | [e.g., Core platform, auth, APIs] | Q1 2026 | Cloud account setup |
| Phase 2 | [e.g., Domain services] | Q2 2026 | Phase 1 complete |

## 8. Architecture Compliance
[How will implementation be verified against this architecture?]
* Architecture review board process
* Compliance checkpoints at: [sprint review / pre-deployment / quarterly]
```

### Architecture Contract (Phase F/G)

```markdown
# Architecture Contract: [Project/System Name]

**Parties:** Architecture Team ↔ Development Team
**Date:** YYYY-MM-DD | **Version:** 1.0

## Agreed Architecture
[Reference to ADD and key diagrams]

## Conformance Requirements
The implementing team agrees to:
- [ ] Follow the approved technology standards (see Section 6 of ADD)
- [ ] Submit all significant deviations as ADRs for review
- [ ] Pass architecture compliance review before production deployment
- [ ] Meet the security requirements in [Security Architecture doc]

## Architecture Deviations Process
Any deviation from the agreed architecture must:
1. Be documented as an ADR (see MADR template)
2. Be reviewed by the architecture team within 5 business days
3. Receive written approval before implementation

## Sign-off
| Role | Name | Date | Signature |
|---|---|---|---|
| Architect | | | |
| Engineering Lead | | | |
```

---

## TOGAF Architecture Principles (Standard Set)

Apply these as starting defaults — tailor per engagement:

| ID | Principle | Rationale |
|---|---|---|
| P-01 | Primacy of Principles | Architecture principles override individual preferences |
| P-02 | Maximize Benefit to Enterprise | Decisions serve the whole, not individual teams |
| P-03 | Information Management is Shared | Data is a shared asset, not owned by any one system |
| P-04 | Data is Accessible | Data is available to authorized users when needed |
| P-05 | Data is Protected | Data is protected from unauthorized access |
| P-06 | Technology Independence | Applications are independent of technology choices where possible |
| P-07 | Ease of Use | Interfaces are intuitive and consistent |
| P-08 | Requirements-Based Change | Only standards-based, requirements-driven changes |
| P-09 | Responsive Change Management | Changes are planned and managed |
| P-10 | Control Technical Diversity | Minimize technology variety to reduce cost and risk |
| P-11 | Interoperability | Software and hardware should conform to open standards |

---

## Agent Instructions: TOGAF Artifacts

1. **Don't apply TOGAF to small systems** — it's for enterprise-scale initiatives. For a single microservice, use arc42 instead.
2. **Modular adoption** — use only the phases and artifacts that add value. TOGAF 10 explicitly supports selective adoption.
3. **Security is crosscutting** — embed security considerations in every phase: architecture principles must include security principles, ADD must include data classification, contracts must include security conformance requirements.
4. **Link to other artifacts** — TOGAF artifacts reference C4 diagrams, ADRs, and arc42 docs. Don't duplicate.
5. **Always define data classification** in the Data Architecture section — this drives security controls.
