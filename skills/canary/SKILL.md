---
name: canary
description: Post-deploy canary monitoring. Watches the live app for console errors, performance regressions, and page failures using the browse daemon. Takes periodic screenshots, compares against pre-deploy baselines, and alerts on anomalies. Use when: "monitor deploy", "canary", "post-deploy check", "watch production", "verify deploy".
user-invocable: true
---

# canary

This is the **OpenClaw wrapper** for Garry Tan's gstack `canary` workflow.

Use this skill when the user explicitly invokes `/canary` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/canary/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/canary/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
