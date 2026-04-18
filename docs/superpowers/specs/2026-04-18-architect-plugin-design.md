# Architect Plugin — Design Specification

**Date:** 2026-04-18
**Status:** Approved
**Author:** vlagare

---

## 1. Purpose

A platform-agnostic AI plugin that spins up specialized agents to assist software, solution, enterprise, and cloud architects with:

- **Design** — system diagrams, architecture decisions, bounded context maps
- **Documentation** — arc42, ADRs, RFCs, API specs, executive summaries
- **Technical Validation** — security review, compliance gap analysis, Well-Architected reviews

The plugin works identically in **Claude Code** and **Cursor**, sharing a single core knowledge base. Security is embedded by default in every agent workflow, not treated as an optional checklist.

---

## 2. Scope

### In Scope
- Three specialized agents: Design, Docs, Validation
- Slash command entry points: `/architect design`, `/architect docs`, `/architect validate`, `/architect help`
- Auto-detection via file-pattern hooks (Claude Code) and glob rules (Cursor)
- Tiered outputs: technical depth for engineers, executive summaries for leadership
- Security-first defaults in every agent
- Platform adapters for Claude Code (skills + hooks) and Cursor (.mdc rules)
- Single-source core: all framework references, security checklists, and templates live in `core/`

### Out of Scope
- External API calls or runtime orchestration processes
- CI/CD pipeline integration (future phase)
- GUI or web dashboard
- Automatic commit/push of generated artifacts (user retains control)

---

## 3. Architecture

### Directory Structure

```
architect-plugin/
├── plugin.json                        ← manifest: name, version, description, platform targets
├── core/
│   ├── frameworks/
│   │   ├── c4.md                      ← C4 model (Levels 1–3), Mermaid templates
│   │   ├── adr.md                     ← MADR 4.0 template + decision guidance
│   │   ├── arc42.md                   ← 12-section arc42 template
│   │   ├── togaf.md                   ← TOGAF 10 key artifact stubs
│   │   ├── ddd.md                     ← Bounded context, event storming, ubiquitous language
│   │   └── well-architected.md        ← AWS/Azure/GCP pillar checklists (6 pillars each)
│   ├── security/
│   │   ├── threat-modeling.md         ← STRIDE + PASTA methodology + templates
│   │   ├── owasp.md                   ← Top 10 (2021), ASVS 4.0 verification checklist
│   │   ├── nist.md                    ← CSF 2.0 (6 functions), SP 800-53 Rev5, SP 800-207 ZTA
│   │   ├── compliance.md              ← ISO 27001:2022 (93 controls), SOC 2, PCI-DSS 4.0.1, HIPAA
│   │   └── cloud-security.md          ← CIS Benchmarks, AWS/Azure/GCP security pillars
│   └── templates/
│       ├── design-brief.md            ← full technical design output template
│       ├── security-review.md         ← STRIDE + checklist findings template
│       ├── validation-report.md       ← findings table: severity, framework ref, remediation
│       └── executive-summary.md       ← non-technical summary template
├── agents/
│   ├── design-agent/
│   │   └── SKILL.md                   ← Claude Code skill definition
│   ├── docs-agent/
│   │   └── SKILL.md
│   └── validation-agent/
│       └── SKILL.md
├── platform/
│   ├── claude-code/
│   │   └── hooks/
│   │       └── post-edit.sh           ← file-save hook for auto-detection
│   └── cursor/
│       └── rules/
│           ├── architect-design.mdc
│           ├── architect-docs.mdc
│           └── architect-validation.mdc
└── build.sh                           ← generates Cursor .mdc files from agent SKILL.md sources
```

### Key Principle
`core/` is the single source of truth. Platform adapters reference core content; they never duplicate it.

---

## 4. The Three Agents

### 4.1 Design Agent (`/architect design`)

**Purpose:** Guide the architect through system design — from blank canvas to a documented, security-annotated architecture.

**Auto-trigger signals:**
- Files saved in `architecture/`, `design/`
- Keywords in prompt: "ADR", "decision", "diagram", "design", "C4", "system"

