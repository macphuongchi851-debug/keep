---
name: qa-only
description: Report-only QA wrapper for Garry Tan's gstack. Use to test a site and report bugs without making fixes.
user-invocable: true
---

# qa-only

This is the OpenClaw wrapper for gstack qa-only.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/qa-only/OPENCLAW.md`

Use OpenClaw-native tools first: `exec`, `read`, `write`, `edit`, `browser`, `web_search`, and `web_fetch`.

## OpenClaw fast path
- Use `browser` for flow testing and capture evidence without making code changes.
- Return a concise report with reproduction steps and severity.
