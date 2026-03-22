#!/bin/bash
# 每日课程推送脚本：推送前自动把进度补到“今天应该发到哪一天”

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
START_DATE=$(jq -r '.startDate // empty' "$PROGRESS_FILE")
TOTAL_DAYS=$(jq -r '.totalDays // 14' "$PROGRESS_FILE")
TODAY=$(date +%F)

# 3. 按 startDate 自动补推进（只前进，不回退）
if [ -n "$START_DATE" ]; then
  start_ts=$(date -d "$START_DATE" +%s)
  today_ts=$(date -d "$TODAY" +%s)

  if [ "$today_ts" -lt "$start_ts" ]; then
    EXPECTED_DAY=1
  else
    EXPECTED_DAY=$(( (today_ts - start_ts) / 86400 + 1 ))
  fi

  if [ "$EXPECTED_DAY" -gt "$TOTAL_DAYS" ]; then
    EXPECTED_DAY="$TOTAL_DAYS"
  fi

  if [ "$CURRENT_DAY" -lt "$EXPECTED_DAY" ]; then
    tmp_file=$(mktemp)
    jq \
      --argjson expectedDay "$EXPECTED_DAY" \
      --arg now "$(date --iso-8601=seconds)" \
      --arg note "$(date +%F)：定时推送前自动补推进到 Day ${EXPECTED_DAY}（避免卡在前一天）" \
      '.currentDay = $expectedDay
       | .lastInteraction = $now
       | .notes = ((.notes // []) + [$note])' \
      "$PROGRESS_FILE" > "$tmp_file"
    mv "$tmp_file" "$PROGRESS_FILE"
    CURRENT_DAY="$EXPECTED_DAY"
  fi
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