**Workflow:**
1. Read existing context: codebase structure, stated problem, existing docs
2. Ask scoping questions: domain type, scale, key quality attributes (NFRs)
3. Produce design outputs (see Section 6)
4. Embed security annotations by default (see Section 5)

**Frameworks applied:**
- C4 Model (Context → Container → Component)
- MADR 4.0 for every significant architectural decision
- arc42 stub pre-filled from discovered context
- DDD: bounded context map + ubiquitous language glossary
- AWS/Azure/GCP Well-Architected Security Pillar inline

---

### 4.2 Docs Agent (`/architect docs`)

**Purpose:** Produce and maintain architecture documentation in the correct format for the correct audience.

**Auto-trigger signals:**
- Files saved in `docs/`, `adr/`, `*.adoc`, `*.md` in architecture directories
- Keywords: "document", "spec", "RFC", "runbook", "API"

**Workflow:**
1. Detect document type (ADR, RFC, runbook, API spec, arc42 section, executive summary)
2. Apply Diátaxis quadrant classification: Tutorial / How-to / Reference / Explanation
3. Fill the appropriate template from `core/templates/`
4. Generate tiered output: full technical doc + executive summary variant
5. Validate OpenAPI 3.1 / AsyncAPI 3.0 specs if detected

**Frameworks applied:**
- arc42 (12 sections, use only what adds value)
- MADR 4.0 for ADRs
- Diátaxis for doc type discipline
- OpenAPI 3.1, AsyncAPI 3.0 for API documentation validation
- TOGAF 10 artifact stubs for enterprise architecture outputs

**Security defaults:**
- arc42 section 8 (Crosscutting Concepts) must include a security subsection
- arc42 section 11 (Risks) must reference security risks
- API specs validated for: auth scheme present, sensitive fields masked, rate limiting documented

---

### 4.3 Validation Agent (`/architect validate`)

**Purpose:** Perform structured security and technical validation against industry frameworks. Produce actionable findings with remediation paths.

**Auto-trigger signals:**
- Files saved in `infra/`, `security/`, `*.tf`, `*.yaml` in `k8s/`
- Keywords: "threat", "security", "compliance", "validate", "review", "audit"
- PR checkpoint context

**Workflow:**
1. Scan architecture artifacts, IaC files, API contracts
2. Run security checklists in sequence:
   - **App layer:** OWASP ASVS 4.0 (three assurance levels)
   - **Enterprise posture:** NIST CSF 2.0 (Govern, Identify, Protect, Detect, Respond, Recover)
   - **Infrastructure:** CIS Benchmarks (cloud + OS)
   - **Compliance:** Auto-detect applicable regulations from context signals:
     - "payments", "cardholder" → PCI-DSS 4.0.1
     - "health", "PHI", "patient" → HIPAA Security Rule
     - "ISO", "27001", "certification" → ISO 27001:2022
     - "SOC", "audit", "Type II" → SOC 2 Trust Services Criteria
3. Produce Validation Report and Executive Summary (see Section 6)

**Severity scale:** CVSS 4.0 language — Critical / High / Medium / Low / Informational

**Finding format:**
```
| ID | Finding | Severity | Framework Ref | Remediation |
```

Every finding maps to ≥1 framework control. No finding is closed without a remediation path.

**Well-Architected Review:** Scored checklist against all six pillars of AWS/Azure/GCP frameworks with pass/fail/partial status per item.

---

## 5. Security-First Defaults

Security is embedded into every agent's default output — it cannot be turned off.

### Design Agent
- Every C4 component gets a STRIDE threat annotation in the diagram notes
- Every ADR includes a required "Security Implications" section
- Zero Trust assumptions are flagged: no implicit trust between any two components
- Well-Architected Security Pillar checklist appended to every design brief

### Docs Agent
- arc42 sections 8 and 11 require security content — agent will prompt if absent
- API specs are validated for auth presence, data masking, rate limiting documentation

