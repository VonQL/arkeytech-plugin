# Arkeytech

AI-powered architect assistant for Claude Code and Cursor. Guides agents through system design, documentation, and technical validation with security-first defaults.

## What It Does

| Command | What It Produces |
|---|---|
| `/architect design` | C4 diagrams (Mermaid), ADRs (MADR 4.0), arc42 stub, STRIDE threat model, DDD bounded context map, Well-Architected alignment |
| `/architect docs` | arc42 documents, ADRs, RFCs, runbooks, OpenAPI/AsyncAPI validation, executive summaries |
| `/architect validate` | Security validation report (OWASP ASVS, NIST CSF 2.0, CIS), compliance gap analysis (ISO 27001, SOC 2, PCI-DSS, HIPAA), Well-Architected review |
| `/architect help` | Command reference and auto-detection rules |

Security is embedded by default in every agent output. It cannot be turned off.

---

## Installation

### Claude Code (Marketplace) — Recommended

Register the plugin as a marketplace, then install:

```bash
/plugin marketplace add vlagare/arkeytech
/plugin install arkeytech@arkeytech
```

That's it. The agents are available immediately in any Claude Code session.

---

### Claude Code (npm / npx)

```bash
npx arkeytech install
```

This symlinks the plugin to `~/.claude/plugins/arkeytech/`. Then configure the post-edit hook in your project's `.claude/settings.json`:

```json
{
  "hooks": {
    "post_tool_use": [
      {
        "matcher": "Write|Edit",
        "hooks": ["bash ~/.claude/plugins/arkeytech/platform/claude-code/hooks/post-edit.sh"]
      }
    ]
  }
}
```

---

### Claude Code (Manual)

**Option A: Symlink (recommended for development)**
```bash
./build.sh install
```

**Option B: Copy**
```bash
cp -r . ~/.claude/plugins/arkeytech/
```

**Configure the post-edit hook** in your project's `.claude/settings.json`:
```json
{
  "hooks": {
    "post_tool_use": [
      {
        "matcher": "Write|Edit",
        "hooks": ["bash platform/claude-code/hooks/post-edit.sh"]
      }
    ]
  }
}
```

**Use slash commands:**
- `/architect design` — invoke the design agent
- `/architect docs` — invoke the docs agent
- `/architect validate` — invoke the validation agent

### Cursor

**Option A: npx**
```bash
npx arkeytech install --cursor
```

**Option B: Manual**
```bash
mkdir -p .cursor/rules
cp platform/cursor/rules/*.mdc .cursor/rules/
```

The agents activate automatically when you:
- Open files matching the glob patterns (architecture, docs, infra, k8s)
- Ask questions with trigger keywords (design, ADR, validate, security, compliance)

---

## Validate the Plugin

```bash
./build.sh validate
```

Expected output: all green checkmarks, 0 errors.

---

## Output Locations

All generated artifacts are written to `docs/architecture/` by default:

```
docs/architecture/
├── arc42.md                     ← arc42 architecture document
├── design-brief.md              ← design brief
├── executive-summary.md         ← leadership summary
├── validation-report.md         ← security validation report
├── decisions/
│   ├── 0001-[title].md          ← ADR 1 (MADR 4.0)
│   └── 0002-[title].md          ← ADR 2
├── diagrams/
│   ├── c4-context.md            ← C4 Level 1
│   ├── c4-container.md          ← C4 Level 2
│   └── c4-component-[name].md   ← C4 Level 3 (if needed)
└── ubiquitous-language/
    └── [context-name].md        ← DDD glossary per bounded context
```

Configure the output directory via `outputDir` in `plugin.json`.

---

## Auto-Detection

The plugin detects context automatically and suggests the right agent:

| File or Context | Agent Suggested |
|---|---|
| Files in `architecture/`, `design/`, `adr/` | Design Agent |
| Files in `docs/`, `runbooks/`, `rfcs/`, OpenAPI YAML | Docs Agent |
| Files in `infra/`, `*.tf`, `k8s/*.yaml`, `Dockerfile` | Validation Agent |
| Keywords: "ADR", "C4", "diagram", "design" | Design Agent |
| Keywords: "document", "spec", "RFC", "runbook" | Docs Agent |
| Keywords: "security", "threat", "compliance", "validate" | Validation Agent |

Auto-detection only suggests — you confirm before the agent runs.

---

## Security Standards Reference

| Domain | Frameworks Applied |
|---|---|
| Application Security | OWASP Top 10 (2021), OWASP ASVS 4.0 |
| Threat Modeling | STRIDE, PASTA |
| Enterprise Security | NIST CSF 2.0, NIST SP 800-53 Rev 5, NIST SP 800-207 (Zero Trust) |
| Infrastructure | CIS Benchmarks |
| Compliance | ISO 27001:2022, SOC 2, PCI-DSS 4.0.1, HIPAA Security Rule |
| Cloud | AWS/Azure/GCP Well-Architected Security Pillar |
| Severity | CVSS 4.0 language |

---

## Architecture Frameworks Reference

| Domain | Frameworks Applied |
|---|---|
| System Design | C4 Model (Levels 1–3, Mermaid) |
| Decisions | MADR 4.0 (Architecture Decision Records) |
| Documentation | arc42 (12 sections), Diátaxis |
| Enterprise | TOGAF 10 |
| Domain | Domain-Driven Design (DDD) — bounded contexts, event storming |
| Cloud Review | AWS/Azure/GCP Well-Architected Framework |
| API | OpenAPI 3.1, AsyncAPI 3.0 |

---

## Plugin Structure

```
architect-plugin/
├── plugin.json                       ← manifest
├── build.sh                          ← validate + sync
├── core/
│   ├── frameworks/                   ← C4, ADR, arc42, TOGAF, DDD, Well-Architected
│   ├── security/                     ← STRIDE, OWASP, NIST, compliance, cloud security
│   └── templates/                    ← output templates
├── agents/
│   ├── design-agent/SKILL.md         ← Claude Code design skill
│   ├── docs-agent/SKILL.md           ← Claude Code docs skill
│   └── validation-agent/SKILL.md     ← Claude Code validation skill
└── platform/
    ├── claude-code/hooks/post-edit.sh ← file-save auto-detection hook
    └── cursor/rules/                  ← Cursor .mdc rule files
        ├── architect-design.mdc
        ├── architect-docs.mdc
        └── architect-validation.mdc
```

---

## Contributing

1. Edit agent instructions in `agents/*/SKILL.md`
2. Update Cursor rules in `platform/cursor/rules/*.mdc` to match
3. Run `./build.sh validate` to verify plugin integrity
4. Commit both together — Cursor rules must stay in sync with SKILL.md files

**Core knowledge files** (`core/frameworks/`, `core/security/`) are the single source of truth. Both Claude Code skills and Cursor rules reference them. Never duplicate content into platform-specific files.
