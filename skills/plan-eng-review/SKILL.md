---
name: plan-eng-review
description: Eng manager-mode plan review. Lock in the execution plan — architecture, data flow, diagrams, edge cases, test coverage, performance. Walks through issues interactively with opinionated recommendations. Use when asked to "review the architecture", "engineering review", or "lock in the plan". Proactively suggest when the user has a plan or design doc and is about to start coding — to catch architecture issues before implementation.
user-invocable: true
---

# plan-eng-review

This is the **OpenClaw wrapper** for Garry Tan's gstack `plan-eng-review` workflow.

Use this skill when the user explicitly invokes `/plan-eng-review` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/plan-eng-review/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/plan-eng-review/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
