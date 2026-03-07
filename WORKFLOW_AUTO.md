# WORKFLOW_AUTO.md

## GitHub 双备份自动化

当前可用脚本：

- `scripts/github-dual-backup.sh`

用途：

1. 把 `~/.openclaw/workspace` 做成**安全瘦身版快照**并推到：
   - `git@github.com:macphuongchi851-debug/mc2.git`
2. 把整个 `~/.openclaw` 做成**AES256 加密整包**并分片推到：
   - `git@github.com:macphuongchi851-debug/mc1.git`

## 日常用法

```bash
cd /home/keep/.openclaw/workspace
./scripts/github-dual-backup.sh
```

## 只跑某一段

只备份 workspace：

```bash
./scripts/github-dual-backup.sh --workspace-only
```

只备份整个加密 `.openclaw`：

```bash
./scripts/github-dual-backup.sh --backup-only
```

## 干跑检查

```bash
./scripts/github-dual-backup.sh --dry-run
```

## 注意事项

- 依赖：`git` `rsync` `tar` `gpg` `split` `ssh`
- 默认 SSH key：`~/.ssh/github_openclaw_backup_ed25519`
- 默认加密密码文件：`~/.ssh/openclaw_backup_passphrase_last.txt`
- 整包备份仓库会使用 **force push**，只保留最新一版，避免仓库无限变胖。
- 如果更换 GitHub 仓库地址，可用环境变量覆盖：

```bash
WORKSPACE_REPO=git@github.com:xxx/yyy.git BACKUP_REPO=git@github.com:xxx/zzz.git ./scripts/github-dual-backup.sh
```
