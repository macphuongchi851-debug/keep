---
name: retro
description: Weekly engineering retrospective. Analyzes commit history, work patterns, and code quality metrics with persistent history and trend tracking. Team-aware: breaks down per-person contributions with praise and growth areas. Use when asked to "weekly retro", "what did we ship", or "engineering retrospective". Proactively suggest at the end of a work week or sprint.
user-invocable: true
---

# retro

This is the **OpenClaw wrapper** for Garry Tan's gstack `retro` workflow.

Use this skill when the user explicitly invokes `/retro` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/retro/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/retro/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
