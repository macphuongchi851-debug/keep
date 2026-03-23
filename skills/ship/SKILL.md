---
name: ship
description: Ship workflow: detect + merge base branch, run tests, review diff, bump VERSION, update CHANGELOG, commit, push, create PR. Use when asked to "ship", "deploy", "push to main", "create a PR", or "merge and push". Proactively suggest when the user says code is ready or asks about deploying.
user-invocable: true
---

# ship

This is the **OpenClaw wrapper** for Garry Tan's gstack `ship` workflow.

Use this skill when the user explicitly invokes `/ship` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/ship/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/ship/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.

## OpenClaw fast path
- Use `exec` for git/test/build/release steps.
- Before any risky push/merge/deploy action, summarize the exact action and get user confirmation if the workflow has external impact.
- Prefer local validation first: status, diff, tests, build, changelog/doc updates.
