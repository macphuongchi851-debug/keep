#!/usr/bin/env bash
set -euo pipefail

# A8Ads window recorder (stable, parameterized)
# Usage:
#   scripts/a8ads_recorder.sh /path/to/output.mp4 [duration_seconds]
# Env overrides:
#   WINDOW_PATTERN='A8Ads - Facebook广告监控平台 | 广告投放数据分析工具 - Google Chrome'
#   FPS=15 SCALE_WIDTH=1600 CRF=31 PRESET=veryfast DISPLAY_NUM=:0 XAUTHORITY_PATH=~/.Xauthority

OUTFILE="${1:-}"
DUR="${2:-92}"
if [[ -z "$OUTFILE" ]]; then
  echo "Usage: $0 OUTPUT.mp4 [duration_seconds]" >&2
  exit 64
fi

WINDOW_PATTERN="${WINDOW_PATTERN:-A8Ads - Facebook广告监控平台 | 广告投放数据分析工具 - Google Chrome}"
FPS="${FPS:-15}"
SCALE_WIDTH="${SCALE_WIDTH:-1600}"
CRF="${CRF:-31}"
PRESET="${PRESET:-veryfast}"
DISPLAY_NUM="${DISPLAY_NUM:-:0}"
XAUTHORITY_PATH="${XAUTHORITY_PATH:-$HOME/.Xauthority}"
PIX_FMT="${PIX_FMT:-yuv420p}"
WORKDIR="/home/keep/.openclaw/workspace"

resolve_ffmpeg() {
  local candidates=(
    "$WORKDIR/.tmp_ffmpeg/node_modules/ffmpeg-static/ffmpeg"
    "$(command -v ffmpeg 2>/dev/null || true)"
  )
  local c
  for c in "${candidates[@]}"; do
    if [[ -n "$c" && -x "$c" ]]; then
      printf '%s\n' "$c"
      return 0
    fi
  done
  echo "ffmpeg not found. Expected static binary under $WORKDIR/.tmp_ffmpeg or system ffmpeg in PATH." >&2
  return 1
}

resolve_window_id() {
  xwininfo -root -tree | awk -v pat="$WINDOW_PATTERN" 'index($0, pat) {print $1; exit}'
}

read_geometry() {
  local wid="$1"
  xwininfo -id "$wid" | awk '
    /Absolute upper-left X:/ {x=$4}
    /Absolute upper-left Y:/ {y=$4}
    /Width:/ {w=$2}
    /Height:/ {h=$2}
    END {
      if (x == "" || y == "" || w == "" || h == "") exit 1;
      print x, y, w, h
    }'
}

mkdir -p "$(dirname "$OUTFILE")"
FFMPEG_BIN="$(resolve_ffmpeg)"
WIN_ID="$(resolve_window_id || true)"
if [[ -z "$WIN_ID" ]]; then
  echo "A8Ads window not found. WINDOW_PATTERN=$WINDOW_PATTERN" >&2
  exit 65
fi

read X Y W H < <(read_geometry "$WIN_ID")
if [[ -z "${W:-}" || -z "${H:-}" ]]; then
  echo "Failed to read geometry for window $WIN_ID" >&2
  exit 66
fi

cat <<EOF
[a8ads_recorder] ffmpeg=$FFMPEG_BIN
[a8ads_recorder] window_id=$WIN_ID
[a8ads_recorder] geometry=${W}x${H}+${X},${Y}
[a8ads_recorder] duration=${DUR}s fps=${FPS} scale_width=${SCALE_WIDTH} crf=${CRF} preset=${PRESET}
[a8ads_recorder] output=$OUTFILE
EOF

DISPLAY="$DISPLAY_NUM" XAUTHORITY="$XAUTHORITY_PATH" \
  "$FFMPEG_BIN" -y \
  -video_size "${W}x${H}" \
  -framerate "$FPS" \
  -f x11grab -i "${DISPLAY_NUM}.0+${X},${Y}" \
  -t "$DUR" \
  -vf "scale=${SCALE_WIDTH}:-2" \
  -c:v libx264 -preset "$PRESET" -crf "$CRF" \
  -pix_fmt "$PIX_FMT" \
  -movflags +faststart \
  -an \
  "$OUTFILE"
