#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_REPO_DEFAULT="git@github.com:macphuongchi851-debug/mc2.git"
BACKUP_REPO_DEFAULT="git@github.com:macphuongchi851-debug/mc1.git"
SSH_KEY_DEFAULT="$HOME/.ssh/github_openclaw_backup_ed25519"
PASSPHRASE_FILE_DEFAULT="$HOME/.ssh/openclaw_backup_passphrase_last.txt"
OPENCLAW_DIR_DEFAULT="$HOME/.openclaw"
WORKSPACE_DIR_DEFAULT="$OPENCLAW_DIR_DEFAULT/workspace"
LOCK_DIR_DEFAULT="$OPENCLAW_DIR_DEFAULT/locks/github-dual-backup.lock"
SPLIT_SIZE_DEFAULT="95m"
NOTIFY_TO_DEFAULT="telegram:8327241925"
NOTIFY_CHANNEL_DEFAULT="telegram"
NOTIFY_ON_SUCCESS_DEFAULT="1"
GIT_USER_NAME_DEFAULT="OpenClaw Backup"
GIT_USER_EMAIL_DEFAULT="openclaw-backup@local"

WORKSPACE_REPO="${WORKSPACE_REPO:-$WORKSPACE_REPO_DEFAULT}"
BACKUP_REPO="${BACKUP_REPO:-$BACKUP_REPO_DEFAULT}"
SSH_KEY="${SSH_KEY:-$SSH_KEY_DEFAULT}"
PASSPHRASE_FILE="${PASSPHRASE_FILE:-$PASSPHRASE_FILE_DEFAULT}"
OPENCLAW_DIR="${OPENCLAW_DIR:-$OPENCLAW_DIR_DEFAULT}"
WORKSPACE_DIR="${WORKSPACE_DIR:-$WORKSPACE_DIR_DEFAULT}"
LOCK_DIR="${LOCK_DIR:-$LOCK_DIR_DEFAULT}"
SPLIT_SIZE="${SPLIT_SIZE:-$SPLIT_SIZE_DEFAULT}"
NOTIFY_TO="${NOTIFY_TO:-$NOTIFY_TO_DEFAULT}"
NOTIFY_CHANNEL="${NOTIFY_CHANNEL:-$NOTIFY_CHANNEL_DEFAULT}"
NOTIFY_ON_SUCCESS="${NOTIFY_ON_SUCCESS:-$NOTIFY_ON_SUCCESS_DEFAULT}"
GIT_USER_NAME="${GIT_USER_NAME:-$GIT_USER_NAME_DEFAULT}"
GIT_USER_EMAIL="${GIT_USER_EMAIL:-$GIT_USER_EMAIL_DEFAULT}"

DRY_RUN=0
WORKSPACE_ONLY=0
BACKUP_ONLY=0
VERIFY_REMOTE=1
KEEP_TEMP=0

TS="$(date +%F-%H%M%S)"
TMP_ROOT="$(mktemp -d /tmp/github-dual-backup.XXXXXX)"

usage() {
  cat <<'EOF'
Usage: github-dual-backup.sh [options]

Options:
  --dry-run         Prepare/check only; do not push to GitHub.
  --workspace-only  Only back up the sanitized workspace repo.
  --backup-only     Only back up the encrypted full .openclaw repo.
  --no-verify       Skip remote head verification after push.
  --keep-temp       Do not delete temporary build directory.
  -h, --help        Show this help.

Environment overrides:
  WORKSPACE_REPO    SSH repo URL for workspace backup.
  BACKUP_REPO       SSH repo URL for encrypted .openclaw backup.
  SSH_KEY           SSH private key used for git@github.com.
  PASSPHRASE_FILE   File containing backup encryption passphrase.
  OPENCLAW_DIR      Source .openclaw directory.
  WORKSPACE_DIR     Source workspace directory.
  LOCK_DIR          Lock directory to prevent concurrent runs.
  SPLIT_SIZE        Split size for encrypted backup parts (default: 95m).
  NOTIFY_TO         Delivery target for success notifications.
  NOTIFY_CHANNEL    Delivery channel for success notifications.
  NOTIFY_ON_SUCCESS Set 1 to notify after success, 0 to disable.
EOF
}

log() {
  printf '[%s] %s\n' "$(date '+%F %T')" "$*"
}

die() {
  echo "ERROR: $*" >&2
  exit 1
}

cleanup() {
  rm -rf "$LOCK_DIR" 2>/dev/null || true
  if [[ "$KEEP_TEMP" == "1" ]]; then
    log "Keeping temp directory: $TMP_ROOT"
  else
    rm -rf "$TMP_ROOT"
  fi
}
trap cleanup EXIT

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --workspace-only) WORKSPACE_ONLY=1 ;;
    --backup-only) BACKUP_ONLY=1 ;;
    --no-verify) VERIFY_REMOTE=0 ;;
    --keep-temp) KEEP_TEMP=1 ;;
    -h|--help) usage; exit 0 ;;
    *) die "Unknown option: $1" ;;
  esac
  shift
done

