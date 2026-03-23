---
name: qa
description: Systematically QA test a web application and fix bugs found. Runs QA testing, then iteratively fixes bugs in source code, committing each fix atomically and re-verifying. Use when asked to "qa", "QA", "test this site", "find bugs", "test and fix", or "fix what's broken". Proactively suggest when the user says a feature is ready for testing or asks "does this work?". Three tiers: Quick (critical/high only), Standard (+ medium), Exhaustive (+ cosmetic). Produces before/after health scores, fix evidence, and a ship-readiness summary. For report-only mode, use /qa-only.
user-invocable: true
---

# qa

This is the **OpenClaw wrapper** for Garry Tan's gstack `qa` workflow.

Use this skill when the user explicitly invokes `/qa` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/qa/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/qa/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.

## OpenClaw fast path
- Use `browser` for user-flow QA and `exec` for test commands.
- If a staging URL is provided, first capture a browser snapshot and reproduce the main flow before proposing fixes.
- Prefer concise bug lists with reproduction + evidence + fix status.
