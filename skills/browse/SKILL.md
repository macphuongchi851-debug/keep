---
name: browse
description: Fast headless browser for QA testing and site dogfooding. Navigate any URL, interact with elements, verify page state, diff before/after actions, take annotated screenshots, check responsive layouts, test forms and uploads, handle dialogs, and assert element states. ~100ms per command. Use when you need to test a feature, verify a deployment, dogfood a user flow, or file a bug with evidence. Use when asked to "open in browser", "test the site", "take a screenshot", or "dogfood this".
user-invocable: true
---

# browse

This is the **OpenClaw wrapper** for Garry Tan's gstack `browse` workflow.

Use this skill when the user explicitly invokes `/browse` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/browse/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/browse/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.

## OpenClaw fast path
- Prefer the `browser` tool for opening pages, snapshots, screenshots, clicks, typing, and assertions.
- Only fall back to shell/browser binaries if the `browser` tool cannot do the job.
- When the user asks to "open in browser", "test page", or "take screenshot", do not run gstack's custom browse binary first; use `browser`.
