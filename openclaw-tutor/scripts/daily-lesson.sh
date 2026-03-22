#!/bin/bash
# OpenClaw 教学系统 - 每日课程推送（重制版）

set -euo pipefail

PROGRESS_FILE="/home/keep/.openclaw/workspace/openclaw-tutor/progress.json"
COURSE_DIR="/home/keep/.openclaw/workspace/openclaw-tutor/references"

if [ ! -f "$PROGRESS_FILE" ]; then
  echo "❌ 找不到进度文件：$PROGRESS_FILE"
  exit 1
fi

CURRENT_DAY=$(jq -r '.currentDay // 1' "$PROGRESS_FILE")
COMPLETED_DAYS=$(jq -r '.completedDays // [] | join(", ")' "$PROGRESS_FILE")
LAST_INTERACTION=$(jq -r '.lastInteraction // "未记录"' "$PROGRESS_FILE")

TOTAL_DAYS=$(jq -r '.totalDays // 14' "$PROGRESS_FILE")

if [ "$CURRENT_DAY" -gt "$TOTAL_DAYS" ]; then
  echo "🎉 恭喜，你已经完成全部 ${TOTAL_DAYS} 天课程。"
  echo "现在更适合进入实战和持续优化，而不是继续看入门课了。"
  exit 0
fi

COURSE_FILE="$COURSE_DIR/day${CURRENT_DAY}.md"

if [ ! -f "$COURSE_FILE" ]; then
  echo "❌ 课程文件不存在：$COURSE_FILE"
  exit 1
fi

echo "📚 OpenClaw 今日课程提醒"
echo ""
echo "- 当前进度：Day ${CURRENT_DAY}"
echo "- 已完成：${COMPLETED_DAYS:-无}"
echo "- 上次学习记录：${LAST_INTERACTION}"
echo ""
echo "今天别只看，记得动手；做完把结果发我，我给你验收。"
echo ""
cat "$COURSE_FILE"
