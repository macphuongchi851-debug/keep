---
name: gstack-upgrade
description: Upgrade gstack to the latest version. Detects global vs vendored install, runs the upgrade, and shows what's new. Use when asked to "upgrade gstack", "update gstack", or "get latest version".
user-invocable: true
---

# gstack-upgrade

This is the **OpenClaw wrapper** for Garry Tan's gstack `gstack-upgrade` workflow.

Use this skill when the user explicitly invokes `/gstack-upgrade` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/gstack-upgrade/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/gstack-upgrade/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