if [[ "$WORKSPACE_ONLY" == "1" && "$BACKUP_ONLY" == "1" ]]; then
  die "Choose only one of --workspace-only / --backup-only"
fi

RUN_WORKSPACE=1
RUN_BACKUP=1
if [[ "$WORKSPACE_ONLY" == "1" ]]; then
  RUN_BACKUP=0
fi
if [[ "$BACKUP_ONLY" == "1" ]]; then
  RUN_WORKSPACE=0
fi

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Missing command: $1"
}

check_prereqs() {
  for cmd in git rsync tar gpg split ssh du find awk; do
    require_cmd "$cmd"
  done
  [[ -d "$OPENCLAW_DIR" ]] || die "Missing OPENCLAW_DIR: $OPENCLAW_DIR"
  [[ -d "$WORKSPACE_DIR" ]] || die "Missing WORKSPACE_DIR: $WORKSPACE_DIR"
  [[ -f "$SSH_KEY" ]] || die "Missing SSH key: $SSH_KEY"
  [[ -s "$PASSPHRASE_FILE" ]] || die "Missing or empty passphrase file: $PASSPHRASE_FILE"
  mkdir -p "$(dirname "$LOCK_DIR")"
  if ! mkdir "$LOCK_DIR" 2>/dev/null; then
    die "Another backup run is already in progress (lock exists: $LOCK_DIR)"
  fi
  chmod 600 "$SSH_KEY" || true

  local auth_out
  set +e
  auth_out=$(ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new -i "$SSH_KEY" -T git@github.com 2>&1)
  local auth_rc=$?
  set -e
  if [[ $auth_rc -ne 1 && $auth_rc -ne 0 ]]; then
    die "GitHub SSH auth failed: $auth_out"
  fi
  if ! grep -q "successfully authenticated" <<<"$auth_out"; then
    die "GitHub SSH auth did not succeed: $auth_out"
  fi
}

ensure_passphrase_file() {
  [[ -s "$PASSPHRASE_FILE" ]] || die "Missing or empty passphrase file: $PASSPHRASE_FILE"
}

init_repo_or_clone() {
  local repo_url="$1"
  local target_dir="$2"
  local branch="main"
  if GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git ls-remote --exit-code --heads "$repo_url" "$branch" >/dev/null 2>&1; then
    GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git clone --depth 1 --branch "$branch" "$repo_url" "$target_dir" >/dev/null 2>&1
  else
    git init -b "$branch" "$target_dir" >/dev/null
    git -C "$target_dir" remote add origin "$repo_url"
  fi
  git -C "$target_dir" config user.name "$GIT_USER_NAME"
  git -C "$target_dir" config user.email "$GIT_USER_EMAIL"
}

verify_remote_head() {
  local repo_dir="$1"
  local repo_url="$2"
  local local_head remote_head
  local_head="$(git -C "$repo_dir" rev-parse HEAD)"
  remote_head="$(GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git ls-remote "$repo_url" refs/heads/main | awk '{print $1}')"
  [[ -n "$remote_head" ]] || die "Remote head missing for $repo_url"
  [[ "$local_head" == "$remote_head" ]] || die "Remote head mismatch for $repo_url"
}

notify_success() {
  [[ "$NOTIFY_ON_SUCCESS" == "1" ]] || return 0
  [[ "$DRY_RUN" == "0" ]] || return 0
  [[ -n "$NOTIFY_TO" ]] || return 0
  require_cmd openclaw

  local msg="$1"
  openclaw message send \
    --channel "$NOTIFY_CHANNEL" \
    --target "$NOTIFY_TO" \
    --message "$msg" \
    --silent >/dev/null
}

backup_workspace() {
  local export_dir="$TMP_ROOT/workspace-export"
  local repo_dir="$TMP_ROOT/workspace-repo"
  mkdir -p "$export_dir"

  log "Preparing sanitized workspace export"
  rsync -a --delete \
    --exclude '.git/' \
    --exclude '.venv/' \
    --exclude 'logs/' \
    --exclude '.openclaw/' \
    --exclude 'memory/' \
    --exclude 'MEMORY.md' \
    --exclude 'BOOTSTRAP.md' \
    --exclude 'backups/' \
    --exclude 'migration/' \
    --exclude '*.bak' \
    --exclude '*.bak.*' \
    --exclude 'openclaw*.json' \
    --exclude '*.zip' \
    --exclude '*.tar' \
    --exclude '*.tar.gz' \
    --exclude '*.tgz' \
    --exclude '*.7z' \
    --exclude '*.rar' \
    --exclude '*.mp4' \
    --exclude '*.mov' \
    --exclude '*.webm' \
    --exclude '*.mkv' \
    --exclude 'raw/' \
    --exclude 'final/' \
    --exclude 'out-video/' \
    --exclude 'fix/' \
    --exclude 'tmp_*.jpg' \
    --exclude 'tmp_*.png' \
    --exclude 'tmp_*.jpeg' \
    --exclude 'wger_*.png' \
    --exclude 'wger_*.jpg' \
    "$WORKSPACE_DIR/" "$export_dir/"

  local export_size export_count
  export_size="$(du -sh "$export_dir" | awk '{print $1}')"
  export_count="$(find "$export_dir" -type f | wc -l | tr -d ' ')"
  log "Workspace export ready: $export_size, $export_count files"

  if [[ "$DRY_RUN" == "1" ]]; then
    log "DRY RUN: skipping workspace git push"
    return
  fi

  init_repo_or_clone "$WORKSPACE_REPO" "$repo_dir"
  rsync -a --delete --exclude '.git/' "$export_dir/" "$repo_dir/"

  git -C "$repo_dir" add -A
  if git -C "$repo_dir" diff --cached --quiet; then
    log "Workspace repo already up to date"
    return
  fi

  git -C "$repo_dir" commit -m "Automated sanitized workspace backup $TS" >/dev/null
  log "Pushing workspace backup to GitHub"
  GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git -C "$repo_dir" push -u origin main >/dev/null

  if [[ "$VERIFY_REMOTE" == "1" ]]; then
    verify_remote_head "$repo_dir" "$WORKSPACE_REPO"
    log "Workspace remote verified"
  fi
}

