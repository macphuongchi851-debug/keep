---
name: review
description: Pre-landing PR review. Analyzes diff against the base branch for SQL safety, LLM trust boundary violations, conditional side effects, and other structural issues. Use when asked to "review this PR", "code review", "pre-landing review", or "check my diff". Proactively suggest when the user is about to merge or land code changes.
user-invocable: true
---

# review

This is the **OpenClaw wrapper** for Garry Tan's gstack `review` workflow.

Use this skill when the user explicitly invokes `/review` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/review/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/review/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.

## OpenClaw fast path
- Start with `exec` for `git status`, `git diff`, and targeted test/lint commands.
- Use `read`/`edit` directly for findings and fixes.
- Treat the original gstack review checklist as methodology, not as a requirement to use Claude-specific helpers.
