---
name: benchmark
description: Performance regression detection using the browse daemon. Establishes baselines for page load times, Core Web Vitals, and resource sizes. Compares before/after on every PR. Tracks performance trends over time. Use when: "performance", "benchmark", "page speed", "lighthouse", "web vitals", "bundle size", "load time".
user-invocable: true
---

# benchmark

This is the **OpenClaw wrapper** for Garry Tan's gstack `benchmark` workflow.

Use this skill when the user explicitly invokes `/benchmark` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/benchmark/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/benchmark/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
