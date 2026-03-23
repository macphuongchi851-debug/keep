
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

# /unfreeze — Clear Freeze Boundary

Remove the edit restriction set by `/freeze`, allowing edits to all directories.

```bash
mkdir -p ~/.gstack/analytics
echo '{"skill":"unfreeze","ts":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'","repo":"'$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo "unknown")'"}'  >> ~/.gstack/analytics/skill-usage.jsonl 2>/dev/null || true
```

## Clear the boundary

```bash
STATE_DIR="${CLAUDE_PLUGIN_DATA:-$HOME/.gstack}"
if [ -f "$STATE_DIR/freeze-dir.txt" ]; then
  PREV=$(cat "$STATE_DIR/freeze-dir.txt")
  rm -f "$STATE_DIR/freeze-dir.txt"
  echo "Freeze boundary cleared (was: $PREV). Edits are now allowed everywhere."
else
  echo "No freeze boundary was set."
fi
```

Tell the user the result. Note that `/freeze` hooks are still registered for the
session — they will just allow everything since no state file exists. To re-freeze,
run `/freeze` again.
