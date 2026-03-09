#!/usr/bin/env bash
set -euo pipefail
# Legacy wrapper kept for compatibility. Prefer scripts/a8ads_recorder.sh.
exec /home/keep/.openclaw/workspace/scripts/a8ads_recorder.sh "$@"
