---
name: architect-design
description: "Design systems with C4 diagrams, ADRs, STRIDE threat models, DDD bounded contexts, and arc42 stubs. Use when asked to design, architect, diagram, or create decision records."
---

# Architect Design Skill

## When to Use
- Designing a new system or service
- Creating C4 diagrams (Context, Container, Component)
- Writing Architecture Decision Records (ADRs)
- Mapping DDD bounded contexts
- Performing STRIDE threat modeling

## Procedure

1. Read the full agent instructions: `.arkeytech/agents/design-agent/SKILL.md`
2. Gather context about the system being designed
3. Consult framework references in `.arkeytech/core/frameworks/` as needed
4. Produce all artifacts in `docs/architecture/`:
   - C4 Level 1 + Level 2 diagrams (Mermaid)
   - STRIDE threat table per container
   - ADRs in MADR 4.0 format
   - arc42 stub (sections 1, 2, 3, 4, 8.1, 11)
   - Executive summary
5. Verify all security annotations are present

## References

- [Agent instructions](./../../agents/design-agent/SKILL.md)
- [C4 conventions](./../../core/frameworks/c4.md)
- [ADR format](./../../core/frameworks/adr.md)
- [arc42 template](./../../core/frameworks/arc42.md)
- [DDD guidance](./../../core/frameworks/ddd.md)
- [STRIDE reference](./../../core/security/threat-modeling.md)
- [Design brief template](./../../core/templates/design-brief.md)
