---
name: cso
description: Chief Security Officer mode. Performs OWASP Top 10 audit, STRIDE threat modeling, attack surface analysis, auth flow verification, secret detection, dependency CVE scanning, supply chain risk assessment, and data classification review. Use when: "security audit", "threat model", "pentest review", "OWASP", "CSO review".
user-invocable: true
---

# cso

This is the **OpenClaw wrapper** for Garry Tan's gstack `cso` workflow.

Use this skill when the user explicitly invokes `/cso` or when this workflow is clearly the best fit.

Before doing the workflow, read and follow:
- `{baseDir}/../gstack/cso/OPENCLAW.md`

Source: gstack skill source in `{baseDir}/../gstack/cso/`

## OpenClaw wrapper rules
- Prefer OpenClaw-native tools (`exec`, `read`, `write`, `edit`, `browser`, `web_search`, `web_fetch`).
- Do not assume Claude-only helpers exist.
- Keep progress updates visible for longer jobs.
- If the source workflow asks to stop for user approval, ask directly in chat and wait.
