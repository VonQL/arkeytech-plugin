---
name: architect-docs
description: "Create architecture documentation: ADRs, arc42 documents, RFCs, runbooks, API specs (OpenAPI/AsyncAPI), executive summaries. Use when asked to document, write ADR, create RFC, or produce technical docs."
---

# Architect Docs Skill

## When to Use
- Writing ADRs, RFCs, or technical proposals
- Creating arc42 architecture documents
- Producing runbooks or operational procedures
- Annotating OpenAPI 3.1 / AsyncAPI 3.0 specs
- Writing executive summaries

## Procedure

1. Read the full agent instructions: `.arkeytech/agents/docs-agent/SKILL.md`
2. Classify the document type using Diátaxis (Tutorial / How-to / Reference / Explanation)
3. Consult the appropriate template in `.arkeytech/core/templates/`
4. Follow the exact format for the detected document type
5. Ensure security sections are present and substantive
6. Write output to the correct location under `docs/`

## References

- [Agent instructions](./../../agents/docs-agent/SKILL.md)
- [ADR format](./../../core/frameworks/adr.md)
- [arc42 template](./../../core/frameworks/arc42.md)
- [OWASP reference](./../../core/security/owasp.md)
- [Compliance frameworks](./../../core/security/compliance.md)
- [Executive summary template](./../../core/templates/executive-summary.md)
