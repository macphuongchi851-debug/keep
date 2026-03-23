---
name: investigate
description: Systematic debugging with root cause investigation. Four phases: investigate, analyze, hypothesize, implement. Iron Law: no fixes without root cause. Use when asked to "debug this", "fix this bug", "why is this broken", "investigate this error", or "root cause analysis". Proactively suggest when the user reports errors, unexpected behavior, or is troubleshooting why something stopped working.
user-invocable: true
---

# investigate

This is the **OpenClaw wrapper** for Garry Tan's gstack `investigate` workflow.

Use this skill when the user explicitly invokes `/investigate` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/investigate/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/investigate/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
