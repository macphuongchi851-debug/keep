---
name: ship
description: Shipping workflow wrapper for Garry Tan's gstack. Use for pre-release checks, test/build validation, changelog updates, and release or PR preparation.
user-invocable: true
---

# ship

This is the OpenClaw wrapper for gstack ship.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/ship/OPENCLAW.md`

Use OpenClaw-native tools first: `exec`, `read`, `write`, `edit`, `browser`, `web_search`, and `web_fetch`.

## OpenClaw fast path
- Use `exec` for git, build, test, and release-prep commands.
- Summarize risky external actions before push, merge, deploy, or PR creation.
