---
name: freeze
description: Restrict file edits to a specific directory for the session. Blocks Edit and Write outside the allowed path. Use when debugging to prevent accidentally "fixing" unrelated code, or when you want to scope changes to one module. Use when asked to "freeze", "restrict edits", "only edit this folder", or "lock down edits".
user-invocable: true
---

# freeze

This is the **OpenClaw wrapper** for Garry Tan's gstack `freeze` workflow.

Use this skill when the user explicitly invokes `/freeze` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/freeze/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/freeze/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
