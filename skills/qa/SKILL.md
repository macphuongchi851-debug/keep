---
name: qa
description: QA workflow wrapper for Garry Tan's gstack. Use when asked to qa a site, test a web app, find bugs, or test-and-fix user flows.
user-invocable: true
---

# qa

This is the OpenClaw wrapper for gstack qa.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/qa/OPENCLAW.md`

Use OpenClaw-native tools first: `exec`, `read`, `write`, `edit`, `browser`, `web_search`, and `web_fetch`.

## OpenClaw fast path
- Use `browser` for user-flow QA and `exec` for local test commands.
- Prefer concise bug lists with reproduction, evidence, and fix status.
