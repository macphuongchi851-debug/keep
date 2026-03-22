#!/bin/bash
# 每日课程推送脚本：每天最多自动推进 1 天，并记录当天是否已推送

set -euo pipefail

export TZ="Asia/Shanghai"

PROGRESS_FILE="/home/keep/.openclaw/workspace/openclaw-tutor/progress.json"
COURSE_DIR="/home/keep/.openclaw/workspace/openclaw-tutor/references"

# 1. 校验进度文件存在
if [ ! -f "$PROGRESS_FILE" ]; then
  echo "❌ 致命错误：找不到进度文件 $PROGRESS_FILE"
  exit 1
fi

# 2. 读取进度配置
CURRENT_DAY=$(jq -r '.currentDay // 1' "$PROGRESS_FILE")
TOTAL_DAYS=$(jq -r '.totalDays // 14' "$PROGRESS_FILE")
LAST_PUSH_DATE=$(jq -r '.lastPushDate // empty' "$PROGRESS_FILE")
TODAY=$(date +%F)

# 3. 每个自然日最多自动推进 1 天，避免卡在前一天，也避免按 startDate 硬算导致跳天
if [ "$LAST_PUSH_DATE" != "$TODAY" ]; then
  NEXT_DAY="$CURRENT_DAY"
  if [ "$CURRENT_DAY" -lt "$TOTAL_DAYS" ]; then
    NEXT_DAY=$((CURRENT_DAY + 1))
  fi

  tmp_file=$(mktemp)
  jq \
    --argjson nextDay "$NEXT_DAY" \
    --arg today "$TODAY" \
    --arg now "$(date --iso-8601=seconds)" \
    --arg note "$(date +%F)：定时推送自动推进到 Day ${NEXT_DAY}（按天递进，每天最多 +1）" \
    '.currentDay = $nextDay
     | .lastPushDate = $today
     | .lastInteraction = $now
     | .notes = ((.notes // []) + [$note])' \
    "$PROGRESS_FILE" > "$tmp_file"
  mv "$tmp_file" "$PROGRESS_FILE"
  CURRENT_DAY="$NEXT_DAY"
fi

# 4. 校验课程文件存在
COURSE_FILE="$COURSE_DIR/day${CURRENT_DAY}.md"
if [ ! -f "$COURSE_FILE" ]; then
  echo "❌ 致命错误：课程文件不存在 $COURSE_FILE"
  echo "当前进度：Day $CURRENT_DAY"
  echo "请检查 progress.json 是否正确"
  exit 1
fi

# 5. 输出课程内容
echo "📚 OpenClaw 今日课程 - Day ${CURRENT_DAY}"
echo ""
cat "$COURSE_FILE"