backup_full_openclaw() {
  ensure_passphrase_file

  local stage_dir="$TMP_ROOT/full-backup-stage"
  local snapshot_dir="$stage_dir/snapshot"
  local repo_dir="$TMP_ROOT/full-backup-repo"
  local archive_name="openclaw-full-latest.tar.gz.gpg"
  local archive_path="$stage_dir/$archive_name"
  local source_size archive_size part_count archive_sha

  source_size="$(du -sh "$OPENCLAW_DIR" | awk '{print $1}')"
  log "Preparing encrypted full backup from $OPENCLAW_DIR ($source_size)"

  if [[ "$DRY_RUN" == "1" ]]; then
    log "DRY RUN: skipping encrypted archive build/push"
    return
  fi

  mkdir -p "$snapshot_dir/.openclaw" "$repo_dir"
  rsync -a "$OPENCLAW_DIR/" "$snapshot_dir/.openclaw/"

  tar -C "$snapshot_dir" -czf - .openclaw | \
    gpg --batch --yes --pinentry-mode loopback --passphrase-file "$PASSPHRASE_FILE" \
      --symmetric --cipher-algo AES256 -o "$archive_path"

  archive_size="$(du -sh "$archive_path" | awk '{print $1}')"
  archive_sha="$(sha256sum "$archive_path" | awk '{print $1}')"

  split -b "$SPLIT_SIZE" -d -a 3 "$archive_path" "$repo_dir/$archive_name.part-"
  (
    cd "$repo_dir"
    sha256sum "$archive_name".part-* > SHA256SUMS.txt
  )
  part_count="$(find "$repo_dir" -maxdepth 1 -type f -name "$archive_name.part-*" | wc -l | tr -d ' ')"

  cat > "$repo_dir/README.md" <<EOF
# openclaw encrypted backup

Created: $(date -Is)
Source: $OPENCLAW_DIR
Archive: $archive_name
Archive SHA256: $archive_sha
Archive size: $archive_size
Parts: $part_count
Split size: $SPLIT_SIZE

## Restore

1. Download every part file plus SHA256SUMS.txt.
2. Verify part checksums:
   sha256sum -c SHA256SUMS.txt
3. Recombine:
   cat $archive_name.part-* > $archive_name
4. Decrypt:
   gpg --decrypt --output openclaw-backup.tar.gz $archive_name
5. Extract:
   mkdir restore && tar -xzf openclaw-backup.tar.gz -C restore

The extracted folder will contain a .openclaw directory.
EOF

  git init -b main "$repo_dir" >/dev/null
  git -C "$repo_dir" config user.name "$GIT_USER_NAME"
  git -C "$repo_dir" config user.email "$GIT_USER_EMAIL"
  git -C "$repo_dir" remote add origin "$BACKUP_REPO"
  git -C "$repo_dir" add -A
  git -C "$repo_dir" commit -m "Automated encrypted openclaw backup $TS" >/dev/null

  log "Force-pushing encrypted backup repo to keep only the latest snapshot"
  GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git -C "$repo_dir" push -f -u origin main >/dev/null

  if [[ "$VERIFY_REMOTE" == "1" ]]; then
    verify_remote_head "$repo_dir" "$BACKUP_REPO"
    log "Encrypted backup remote verified"
  fi

  log "Encrypted backup ready: $archive_size, $part_count parts"
}

main() {
  check_prereqs
  log "Temp build root: $TMP_ROOT"
  log "Workspace repo: $WORKSPACE_REPO"
  log "Backup repo: $BACKUP_REPO"

  if [[ "$RUN_WORKSPACE" == "1" ]]; then
    backup_workspace
  fi
  if [[ "$RUN_BACKUP" == "1" ]]; then
    backup_full_openclaw
  fi

  log "Done"
  notify_success "老爹，GitHub 双备份已完成（$TS）。\n- workspace → mc2\n- 加密 .openclaw → mc1（仅保留最新一版）\n- 加密密码：固定为你设定的那串" || true
}

main "$@"
