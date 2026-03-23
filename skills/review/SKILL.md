---
name: review
description: Pre-landing review wrapper for Garry Tan's gstack. Use to review diffs, risk, and correctness before merge.
user-invocable: true
---

# review

This is the OpenClaw wrapper for gstack review.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/review/OPENCLAW.md`

Use OpenClaw-native tools first: `exec`, `read`, `write`, `edit`, `browser`, `web_search`, and `web_fetch`.

## OpenClaw fast path
- Start with `exec` for git status, diffs, and targeted test/lint commands.
- Use `read` and `edit` directly for findings and fixes.
