---
name: setup-browser-cookies
description: Import cookies from your real browser (Comet, Chrome, Arc, Brave, Edge) into the headless browse session. Opens an interactive picker UI where you select which cookie domains to import. Use before QA testing authenticated pages. Use when asked to "import cookies", "login to the site", or "authenticate the browser".
user-invocable: true
---

# setup-browser-cookies

This is the **OpenClaw wrapper** for Garry Tan's gstack `setup-browser-cookies` workflow.

Use this skill when the user explicitly invokes `/setup-browser-cookies` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/setup-browser-cookies/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/setup-browser-cookies/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
