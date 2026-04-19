#!/usr/bin/env bash
# architect-plugin: build.sh
# Generates Cursor .mdc rule files from Claude Code SKILL.md agent sources.
# Keeps both platforms in sync from a single source of truth.
#
# Usage:
#   ./build.sh          — generate/update all Cursor .mdc files
#   ./build.sh validate — validate plugin structure only (no writes)

set -euo pipefail

PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_DIR="$PLUGIN_ROOT/agents"
CURSOR_RULES_DIR="$PLUGIN_ROOT/platform/cursor/rules"
CORE_DIR="$PLUGIN_ROOT/core"

# ──────────────────────────────────────────────
# Colors
# ──────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

pass() { echo -e "${GREEN}  ✓${NC} $1"; }
fail() { echo -e "${RED}  ✗${NC} $1"; ERRORS=$((ERRORS + 1)); }
warn() { echo -e "${YELLOW}  ⚠${NC} $1"; }
info() { echo -e "${BLUE}  →${NC} $1"; }

ERRORS=0

# ──────────────────────────────────────────────
# Validate: plugin structure
# ──────────────────────────────────────────────
validate() {
  echo ""
  echo "Validating architect-plugin structure..."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  # plugin.json
  if [[ -f "$PLUGIN_ROOT/plugin.json" ]]; then
    if python3 -m json.tool "$PLUGIN_ROOT/plugin.json" > /dev/null 2>&1; then
      pass "plugin.json — valid JSON"
    else
      fail "plugin.json — invalid JSON"
    fi
  else
    fail "plugin.json — missing"
  fi

  # Agent SKILL.md files
  echo ""
  echo "Agents:"
  for agent in design-agent docs-agent validation-agent; do
    SKILL="$AGENTS_DIR/$agent/SKILL.md"
    if [[ -f "$SKILL" ]]; then
      # Check required frontmatter fields
      if grep -q "^name:" "$SKILL" && grep -q "^description:" "$SKILL"; then
        pass "$agent/SKILL.md — present, frontmatter OK"
      else
        fail "$agent/SKILL.md — missing required frontmatter (name, description)"
      fi
    else
      fail "$agent/SKILL.md — missing"
    fi
  done

  # Core frameworks
  echo ""
  echo "Core frameworks:"
  for framework in c4.md adr.md arc42.md togaf.md ddd.md well-architected.md; do
    if [[ -f "$CORE_DIR/frameworks/$framework" ]]; then
      pass "core/frameworks/$framework"
    else
      fail "core/frameworks/$framework — missing"
    fi
  done

  # Core security
  echo ""
  echo "Core security:"
  for sec in threat-modeling.md owasp.md nist.md compliance.md cloud-security.md; do
    if [[ -f "$CORE_DIR/security/$sec" ]]; then
      pass "core/security/$sec"
    else
      fail "core/security/$sec — missing"
    fi
  done

  # Core templates
  echo ""
  echo "Core templates:"
  for tmpl in design-brief.md security-review.md validation-report.md executive-summary.md; do
    if [[ -f "$CORE_DIR/templates/$tmpl" ]]; then
      pass "core/templates/$tmpl"
    else
      fail "core/templates/$tmpl — missing"
    fi
  done

  # Platform: Claude Code hook
  echo ""
  echo "Platform — Claude Code:"
  HOOK="$PLUGIN_ROOT/platform/claude-code/hooks/post-edit.sh"
  if [[ -f "$HOOK" ]]; then
    if [[ -x "$HOOK" ]]; then
      pass "platform/claude-code/hooks/post-edit.sh — present and executable"
    else
      warn "platform/claude-code/hooks/post-edit.sh — present but not executable (run: chmod +x)"
    fi
  else
    fail "platform/claude-code/hooks/post-edit.sh — missing"
  fi

  # Platform: Cursor rules
  echo ""
  echo "Platform — Cursor:"
  for rule in architect-design.mdc architect-docs.mdc architect-validation.mdc; do
    if [[ -f "$CURSOR_RULES_DIR/$rule" ]]; then
      if grep -q "^description:" "$CURSOR_RULES_DIR/$rule"; then
        pass "platform/cursor/rules/$rule — present, frontmatter OK"
      else
        fail "platform/cursor/rules/$rule — missing description in frontmatter"
      fi
    else
      fail "platform/cursor/rules/$rule — missing (run ./build.sh to generate)"
    fi
  done

  # Platform: Copilot agents
  echo ""
  echo "Platform — VS Code Copilot:"
  COPILOT_DIR="$PLUGIN_ROOT/platform/copilot"
  for agent_file in architect-design.agent.md architect-docs.agent.md architect-validation.agent.md; do
    if [[ -f "$COPILOT_DIR/agents/$agent_file" ]]; then
      if grep -q "^description:" "$COPILOT_DIR/agents/$agent_file"; then
        pass "platform/copilot/agents/$agent_file — present, frontmatter OK"
      else
        fail "platform/copilot/agents/$agent_file — missing description in frontmatter"
      fi
    else
      fail "platform/copilot/agents/$agent_file — missing"
    fi
  done
  for skill_name in architect-design architect-docs architect-validation; do
    SKILL_FILE="$COPILOT_DIR/skills/$skill_name/SKILL.md"
    if [[ -f "$SKILL_FILE" ]]; then
      if grep -q "^name:" "$SKILL_FILE" && grep -q "^description:" "$SKILL_FILE"; then
        pass "platform/copilot/skills/$skill_name/SKILL.md — present, frontmatter OK"
      else
        fail "platform/copilot/skills/$skill_name/SKILL.md — missing required frontmatter"
      fi
    else
      fail "platform/copilot/skills/$skill_name/SKILL.md — missing"
    fi
  done
  if [[ -f "$COPILOT_DIR/copilot-instructions.md" ]]; then
    pass "platform/copilot/copilot-instructions.md — present"
  else
    fail "platform/copilot/copilot-instructions.md — missing"
  fi

  # build.sh executable
  echo ""
  if [[ -x "$PLUGIN_ROOT/build.sh" ]]; then
    pass "build.sh — executable"
  else
    warn "build.sh — not executable (run: chmod +x build.sh)"
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  if [[ $ERRORS -eq 0 ]]; then
    echo -e "${GREEN}✓ Validation passed — $ERRORS errors${NC}"
  else
    echo -e "${RED}✗ Validation failed — $ERRORS error(s)${NC}"
    exit 1
  fi
}

