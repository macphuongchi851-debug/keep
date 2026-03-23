---
name: autoplan
description: Auto-review pipeline — reads the full CEO, design, and eng review skills from disk and runs them sequentially with auto-decisions using 6 decision principles. Surfaces taste decisions (close approaches, borderline scope, codex disagreements) at a final approval gate. One command, fully reviewed plan out. Use when asked to "auto review", "autoplan", "run all reviews", "review this plan automatically", or "make the decisions for me". Proactively suggest when the user has a plan file and wants to run the full review gauntlet without answering 15-30 intermediate questions.
user-invocable: true
---

# autoplan

This is the **OpenClaw wrapper** for Garry Tan's gstack `autoplan` workflow.

Use this skill when the user explicitly invokes `/autoplan` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/autoplan/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/autoplan/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
