---
name: plan-design-review
description: Designer's eye plan review — interactive, like CEO and Eng review. Rates each design dimension 0-10, explains what would make it a 10, then fixes the plan to get there. Works in plan mode. For live site visual audits, use /design-review. Use when asked to "review the design plan" or "design critique". Proactively suggest when the user has a plan with UI/UX components that should be reviewed before implementation.
user-invocable: true
---

# plan-design-review

This is the **OpenClaw wrapper** for Garry Tan's gstack `plan-design-review` workflow.

Use this skill when the user explicitly invokes `/plan-design-review` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/plan-design-review/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/plan-design-review/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
