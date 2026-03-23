---
name: browse
description: Browser testing wrapper for Garry Tan's gstack. Use to inspect pages, flows, screenshots, and UI behavior.
user-invocable: true
---

# browse

This is the OpenClaw wrapper for gstack browse.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/browse/OPENCLAW.md`

Use OpenClaw-native tools first: `exec`, `read`, `write`, `edit`, `browser`, `web_search`, and `web_fetch`.

## OpenClaw fast path
- Use `browser` first for snapshots, screenshots, clicks, typing, and assertions.
- Fall back to shell/browser binaries only if OpenClaw browser tooling cannot do the job.
