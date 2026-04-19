# Arkeytech — Architecture Assistant

This project uses the Arkeytech architecture plugin. Three specialized agents and skills are available:

## Available Agents

- **@architect-design** — System design: C4 diagrams, ADRs, STRIDE threat models, DDD bounded contexts
- **@architect-docs** — Documentation: arc42, ADRs, RFCs, runbooks, API specs (OpenAPI/AsyncAPI)
- **@architect-validation** — Security validation: OWASP, NIST CSF, CIS, compliance gap analysis

## Available Skills

- `/architect-design` — On-demand design workflow
- `/architect-docs` — On-demand documentation workflow
- `/architect-validation` — On-demand security validation workflow

## Conventions

- All architecture outputs go to `docs/architecture/`
- Security annotations are mandatory in every output — STRIDE, Zero Trust, data classification
- ADRs use MADR 4.0 format with required Security Implications section
- Reference material is in `.arkeytech/` (agents, frameworks, security, templates)
