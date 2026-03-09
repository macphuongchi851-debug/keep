#!/usr/bin/env bash
set -euo pipefail
# Backward-compatible wrapper. Prefer scripts/a8ads_recorder.sh.
exec /home/keep/.openclaw/workspace/scripts/a8ads_recorder.sh "$@"
