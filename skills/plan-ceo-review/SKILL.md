---
name: plan-ceo-review
description: CEO/founder-mode plan review. Rethink the problem, find the 10-star product, challenge premises, expand scope when it creates a better product. Four modes: SCOPE EXPANSION (dream big), SELECTIVE EXPANSION (hold scope + cherry-pick expansions), HOLD SCOPE (maximum rigor), SCOPE REDUCTION (strip to essentials). Use when asked to "think bigger", "expand scope", "strategy review", "rethink this", or "is this ambitious enough". Proactively suggest when the user is questioning scope or ambition of a plan, or when the plan feels like it could be thinking bigger.
user-invocable: true
---

# plan-ceo-review

This is the **OpenClaw wrapper** for Garry Tan's gstack `plan-ceo-review` workflow.

Use this skill when the user explicitly invokes `/plan-ceo-review` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/plan-ceo-review/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/plan-ceo-review/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
