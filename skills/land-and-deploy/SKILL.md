---
name: land-and-deploy
description: Land and deploy workflow. Merges the PR, waits for CI and deploy, verifies production health via canary checks. Takes over after /ship creates the PR. Use when: "merge", "land", "deploy", "merge and verify", "land it", "ship it to production".
user-invocable: true
---

# land-and-deploy

This is the **OpenClaw wrapper** for Garry Tan's gstack `land-and-deploy` workflow.

Use this skill when the user explicitly invokes `/land-and-deploy` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/land-and-deploy/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/land-and-deploy/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
