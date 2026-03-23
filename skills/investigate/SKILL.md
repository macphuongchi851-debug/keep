---
name: investigate
description: Root-cause debugging workflow wrapper for Garry Tan's gstack. Use when debugging errors, unexpected behavior, failures, or incidents.
user-invocable: true
---

# investigate

This is the OpenClaw wrapper for gstack investigate.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/investigate/OPENCLAW.md`

Use OpenClaw-native tools first: `exec`, `read`, `write`, `edit`, `browser`, `web_search`, and `web_fetch`.

## OpenClaw fast path
- Start with evidence collection using `exec`, `read`, and logs.
- Prefer root-cause analysis before code edits.
