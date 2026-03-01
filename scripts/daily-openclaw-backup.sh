#!/usr/bin/env bash
set -euo pipefail

CHAT_ID="telegram:8327241925"
DRY_RUN=0

if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

TS=$(date +%F-%H%M%S)
OC_DIR="$HOME/.openclaw"
CONF="$OC_DIR/openclaw.json"

if [[ ! -f "$CONF" ]]; then
  echo "ERROR: config not found: $CONF" >&2
  exit 1
fi

# 1) backup config in the same directory (hard rule)
CONF_BAK="$OC_DIR/openclaw.json.bak.$TS"
cp "$CONF" "$CONF_BAK"

# 2) build migration bundle (keep it small)
BUNDLE="$OC_DIR/migrate-bundle.$TS.tar.gz"
TMPDIR=$(mktemp -d)
cleanup() { rm -rf "$TMPDIR"; }
trap cleanup EXIT

# Collect files into a temp staging dir to avoid tar errors when optional files are missing.
mkdir -p "$TMPDIR/.openclaw" "$TMPDIR/.config/systemd/user"

cp "$CONF" "$TMPDIR/.openclaw/openclaw.json"

# workspace (docs/memory)
if [[ -d "$OC_DIR/workspace" ]]; then
  mkdir -p "$TMPDIR/.openclaw/workspace"
  rsync -a --delete \
    --exclude '.git/' \
    --exclude 'node_modules/' \
    --exclude '.cache/' \
    "$OC_DIR/workspace/" "$TMPDIR/.openclaw/workspace/"
fi

# systemd user service + drop-ins (for gateway token/env)
if [[ -f "$HOME/.config/systemd/user/openclaw-gateway.service" ]]; then
  cp "$HOME/.config/systemd/user/openclaw-gateway.service" "$TMPDIR/.config/systemd/user/"
fi
if [[ -d "$HOME/.config/systemd/user/openclaw-gateway.service.d" ]]; then
  mkdir -p "$TMPDIR/.config/systemd/user/openclaw-gateway.service.d"
  rsync -a "$HOME/.config/systemd/user/openclaw-gateway.service.d/" "$TMPDIR/.config/systemd/user/openclaw-gateway.service.d/"
fi

# auth profiles (may contain provider keys; included because migration needs it)
if [[ -f "$OC_DIR/agents/main/agent/auth-profiles.json" ]]; then
  mkdir -p "$TMPDIR/.openclaw/agents/main/agent"
  cp "$OC_DIR/agents/main/agent/auth-profiles.json" "$TMPDIR/.openclaw/agents/main/agent/"
fi

# Create archive
(
  cd "$TMPDIR"
  tar -czf "$BUNDLE" .openclaw .config
)

# 3) deliver to Telegram
# NOTE: openclaw CLI only allows attaching local media from approved directories.
# So we always COPY artifacts into the workspace before sending.
if [[ "$DRY_RUN" == "1" ]]; then
  echo "DRY RUN: created:\n- $CONF_BAK\n- $BUNDLE"
  exit 0
fi

STAGE_DIR="$OC_DIR/workspace/backups"
mkdir -p "$STAGE_DIR"

CONF_SEND="$STAGE_DIR/$(basename "$CONF_BAK")"
BUNDLE_SEND="$STAGE_DIR/$(basename "$BUNDLE")"
cp "$CONF_BAK" "$CONF_SEND"
cp "$BUNDLE" "$BUNDLE_SEND"

openclaw message send --channel telegram --target "$CHAT_ID" \
  --message "老爹，23点自动备份到了（$TS）：\n1) 配置文件备份（同目录）：openclaw.json.bak.$TS\n2) 迁移包：migrate-bundle.$TS.tar.gz\n（包含 openclaw.json + workspace + gateway systemd 配置 + auth-profiles）" \
  --media "$CONF_SEND" --silent

openclaw message send --channel telegram --target "$CHAT_ID" \
  --message "老爹，这是迁移包 migrate-bundle.$TS.tar.gz（用于换主机一键搬家）。" \
  --media "$BUNDLE_SEND" --silent

echo "OK: delivered backups for $TS"