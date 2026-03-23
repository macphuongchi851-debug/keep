---
name: qa
description: QA workflow wrapper for Garry Tan's gstack. Use when asked to qa a site, test a web app, find bugs, or test-and-fix user flows.
user-invocable: true
---

# qa

This is the OpenClaw wrapper for gstack QA.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/qa/OPENCLAW.md`

## OpenClaw fast path
- Use `browser` for user-flow QA.
- Use `exec` for test, lint, build, and local verification commands.
- Prefer concise bug lists with reproduction, evidence, and fix status.
- Treat the original gstack QA doc as methodology; prefer OpenClaw-native tools over Claude-specific assumptions.
