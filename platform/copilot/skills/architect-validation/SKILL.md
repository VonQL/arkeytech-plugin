---
name: architect-validation
description: "Security and compliance validation: STRIDE threat models, OWASP ASVS checks, NIST CSF reviews, IaC security scanning, Well-Architected reviews, compliance gap analysis. Use when asked to validate, audit, review security, or assess compliance."
---

# Architect Validation Skill

## When to Use
- Security reviews and compliance assessments
- STRIDE threat modeling
- OWASP ASVS L2 application security checks
- NIST CSF 2.0 posture reviews
- IaC security scanning (Terraform, Kubernetes, Docker)
- Well-Architected reviews
- Pre-launch security sign-off

## Procedure

1. Read the full agent instructions: `.arkeytech/agents/validation-agent/SKILL.md`
2. Scan inputs for compliance signals (PCI-DSS, HIPAA, ISO 27001, SOC 2)
3. State detected applicable frameworks
4. Consult checklists in `.arkeytech/core/security/`
5. Produce findings with: severity, framework ref, remediation, owner
6. Write validation report to `docs/architecture/validation-report.md`
7. Write executive summary to `docs/architecture/executive-summary.md`

## References

- [Agent instructions](./../../agents/validation-agent/SKILL.md)
- [STRIDE reference](./../../core/security/threat-modeling.md)
- [OWASP checklist](./../../core/security/owasp.md)
- [NIST CSF reference](./../../core/security/nist.md)
- [Compliance frameworks](./../../core/security/compliance.md)
- [Cloud security / CIS](./../../core/security/cloud-security.md)
- [Validation report template](./../../core/templates/validation-report.md)
- [Security review template](./../../core/templates/security-review.md)
