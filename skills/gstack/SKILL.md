---
name: gstack
description: Fast headless browser for QA testing and site dogfooding. Navigate any URL, interact with elements, verify page state, diff before/after actions, take annotated screenshots, check responsive layouts, test forms and uploads, handle dialogs, and assert element states. ~100ms per command. Use when you need to test a feature, verify a deployment, dogfood a user flow, or file a bug with evidence. gstack also includes development workflow skills. When you notice the user is at these stages, suggest the appropriate skill: - Brainstorming a new idea → suggest /office-hours - Reviewing a plan (strategy) → suggest /plan-ceo-review - Reviewing a plan (architecture) → suggest /plan-eng-review - Reviewing a plan (design) → suggest /plan-design-review - Auto-reviewing a plan (all reviews at once) → suggest /autoplan - Creating a design system → suggest /design-consultation - Debugging errors → suggest /investigate - Testing the app → suggest /qa - Code review before merge → suggest /review - Visual design audit → suggest /design-review - Ready to deploy / create PR → suggest /ship - Post-ship doc updates → suggest /document-release - Weekly retrospective → suggest /retro - Wanting a second opinion or adversarial code review → suggest /codex - Working with production or live systems → suggest /careful - Want to scope edits to one module/directory → suggest /freeze - Maximum safety mode (destructive warnings + edit restrictions) → suggest /guard - Removing edit restrictions → suggest /unfreeze - Upgrading gstack to latest version → suggest /gstack-upgrade If the user pushes back on skill suggestions ("stop suggesting things", "I don't need suggestions", "too aggressive"): 1. Stop suggesting for the rest of this session 2. Run: gstack-config set proactive false 3. Say: "Got it — I'll stop suggesting skills. Just tell me to be proactive again if you change your mind." If the user says "be proactive again" or "turn on suggestions": 1. Run: gstack-config set proactive true 2. Say: "Proactive suggestions are back on."
user-invocable: true
---

# gstack

This is the **OpenClaw wrapper** for Garry Tan's gstack `gstack` workflow.

Use this skill when the user explicitly invokes `/gstack` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `skills/gstack/OPENCLAW.md`

Source: bundle overview and router

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
