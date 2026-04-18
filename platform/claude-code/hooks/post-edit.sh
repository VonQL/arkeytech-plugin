#!/usr/bin/env bash
# architect-plugin: post-edit hook
# Detects saved file type and suggests the relevant architect agent.
# Non-destructive: only prints a suggestion. Never auto-runs an agent.
#
# Install: add to .claude/settings.json hooks.post_tool_use
# Expected env: CLAUDE_TOOL_NAME, CLAUDE_TOOL_INPUT_PATH (set by Claude Code hook system)

set -euo pipefail

# Only act on Write/Edit tool calls
TOOL="${CLAUDE_TOOL_NAME:-}"
if [[ "$TOOL" != "Write" && "$TOOL" != "Edit" ]]; then
  exit 0
fi

# Get the file path from the hook context
FILE_PATH="${CLAUDE_TOOL_INPUT_PATH:-}"
if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

# Normalize path for pattern matching
FILE_LOWER="${FILE_PATH,,}"

# ──────────────────────────────────────────────
# Signal matching: Design Agent
# ──────────────────────────────────────────────
if echo "$FILE_PATH" | grep -qE '/(architecture|design|diagrams)/' || \
   echo "$FILE_PATH" | grep -qE '\.(puml|plantuml)$' || \
   echo "$FILE_PATH" | grep -qE '/(c4|adr|decisions)/'; then
  echo ""
  echo "🏛️  [architect-plugin] Architecture file detected: $(basename "$FILE_PATH")"
  echo "   → Suggestion: /architect design — to generate C4 diagrams, ADRs, or STRIDE threat model"
  exit 0
fi

# ──────────────────────────────────────────────
# Signal matching: Docs Agent
# ──────────────────────────────────────────────
if echo "$FILE_PATH" | grep -qE '/(docs|documentation|runbooks|rfcs)/' || \
   echo "$FILE_PATH" | grep -qE '\.(adoc|rst)$' || \
   echo "$FILE_PATH" | grep -qE '(openapi|swagger|asyncapi)\.(yaml|yml|json)$'; then
  echo ""
  echo "📄  [architect-plugin] Documentation file detected: $(basename "$FILE_PATH")"
  echo "   → Suggestion: /architect docs — to structure, complete, or validate this document"
  exit 0
fi

# ──────────────────────────────────────────────
# Signal matching: Validation Agent
# ──────────────────────────────────────────────
if echo "$FILE_PATH" | grep -qE '/(infra|infrastructure|terraform|security|iac|k8s|kubernetes|helm)/' || \
   echo "$FILE_PATH" | grep -qE '\.(tf|tfvars)$' || \
   echo "$FILE_PATH" | grep -qE '/(k8s|kubernetes|helm)/.*\.(yaml|yml)$' || \
   echo "$FILE_PATH" | grep -qE '(Dockerfile|docker-compose)\.(ya?ml)?$'; then
  echo ""
  echo "🔒  [architect-plugin] Infrastructure/security file detected: $(basename "$FILE_PATH")"
  echo "   → Suggestion: /architect validate — to run security and compliance checks"
  exit 0
fi

# No signal matched — silent exit
exit 0
