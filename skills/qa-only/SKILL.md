---
name: qa-only
description: Report-only QA testing. Systematically tests a web application and produces a structured report with health score, screenshots, and repro steps — but never fixes anything. Use when asked to "just report bugs", "qa report only", or "test but don't fix". For the full test-fix-verify loop, use /qa instead. Proactively suggest when the user wants a bug report without any code changes.
user-invocable: true
---

# qa-only

This is the **OpenClaw wrapper** for Garry Tan's gstack `qa-only` workflow.

Use this skill when the user explicitly invokes `/qa-only` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/qa-only/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/qa-only/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
