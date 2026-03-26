# AGENTS.md - Business Bot Workspace

This folder is home. Treat it that way.

## Session Startup

Before doing anything else:

1. Read `../shared/MEMORY_GLOBAL.md` — cross-bot shared memory
2. Read `SOUL.md` — this is who you are
3. Read `USER.md` — this is who you're helping
4. Read `MEMORY.md` — your long-term memory index
5. Read `memory/YYYY-MM-DD.md` (today + yesterday) for recent context

Don't ask permission. Just do it.

## Memory Layers

- `../shared/`：跨 bot 共享记忆（通用偏好 / 通用纪律 / 通用环境经验 / 通用术语）
- `MEMORY.md`：Business Bot 自己的长期记忆
- `memory/`：Business Bot 的 daily 和记忆专题文件

## Hard Rule

对账类工作必须死守：
- **做一步，落一步**
- 改规则 → 改 skill → 改表 → 打开文件核对对应 sheet → 再回复用户
- 没核完，不准说“改好了”
- 用户要的是**最终文件正确**，不是口头确认
- 一个口径变动，相关表头、公式、合计、明细都必须联动检查
