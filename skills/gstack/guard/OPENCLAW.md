
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

# /guard — Full Safety Mode

Activates both destructive command warnings and directory-scoped edit restrictions.
This is the combination of `/careful` + `/freeze` in a single command.

**Dependency note:** This skill references hook scripts from the sibling `/careful`
and `/freeze` skill directories. Both must be installed (they are installed together
by the gstack setup script).

```bash
mkdir -p ~/.gstack/analytics
echo '{"skill":"guard","ts":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'","repo":"'$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo "unknown")'"}'  >> ~/.gstack/analytics/skill-usage.jsonl 2>/dev/null || true
```

## Setup

Ask the user which directory to restrict edits to. Use ask the user directly in chat:

- Question: "Guard mode: which directory should edits be restricted to? Destructive command warnings are always on. Files outside the chosen path will be blocked from editing."
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

Tell the user:
- "**Guard mode active.** Two protections are now running:"
- "1. **Destructive command warnings** — rm -rf, DROP TABLE, force-push, etc. will warn before executing (you can override)"
- "2. **edit boundary** — file edits restricted to `<path>/`. Edits outside this directory are blocked."
- "To remove the edit boundary, run `/unfreeze`. To deactivate everything, end the session."

## What's protected

See `/careful` for the full list of destructive command patterns and safe exceptions.
See `/freeze` for how edit boundary enforcement works.