### Validation Agent
- Severity follows CVSS 4.0 scoring language
- Every finding references at least one framework control
- Compliance gap detection is automatic based on context signals
- Remediation path is required for every finding before report is complete

### Cross-cutting
- No agent produces an output that silently omits security considerations
- Threat model (STRIDE) is the default starting point for any new component or integration
- NIST SP 800-207 Zero Trust principles are the default network trust assumption

---

## 6. Output Artifacts

| Artifact | Format | Audience | Producing Agent |
|---|---|---|---|
| C4 Context Diagram (Level 1) | Mermaid in Markdown | All | Design |
| C4 Container Diagram (Level 2) | Mermaid in Markdown | Engineers | Design |
| C4 Component Diagram (Level 3) | Mermaid in Markdown | Engineers | Design |
| Architecture Decision Record | MADR 4.0 Markdown | Engineers + Architect | Design, Docs |
| arc42 Architecture Document | Markdown (12 sections) | Engineers + Architect | Docs |
| TOGAF Artifact Stubs | Markdown | Enterprise Architects | Docs |
| DDD Bounded Context Map | Mermaid + Markdown | Engineers | Design |
| Ubiquitous Language Glossary | Markdown table | Engineers + PMs | Design, Docs |
| STRIDE Threat Model | Markdown table | Security + Engineers | Design |
| Well-Architected Review | Scored checklist Markdown | Architect + Leadership | Validation |
| Security Validation Report | Markdown findings table | Security + Architect | Validation |
| Compliance Gap Report | Markdown table | Leadership + Legal | Validation |
| Executive Summary | Short Markdown | Leadership | Design, Validation |
| OpenAPI/AsyncAPI Lint Results | Inline Markdown annotations | Engineers | Docs |

All artifacts committed under `docs/architecture/` by default (configurable).

---

## 7. Platform Adapters

### 7.1 Claude Code

**Skills (one per agent):**
```
agents/design-agent/SKILL.md     → namespace: architect:design
agents/docs-agent/SKILL.md       → namespace: architect:docs
agents/validation-agent/SKILL.md → namespace: architect:validate
```

Each SKILL.md frontmatter:
```yaml
name: architect:<agent>
description: <trigger description for auto-invocation>
context: fork          # subagent execution
allowed-tools: [Read, Write, Glob, Grep, Bash]
paths:
  - core/frameworks/
  - core/security/
  - core/templates/
```

**Hooks:**
- `post-edit.sh`: reads saved file path, matches against signal patterns, prints suggestion to use relevant agent. Non-destructive — never auto-runs agent output.

**Slash commands:**
- `/architect design` — invoke Design Agent
- `/architect docs` — invoke Docs Agent
- `/architect validate` — invoke Validation Agent
- `/architect help` — print available commands and auto-detection rules

### 7.2 Cursor

Three `.mdc` rule files in `platform/cursor/rules/`:

| File | globs | description (agent-decided trigger) |
|---|---|---|
| `architect-design.mdc` | `**/architecture/**`, `**/design/**` | "Architect system design, C4 diagrams, ADRs" |
| `architect-docs.mdc` | `**/docs/**`, `**/adr/**`, `**/*.adoc` | "Architecture documentation, arc42, RFCs" |
| `architect-validation.mdc` | `**/infra/**`, `**/*.tf`, `**/k8s/**` | "Security validation, compliance review" |

`alwaysApply: false` for all — triggered by glob match or agent decision, not injected into every session.

### 7.3 Sync Strategy

`build.sh` generates Cursor `.mdc` files from Claude Code SKILL.md sources:
1. Reads `agents/*/SKILL.md`
2. Strips Claude Code-specific frontmatter fields
3. Writes Cursor-compatible `.mdc` files with appropriate frontmatter
4. One command keeps both platforms in sync

---

## 8. Agent Coordination & Auto-Detection