# ──────────────────────────────────────────────
# Build: generate Cursor .mdc files
# Cursor .mdc files are maintained manually (not generated from SKILL.md)
# because the two formats serve different invocation models.
# This function validates they are in sync and up to date.
# ──────────────────────────────────────────────
build() {
  echo ""
  echo "Building architect-plugin..."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  # Ensure Cursor rules directory exists
  mkdir -p "$CURSOR_RULES_DIR"

  # Check each agent has a corresponding Cursor rule
  declare -A AGENT_TO_RULE=(
    ["design-agent"]="architect-design.mdc"
    ["docs-agent"]="architect-docs.mdc"
    ["validation-agent"]="architect-validation.mdc"
  )

  for agent in "${!AGENT_TO_RULE[@]}"; do
    rule="${AGENT_TO_RULE[$agent]}"
    SKILL_FILE="$AGENTS_DIR/$agent/SKILL.md"
    RULE_FILE="$CURSOR_RULES_DIR/$rule"

    if [[ ! -f "$SKILL_FILE" ]]; then
      fail "Cannot sync $rule — $SKILL_FILE not found"
      continue
    fi

    if [[ -f "$RULE_FILE" ]]; then
      # Check if SKILL.md is newer than the .mdc file
      if [[ "$SKILL_FILE" -nt "$RULE_FILE" ]]; then
        warn "$rule may be out of sync with $agent/SKILL.md — review and update manually"
      else
        pass "$rule — in sync with $agent/SKILL.md"
      fi
    else
      fail "$rule — missing; create platform/cursor/rules/$rule"
    fi
  done

  # Ensure hook is executable
  HOOK="$PLUGIN_ROOT/platform/claude-code/hooks/post-edit.sh"
  if [[ -f "$HOOK" && ! -x "$HOOK" ]]; then
    chmod +x "$HOOK"
    pass "post-edit.sh — made executable"
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  if [[ $ERRORS -eq 0 ]]; then
    echo -e "${GREEN}✓ Build complete${NC}"
  else
    echo -e "${RED}✗ Build completed with $ERRORS error(s) — see above${NC}"
    exit 1
  fi

  echo ""
  echo "Next steps:"
  info "Claude Code: copy or symlink this plugin to ~/.claude/plugins/architect-plugin/"
  info "Cursor: copy platform/cursor/rules/*.mdc to your project's .cursor/rules/"
  info "Copilot: copy platform/copilot/ agents and skills to your project's .github/"
  info "Hook: configure Claude Code settings.json to run platform/claude-code/hooks/post-edit.sh"
}

# ──────────────────────────────────────────────
# Install (local dev): symlink to Claude Code plugins dir
# ──────────────────────────────────────────────
install_local() {
  CLAUDE_PLUGINS_DIR="$HOME/.claude/plugins"
  TARGET="$CLAUDE_PLUGINS_DIR/architect-plugin"

  mkdir -p "$CLAUDE_PLUGINS_DIR"

  if [[ -L "$TARGET" ]]; then
    info "Symlink already exists: $TARGET → $(readlink "$TARGET")"
  elif [[ -d "$TARGET" ]]; then
    fail "$TARGET exists as a directory — remove it first to install symlink"
    exit 1
  else
    ln -s "$PLUGIN_ROOT" "$TARGET"
    pass "Installed: $TARGET → $PLUGIN_ROOT"
  fi

  echo ""
  pass "Local install complete. Add architect:* skills to Claude Code."
  info "Restart Claude Code to pick up the new plugin."
}

# ──────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────
case "${1:-build}" in
  validate)
    validate
    ;;
  install)
    build
    validate
    install_local
    ;;
  build|*)
    build
    validate
    ;;
esac
