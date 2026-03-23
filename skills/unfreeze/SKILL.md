---
name: unfreeze
description: Clear the freeze boundary set by /freeze, allowing edits to all directories again. Use when you want to widen edit scope without ending the session. Use when asked to "unfreeze", "unlock edits", "remove freeze", or "allow all edits".
user-invocable: true
---

# unfreeze

This is the **OpenClaw wrapper** for Garry Tan's gstack `unfreeze` workflow.

Use this skill when the user explicitly invokes `/unfreeze` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/unfreeze/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/unfreeze/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
