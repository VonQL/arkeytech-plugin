#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');
const os = require('os');

// ──────────────────────────────────────────────
// Plugin root = where this script lives (inside the npm package)
// ──────────────────────────────────────────────
const PLUGIN_ROOT = __dirname;
const PLUGIN_JSON = path.join(PLUGIN_ROOT, 'plugin.json');
const AGENTS_DIR = path.join(PLUGIN_ROOT, 'agents');
const CORE_DIR = path.join(PLUGIN_ROOT, 'core');
const CURSOR_RULES_DIR = path.join(PLUGIN_ROOT, 'platform', 'cursor', 'rules');
const HOOK_FILE = path.join(PLUGIN_ROOT, 'platform', 'claude-code', 'hooks', 'post-edit.sh');

// ──────────────────────────────────────────────
// Colors
// ──────────────────────────────────────────────
const c = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  bold: '\x1b[1m',
};

let errors = 0;

function pass(msg) { console.log(`${c.green}  ✓${c.reset} ${msg}`); }
function fail(msg) { console.log(`${c.red}  ✗${c.reset} ${msg}`); errors++; }
function warn(msg) { console.log(`${c.yellow}  ⚠${c.reset} ${msg}`); }
function info(msg) { console.log(`${c.blue}  →${c.reset} ${msg}`); }
function header(msg) { console.log(`\n${c.bold}${msg}${c.reset}`); }
function divider() { console.log('━'.repeat(42)); }

// ──────────────────────────────────────────────
// Helpers
// ──────────────────────────────────────────────
function fileExists(p) {
  try { fs.accessSync(p, fs.constants.F_OK); return true; } catch { return false; }
}

function isExecutable(p) {
  try { fs.accessSync(p, fs.constants.X_OK); return true; } catch { return false; }
}

function isSymlink(p) {
  try { return fs.lstatSync(p).isSymbolicLink(); } catch { return false; }
}

function isDirectory(p) {
  try { return fs.statSync(p).isDirectory(); } catch { return false; }
}

function fileContains(p, str) {
  try { return fs.readFileSync(p, 'utf8').includes(str); } catch { return false; }
}