| Signal | Detection Method | Agent Suggested |
|---|---|---|
| File saved in `architecture/`, `design/` | Hook / Glob | Design |
| File saved in `docs/`, `adr/` | Hook / Glob | Docs |
| File saved in `infra/`, `*.tf`, `k8s/*.yaml` | Hook / Glob | Validation |
| Prompt keyword: "threat", "security", "compliance" | Description match | Validation |
| Prompt keyword: "ADR", "decision", "diagram", "C4" | Description match | Design |
| Prompt keyword: "document", "spec", "RFC", "runbook" | Description match | Docs |
| `/architect help` | Manual slash command | Help meta-output |

**Non-destructive rule:** Auto-detection only suggests — the user confirms before any output is generated. No agent runs without explicit user confirmation.

---

## 9. Industry Standards Reference

### Architecture Frameworks
| Framework | Version | Key Artifacts |
|---|---|---|
| C4 Model | Living (c4model.com) | Context, Container, Component diagrams; Mermaid/Structurizr |
| MADR | 4.0.0 (2024-09-17) | ADR Markdown files |
| arc42 | Current (arc42.org) | 12-section architecture document |
| TOGAF | 10 (2022) | ADD, Architecture Repository, Contracts, Roadmap |
| DDD | Evans (2003) + community | Bounded context map, ubiquitous language, event storming |
| AWS WAF | Current (2025) | 6-pillar review: OpEx, Security, Reliability, Perf, Cost, Sustainability |
| Azure WAF | Current (2025) | 5-pillar review |
| GCP Architecture Framework | Current (2025) | 6-pillar review |

### Security Frameworks
| Framework | Version | Scope |
|---|---|---|
| OWASP Top 10 | 2021 (current stable) | Application security top risks |
| OWASP ASVS | 4.0 (5.0 in dev) | Application verification, 3 assurance levels |
| STRIDE | Microsoft (current) | Threat modeling: Spoofing, Tampering, Repudiation, Info Disclosure, DoS, EoP |
| NIST CSF | 2.0 (Feb 2024) | 6 functions: Govern, Identify, Protect, Detect, Respond, Recover |
| NIST SP 800-53 | Rev 5 | Security and privacy controls |
| NIST SP 800-207 | 1.0 | Zero Trust Architecture |
| CIS Benchmarks | Current | Infrastructure hardening |
| ISO 27001 | 2022 | 93 controls, 4 themes |
| SOC 2 | Current | Trust Services Criteria |
| PCI-DSS | 4.0.1 (mandatory Mar 2025) | 12 requirements, payment security |
| HIPAA Security Rule | Current | PHI protection |

### Documentation Standards
| Standard | Version | Use |
|---|---|---|
| Diátaxis | Current (diataxis.fr) | Doc type discipline: Tutorial/How-to/Reference/Explanation |
| OpenAPI | 3.1 | REST API specification |
| AsyncAPI | 3.0 | Event-driven API specification |
| RFC format | IETF | Proposal and decision documents |

---

## 10. Success Criteria

1. `/architect design` produces a C4 diagram, at least one ADR, and a STRIDE threat model for any described system — with no additional prompting
2. `/architect docs` correctly classifies a document using Diátaxis and fills the appropriate template
3. `/architect validate` produces a findings report with severity, framework reference, and remediation for every issue
4. Every output includes a security section — no exceptions
5. The same slash command works in both Claude Code and Cursor without modification
6. `build.sh` syncs Claude Code skills to Cursor `.mdc` files without manual editing
7. A new engineer can install the plugin and produce a valid ADR within 5 minutes

---

## 11. Open Questions / Future Phases

- **Phase 2:** CI/CD integration — run validation agent on PR open via GitHub Actions
- **Phase 2:** Structurizr DSL export for C4 diagrams (alternative to Mermaid)
- **Phase 2:** NIST NVD API integration for real-time CVE lookup in validation reports
- **Phase 3:** VS Code extension adapter
- **Phase 3:** Plugin marketplace distribution (Claude Code plugin registry)
- **Resolved:** Default output directory is `docs/architecture/`, overridable via `outputDir` field in `plugin.json`
