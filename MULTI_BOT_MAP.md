# MULTI_BOT_MAP.md

> **用途**：记录当前 workspace 里各个 bot 的目录归属、Git 仓库归属、记忆文件位置，以及后续维护时该怎么判断改动该在哪个仓库提交。
> **什么时候看**：当你准备维护多个 bot、修改记忆文件、提交 Git、排查“为什么这个文件没提交进去”时。

---

## 一、当前 bot / 仓库总览

### 1) 主助手（workspace 根目录）

- 路径：`/home/keep/.openclaw/workspace`
- Git 归属：**独立 Git 仓库（主仓库）**
- 关键文件：
  - `SOUL.md`
  - `MEMORY.md`
  - `AGENTS.md`
  - `USER.md`
  - `IDENTITY.md`
  - `memory/`
  - `shared/`

### 2) business-bot

- 路径：`/home/keep/.openclaw/workspace/business-bot`
- Git 归属：**属于主仓库中的普通子目录**
- 关键文件：
  - `business-bot/SOUL.md`
  - `business-bot/MEMORY.md`
  - `business-bot/AGENTS.md`
  - `business-bot/memory/`

### 3) pfuguo-bot

- 路径：`/home/keep/.openclaw/workspace/pfuguo-bot`
- Git 归属：**独立 Git 仓库**
- 关键文件：
  - `pfuguo-bot/SOUL.md`
  - `pfuguo-bot/MEMORY.md`
  - `pfuguo-bot/AGENTS.md`
  - `pfuguo-bot/memory/`

### 4) quant-bot

- 路径：`/home/keep/.openclaw/workspace/quant-bot`
- Git 归属：**属于主仓库中的普通子目录**
- 关键文件：
  - `quant-bot/SOUL.md`
  - `quant-bot/MEMORY.md`
  - `quant-bot/AGENTS.md`
  - `quant-bot/memory/`

---

## 二、共享层与私有层怎么分

### 共享层（主仓库）

路径：`/home/keep/.openclaw/workspace/shared/`

用于存放：
- 跨 bot 公共记忆：`shared/MEMORY_GLOBAL.md`
- 通用环境 / 排障经验：`shared/environment-global.md`
- 通用术语 / 默认指代：`shared/terminology.md`
- 共享层说明：`shared/README.md`

### 各 bot 私有层

每个 bot 自己保留：
- `SOUL.md`：人格 / 行为风格
- `MEMORY.md`：该 bot 自己的长期记忆
- `memory/YYYY-MM-DD.md`：该 bot 的 daily
- `memory/README.md`：该 bot 的记忆分流说明

---

## 三、提交 Git 时怎么判断走哪个仓库

### 走主仓库提交

如果你改的是这些路径，去主仓库提交：

- `/home/keep/.openclaw/workspace/*`
- `/home/keep/.openclaw/workspace/shared/*`
- `/home/keep/.openclaw/workspace/business-bot/*`
- `/home/keep/.openclaw/workspace/quant-bot/*`

主仓库路径：
`/home/keep/.openclaw/workspace`

### 走 pfuguo-bot 自己的仓库提交

如果你改的是这些路径，必须进它自己的仓库提交：

- `/home/keep/.openclaw/workspace/pfuguo-bot/*`

子仓库路径：
`/home/keep/.openclaw/workspace/pfuguo-bot`

---

## 四、为什么之前会出现“文件明明存在，但主仓库提交不到”

原因通常有两类：

### 1) `.gitignore` 忽略

例如：
- `MEMORY.md`
- `memory/`

这种情况需要：
- 用 `git add -f <file>` 强制加入

### 2) 目录本身就是独立仓库

例如：
- `pfuguo-bot/`

这种情况不能只在主仓库提交，必须进入子仓库单独提交。

---

## 五、当前推荐读取顺序（多 bot 通用）

每个 bot 建议按这个顺序读取上下文：

1. `../shared/MEMORY_GLOBAL.md`
2. `SOUL.md`
3. `USER.md`
4. `MEMORY.md`
5. `memory/YYYY-MM-DD.md`（今天 + 昨天）

一句话理解：

> 先读共享规则，再读自己是谁，再读自己长期记忆，最后读近期过程。

---

## 六、当前记忆文件分布

### 主助手
- `MEMORY.md`
- `memory/README.md`
- `memory/templates.md`
- `memory/project-experience.md`
- `memory/environment-notes.md`
- `memory/rules.md`

### shared
- `shared/MEMORY_GLOBAL.md`
- `shared/environment-global.md`
- `shared/terminology.md`
- `shared/README.md`

### business-bot
- `business-bot/MEMORY.md`
- `business-bot/memory/README.md`

### pfuguo-bot
- `pfuguo-bot/MEMORY.md`
- `pfuguo-bot/memory/README.md`

### quant-bot
- `quant-bot/MEMORY.md`
- `quant-bot/memory/README.md`

---

## 七、最短版记忆

- 主助手：主仓库
- business-bot：跟主仓库走
- quant-bot：跟主仓库走
- pfuguo-bot：独立仓库，单独提交
- 公共规则 / 公共环境 / 公共术语：放 `shared/`
- 人格 / bot 专属长期记忆 / daily：放各自目录