function copyDirRecursive(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      copyDirRecursive(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

// ──────────────────────────────────────────────
// validate — check plugin structure integrity
// ──────────────────────────────────────────────
function validate() {
  errors = 0;
  header('Validating arkeytech structure...');
  divider();

  // plugin.json
  if (fileExists(PLUGIN_JSON)) {
    try {
      JSON.parse(fs.readFileSync(PLUGIN_JSON, 'utf8'));
      pass('plugin.json — valid JSON');
    } catch {
      fail('plugin.json — invalid JSON');
    }
  } else {
    fail('plugin.json — missing');
  }

  // Agent SKILL.md files
  header('Agents:');
  for (const agent of ['design-agent', 'docs-agent', 'validation-agent']) {
    const skill = path.join(AGENTS_DIR, agent, 'SKILL.md');
    if (fileExists(skill)) {
      if (fileContains(skill, 'name:') && fileContains(skill, 'description:')) {
        pass(`${agent}/SKILL.md — present, frontmatter OK`);
      } else {
        fail(`${agent}/SKILL.md — missing required frontmatter (name, description)`);
      }
    } else {
      fail(`${agent}/SKILL.md — missing`);
    }
  }

  // Core frameworks
  header('Core frameworks:');
  for (const f of ['c4.md', 'adr.md', 'arc42.md', 'togaf.md', 'ddd.md', 'well-architected.md']) {
    const p = path.join(CORE_DIR, 'frameworks', f);
    fileExists(p) ? pass(`core/frameworks/${f}`) : fail(`core/frameworks/${f} — missing`);
  }

  // Core security
  header('Core security:');
  for (const f of ['threat-modeling.md', 'owasp.md', 'nist.md', 'compliance.md', 'cloud-security.md']) {
    const p = path.join(CORE_DIR, 'security', f);
    fileExists(p) ? pass(`core/security/${f}`) : fail(`core/security/${f} — missing`);
  }

  // Core templates
  header('Core templates:');
  for (const f of ['design-brief.md', 'security-review.md', 'validation-report.md', 'executive-summary.md']) {
    const p = path.join(CORE_DIR, 'templates', f);
    fileExists(p) ? pass(`core/templates/${f}`) : fail(`core/templates/${f} — missing`);
  }

  // Platform: Claude Code hook
  header('Platform — Claude Code:');
  if (fileExists(HOOK_FILE)) {
    if (isExecutable(HOOK_FILE)) {
      pass('platform/claude-code/hooks/post-edit.sh — present and executable');
    } else {
      warn('platform/claude-code/hooks/post-edit.sh — present but not executable');
    }
  } else {
    fail('platform/claude-code/hooks/post-edit.sh — missing');
  }

  // Platform: Cursor rules
  header('Platform — Cursor:');
  for (const rule of ['architect-design.mdc', 'architect-docs.mdc', 'architect-validation.mdc']) {
    const p = path.join(CURSOR_RULES_DIR, rule);
    if (fileExists(p)) {
      if (fileContains(p, 'description:')) {
        pass(`platform/cursor/rules/${rule} — present, frontmatter OK`);
      } else {
        fail(`platform/cursor/rules/${rule} — missing description in frontmatter`);
      }
    } else {
      fail(`platform/cursor/rules/${rule} — missing`);
    }
  }

  console.log('');
  divider();
  if (errors === 0) {
    console.log(`${c.green}✓ Validation passed — 0 errors${c.reset}`);
  } else {
    console.log(`${c.red}✗ Validation failed — ${errors} error(s)${c.reset}`);
    process.exit(1);
  }
}

// ──────────────────────────────────────────────
// install --claude  (default)
// Symlinks plugin into ~/.claude/plugins/arkeytech
// ──────────────────────────────────────────────
function installClaude() {
  header('Installing for Claude Code...');
  divider();

  const claudePluginsDir = path.join(os.homedir(), '.claude', 'plugins');
  const target = path.join(claudePluginsDir, 'arkeytech');

  fs.mkdirSync(claudePluginsDir, { recursive: true });

  if (isSymlink(target)) {
    info(`Symlink already exists: ${target} → ${fs.readlinkSync(target)}`);
  } else if (isDirectory(target)) {
    fail(`${target} exists as a directory — remove it first to reinstall`);
    process.exit(1);
  } else if (fileExists(target)) {
    fail(`${target} already exists as a file — remove it first`);
    process.exit(1);
  } else {
    fs.symlinkSync(PLUGIN_ROOT, target);
    pass(`Installed: ${target} → ${PLUGIN_ROOT}`);
  }

  console.log('');
  pass('Claude Code install complete.');
  info('Add the following hook to your project\'s .claude/settings.json:');
  console.log('');
  console.log(JSON.stringify({
    hooks: {
      post_tool_use: [
        {
          matcher: 'Write|Edit',
          hooks: [`bash ${path.join(target, 'platform', 'claude-code', 'hooks', 'post-edit.sh')}`]
        }
      ]
    }
  }, null, 2));
  console.log('');
  info('Restart Claude Code to pick up the new plugin.');
}

// ──────────────────────────────────────────────
// install --cursor [project-dir]
// Copies .mdc rule files into <project>/.cursor/rules/
// ──────────────────────────────────────────────
function installCursor(projectDir) {
  header('Installing for Cursor...');
  divider();

  const target = path.join(projectDir, '.cursor', 'rules');
  fs.mkdirSync(target, { recursive: true });

  const rules = ['architect-design.mdc', 'architect-docs.mdc', 'architect-validation.mdc'];
  for (const rule of rules) {
    const src = path.join(CURSOR_RULES_DIR, rule);
    const dest = path.join(target, rule);
    if (!fileExists(src)) {
      fail(`Source rule not found: ${src}`);
      continue;
    }
    fs.copyFileSync(src, dest);
    pass(`Copied ${rule} → ${dest}`);
  }

  console.log('');
  if (errors === 0) {
    pass('Cursor install complete.');
    info('Agents activate automatically based on file patterns and trigger keywords.');
  } else {
    console.log(`${c.red}✗ Install completed with ${errors} error(s)${c.reset}`);
    process.exit(1);
  }
}

// ──────────────────────────────────────────────
// help
// ──────────────────────────────────────────────
function printHelp() {
  console.log(`
${c.bold}arkeytech${c.reset} — AI architect assistant for Claude Code and Cursor

${c.bold}Usage:${c.reset}
  npx arkeytech install              Install for Claude Code (symlink to ~/.claude/plugins)
  npx arkeytech install --cursor     Install Cursor rules into current directory
  npx arkeytech install --cursor /path/to/project
  npx arkeytech validate             Validate plugin structure
  npx arkeytech help                 Show this help

${c.bold}Claude Code commands (after install):${c.reset}
  /architect design     C4 diagrams, ADRs, arc42, STRIDE, DDD, Well-Architected
  /architect docs       arc42 docs, ADRs, RFCs, runbooks, OpenAPI/AsyncAPI
  /architect validate   Security report (OWASP, NIST, CIS), compliance gap analysis

${c.bold}Cursor:${c.reset}
  Agents activate automatically based on file patterns and trigger keywords.
`);
}

// ──────────────────────────────────────────────
// Main
// ──────────────────────────────────────────────
const [,, command, ...args] = process.argv;

switch (command) {
  case 'install': {
    const cursorFlag = args.includes('--cursor');
    const cursorIndex = args.indexOf('--cursor');
    if (cursorFlag) {
      // optional path after --cursor; default to cwd
      const projectDir = (cursorIndex !== -1 && args[cursorIndex + 1] && !args[cursorIndex + 1].startsWith('-'))
        ? path.resolve(args[cursorIndex + 1])
        : process.cwd();
      installCursor(projectDir);
    } else {
      installClaude();
    }
    break;
  }
  case 'validate':
    validate();
    break;
  case 'help':
  case '--help':
  case '-h':
    printHelp();
    break;
  default:
    printHelp();
    break;
}
