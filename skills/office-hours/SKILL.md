---
name: office-hours
description: YC Office Hours — two modes. Startup mode: six forcing questions that expose demand reality, status quo, desperate specificity, narrowest wedge, observation, and future-fit. Builder mode: design thinking brainstorming for side projects, hackathons, learning, and open source. Saves a design doc. Use when asked to "brainstorm this", "I have an idea", "help me think through this", "office hours", or "is this worth building". Proactively suggest when the user describes a new product idea or is exploring whether something is worth building — before any code is written. Use before /plan-ceo-review or /plan-eng-review.
user-invocable: true
---

# office-hours

This is the **OpenClaw wrapper** for Garry Tan's gstack `office-hours` workflow.

Use this skill when the user explicitly invokes `/office-hours` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/office-hours/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/office-hours/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.

## OpenClaw fast path
- Run this as a structured conversation in chat.
- Ask one focused question at a time.
- If external research helps, use `web_search` / `web_fetch` after telling the user briefly.
