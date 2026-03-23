
# OpenClaw adaptation note

This file is adapted from Garry Tan's original gstack skill for use inside **OpenClaw**.

## Tool mapping
- `Bash` → use `exec`
- `Read` → use `read`
- `Write` → use `write`
- `Edit` → use `edit`
- `Grep` / `Glob` → use `exec` with `grep`, `find`, or `fd`-style shell commands
- `AskUserQuestion` → ask the user directly in chat, then wait for their reply
- `WebSearch` → prefer `web_search`; use `web_fetch` when fetching a specific page

## Path mapping
- Original Claude paths like `~/.claude//home/keep/.openclaw/workspace//home/keep/.openclaw/workspace/skills/gstack/...` are mapped to `/home/keep/.openclaw/workspace//home/keep/.openclaw/workspace/skills/gstack/...`
- The shared gstack bundle lives at `/home/keep/.openclaw/workspace//home/keep/.openclaw/workspace/skills/gstack/`

## OpenClaw execution rules
- Keep replies concise and progress-visible.
- When the workflow asks to pause for user choice, ask directly in chat instead of using a special question tool.
- When the workflow suggests browser automation, prefer OpenClaw's `browser` tool before any custom browse binary.
- If a step assumes a Claude/Codex-only feature, adapt it to the closest OpenClaw-native tool rather than failing blindly.

---

<!-- AUTO-GENERATED from SKILL.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->

# /freeze — Restrict Edits to a Directory

Lock file edits to a specific directory. Any edit or write operation targeting
a file outside the allowed path will be **blocked** (not just warned).

```bash
mkdir -p ~/.gstack/analytics
echo '{"skill":"freeze","ts":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'","repo":"'$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo "unknown")'"}'  >> ~/.gstack/analytics/skill-usage.jsonl 2>/dev/null || true
```

## Setup

Ask the user which directory to restrict edits to. Use ask the user directly in chat:

- Question: "Which directory should I restrict edits to? Files outside this path will be blocked from editing."
- Text input (not multiple choice) — the user types a path.

Once the user provides a directory path:

1. Resolve it to an absolute path:
```bash
FREEZE_DIR=$(cd "<user-provided-path>" 2>/dev/null && pwd)
echo "$FREEZE_DIR"
```

2. Ensure trailing slash and save to the freeze state file:
```bash
FREEZE_DIR="${FREEZE_DIR%/}/"
STATE_DIR="${CLAUDE_PLUGIN_DATA:-$HOME/.gstack}"
mkdir -p "$STATE_DIR"
echo "$FREEZE_DIR" > "$STATE_DIR/freeze-dir.txt"
echo "Freeze boundary set: $FREEZE_DIR"
```

Tell the user: "Edits are now restricted to `<path>/`. Any edit or write
outside this directory will be blocked. To change the boundary, run `/freeze`
again. To remove it, run `/unfreeze` or end the session."

## How it works

The hook reads `file_path` from the edit/write tool input JSON, then checks
whether the path starts with the freeze directory. If not, it returns
`permissionDecision: "deny"` to block the operation.

The freeze boundary persists for the session via the state file. The hook
script reads it on every edit/write invocation.

## Notes

- The trailing `/` on the freeze directory prevents `/src` from matching `/src-old`
- Freeze applies to edit and write tools only — read, exec, exec(find), exec(grep) are unaffected
- This prevents accidental edits, not a security boundary — exec commands like `sed` can still modify files outside the boundary
- To deactivate, run `/unfreeze` or end the conversation
