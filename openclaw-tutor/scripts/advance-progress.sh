#!/bin/bash
# 验收通过后推进课程进度：补 completedDays，并在合适时推进 currentDay

set -euo pipefail

export TZ="Asia/Shanghai"

PROGRESS_FILE="/home/keep/.openclaw/workspace/openclaw-tutor/progress.json"

if [ ! -f "$PROGRESS_FILE" ]; then
  echo "❌ 找不到进度文件：$PROGRESS_FILE"
  exit 1
fi

DAY="${1:-}"
REASON="${2:-验收通过}"

if [ -z "$DAY" ]; then
  echo "用法：$(basename "$0") <day-number> [reason]"
  echo "示例：$(basename "$0") 7 '用户提交验收结果并通过'"
  exit 1
fi

if ! [[ "$DAY" =~ ^[0-9]+$ ]]; then
  echo "❌ day-number 必须是正整数，收到：$DAY"
  exit 1
fi

CURRENT_DAY=$(jq -r '.currentDay // 1' "$PROGRESS_FILE")
TOTAL_DAYS=$(jq -r '.totalDays // 14' "$PROGRESS_FILE")

if [ "$DAY" -lt 1 ] || [ "$DAY" -gt "$TOTAL_DAYS" ]; then
  echo "❌ Day $DAY 超出有效范围（1-${TOTAL_DAYS}）"
  exit 1
fi

NEXT_DAY="$CURRENT_DAY"
if [ "$CURRENT_DAY" -eq "$DAY" ] && [ "$CURRENT_DAY" -lt "$TOTAL_DAYS" ]; then
  NEXT_DAY=$((CURRENT_DAY + 1))
fi

TMP_FILE=$(mktemp)
jq \
  --argjson day "$DAY" \
  --argjson nextDay "$NEXT_DAY" \
  --arg now "$(date --iso-8601=seconds)" \
  --arg reason "$REASON" \
  --arg note "$(date +%F)：Day ${DAY} 已验收通过（${REASON}），$( [ "$NEXT_DAY" -ne "$CURRENT_DAY" ] && printf '进度推进到 Day %s' "$NEXT_DAY" || printf '当前课程序号保持 Day %s' "$CURRENT_DAY" )" \
  '
  .completedDays = (((.completedDays // []) + [$day]) | unique | sort)
  | .lastInteraction = $now
  | .notes = ((.notes // []) + [$note])
  | if .currentDay == $day and .currentDay < (.totalDays // 14) then
      .currentDay = $nextDay
    else
      .
    end
  ' "$PROGRESS_FILE" > "$TMP_FILE"
mv "$TMP_FILE" "$PROGRESS_FILE"

echo "✅ 已记录 Day ${DAY} 验收通过"
echo "- completedDays：$(jq -r '.completedDays | join(", ")' "$PROGRESS_FILE")"
echo "- currentDay：$(jq -r '.currentDay' "$PROGRESS_FILE")"
