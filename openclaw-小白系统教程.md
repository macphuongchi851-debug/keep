# OpenClaw 小白上手教程（最终版｜可直接发给新人）

> 面向：第一次接触 OpenClaw、希望“尽快跑起来 + 能用就行”的人。
>
> 你将得到：
> - **最短上手路径（10 分钟）**：先用 Control UI 在浏览器里聊天
> - **接入 Telegram**：私聊可用、群聊不踩坑
> - **模型配置**：能跑、能切、授权不丢
> - **Skills**：缺了怎么补
> - **安全**：新手默认就应该怎么配
> - **排错**：遇到不回/连不上/权限被拦的“救命梯子”
>
> 安全声明：本文**不包含任何真实 token/key/chat_id/手机号/密码**，只用 `<PLACEHOLDER>` 占位。请自行替换；不要把真实密钥发到群里、工单或截图里。

适用版本：请以你机器上的 `openclaw --version` 和各命令的 `--help` 为准（不同版本参数可能略有差异）。

---

## 目录

1. 学习方式（每天 30 分钟，10 天上手）
2. 最短上手路径（10 分钟跑起来）
3. 模型（Models）：查看 / 授权 / 切换
4. Telegram：私聊（DM）/ 群聊（Group）
5. Skills：缺失 / 检查 / 修复
6. 安全：新手默认安全配置
7. 排错：2 分钟“救命梯子” + 常见报错
8. 定时：cron vs heartbeat（够用版）
9. 附录：常用命令速查

---

## 1) 学习方式（每天 30 分钟，10 天上手）

你是代码小白没关系，按这个节奏来就行：**每天 30 分钟，只学一个点**，每次都要有“可验证的成果”。

### 1.1 每次 30 分钟的固定节奏（照抄就行）

- **0–5 分钟**：复习（我会问你 1 个问题，确认你理解了）
- **5–20 分钟**：今天的新内容（最多 3 步操作）
- **20–30 分钟**：小练习 + 验收（你把输出贴我，我告诉你对不对）

> 你只要记住一句话：**先能用，再懂原理；先跑通，再优化。**

### 1.2 10 天学习计划（每天 30 分钟）

**Day 1：能打开就算赢**
- 目标：能打开 Control UI，并能在网页里和 OpenClaw 对话。
- 验收：你能说清楚“Gateway 是后台服务，Control UI 是网页控制台”。

**Day 2：会自救（status/logs/doctor）**
- 目标：遇到不回/连不上，你知道先看哪 3 个命令。
- 验收：你能跑并看懂：`openclaw status`、`openclaw gateway status`、`openclaw logs --follow`。

**Day 3：会切模型**
- 目标：能把默认模型切到指定模型，并确认真的生效。
- 验收：`openclaw models set ...` 后，你能用 `openclaw models status` 看见已切换。

**Day 4：Telegram 私聊跑通**
- 目标：你在 Telegram 私聊 bot，它能稳定回复。
- 验收：你理解 pairing/allowlist 的作用（不是玄学，是安全门禁）。

**Day 5：安全第一课（不把自己暴露出去）**
- 目标：知道哪些配置最危险，哪些是推荐默认。
- 验收：你能跑 `openclaw security audit --deep` 并能解释至少 2 条 WARN。

**Day 6：Skills 能用（missing → ready）**
- 目标：理解 skills 为什么 missing，怎么让它 ready。
- 验收：让至少 1 个你想用的 skill 变成 ready（通常是装一个 CLI 依赖）。

**Day 7：定时提醒（cron）**
- 目标：创建一个“30 分钟后提醒我”的任务，并能看到它执行记录。
- 验收：你会用 `openclaw cron list` 和 `openclaw cron runs`。

**Day 8：常见故障演练（故意弄坏再修好）**
- 目标：你能在 5 分钟内定位并解决：token mismatch / 模型 401 / Telegram 不回。
- 验收：你能按“救命梯子”跑完并指出是哪一步出问题。

**Day 9：备份与回滚（不怕改崩）**
- 目标：改配置前备份、改完校验、出错回滚。
- 验收：你能把配置回滚到上一版并让 gateway 正常跑起来。

**Day 10：形成你的工作流**
- 目标：把你最常用的 3 个动作固化成清单（比如：看状态、切模型、定时提醒）。
- 验收：你有一张“我自己的 OpenClaw 操作卡片”。

### 1.3 你怎么开始学（最省事）

你以后只要跟我说：
- “开始 Day N（30 分钟）”
- 或“今天只有 15 分钟，压缩版”

我就按上面的节奏带你走：目标 → 操作 → 验收 → 小测。

---

## 2) 最短上手路径（10 分钟跑起来）

目标：**先不接任何聊天渠道**，直接在浏览器 Control UI 里跟 OpenClaw 对话。

### 1.1 一键向导（推荐）

（建议装成后台服务，省心稳定）

```bash
openclaw onboard --install-daemon
```

如果你只是想先试运行一遍：

```bash
openclaw onboard --no-install-daemon
```

### 1.2 做一次健康检查（强烈推荐）

```bash
openclaw doctor
```

### 1.3 确认网关在跑

```bash
openclaw gateway status
openclaw status
```

### 1.4 打开 Control UI（控制台）

```bash
openclaw dashboard
```

通常会打开（或打印）类似地址：
- `http://127.0.0.1:18789/`

能打开页面并聊天 = **基础可用**。

---

## 2) 模型（Models）：查看 / 授权 / 切换

### 2.1 看当前模型状态

```bash
openclaw models status
```

（可选）做一次更严格检查：

```bash
openclaw models status --check
```

### 2.2 授权（当提示 missing key / expired）

优先用 OpenClaw 的授权命令（比你在终端 `export` 更稳，尤其是后台服务场景）：

```bash
openclaw models auth add
```

> 重要：后台服务（systemd/launchd）通常**不会读取你的 shell 环境变量**。
> 你在终端里 `export XXX_API_KEY=...` 能用，不代表服务里也能用。

### 2.3 列出与切换默认模型

```bash
openclaw models list
openclaw models set <provider/model-or-alias>
```

示例（仅示意，按你实际可用 provider 来）：

```bash
openclaw models set openai-gpt/gpt-5.2
```

---

## 3) Telegram：私聊（DM）/ 群聊（Group）

### 3.1 添加 Telegram Bot（最小步骤）

1) 在 Telegram 搜索 **@BotFather**
2) `/newbot` 创建 bot
3) 拿到 bot token（形如 `123456:ABC...`）

配置到 OpenClaw：

```bash
openclaw channels add --channel telegram --token "<TELEGRAM_BOT_TOKEN>"
openclaw gateway restart
openclaw channels status --probe
```

### 3.2 首次私聊需要配对（pairing）

给 bot 发一条私聊消息后，在网关机器上执行：

```bash
openclaw pairing list telegram
openclaw pairing approve telegram <PAIR_CODE>
```

> 配对是为了安全：你明确批准谁可以私聊你的 bot。

### 3.3 群聊最容易踩的 3 个坑（按这个顺序排）

#### 坑 1：你一旦配置了 `channels.telegram.groups`，它就变成“允许列表”

如果你只写了某个群，其他群都会被拒绝。

#### 坑 2：默认 `groupPolicy` 可能是 allowlist（只有允许的人能触发）

想最保守（推荐）：只允许你触发 + 默认需要 @

```json5
{
  channels: {
    telegram: {
      groupPolicy: "allowlist",
      groupAllowFrom: ["<YOUR_TELEGRAM_USER_ID>"],
      groups: {
        "<TELEGRAM_GROUP_CHAT_ID>": { requireMention: true }
      }
    }
  }
}
```

#### 坑 3：不 @ 也想回复？还得改 Telegram 的隐私模式

当你把 `requireMention: false` 时：
- 需要在 BotFather `/setprivacy` 关闭隐私模式，或把 bot 设成群管理员
- 改完后把 bot **移出群再加回来**（Telegram 才会应用新设置）

### 3.4 安全获取 user_id / chat_id（不要乱用第三方 bot）

优先用日志或 directory（取决于渠道能力）：

```bash
openclaw logs --follow
openclaw directory self --channel telegram
openclaw directory groups list --channel telegram
```

> 提醒：把日志/截图发给别人之前，先人工检查是否包含敏感信息。

---

## 4) Skills：缺失 / 检查 / 修复

你会遇到的典型情况：某些工具调用失败、提示缺依赖/缺权限。

### 4.1 列出并检查 skills

```bash
openclaw skills list
openclaw skills check
openclaw skills check -v
```

### 4.2 最省事修法

```bash
openclaw doctor
```

> `doctor` 往往能直接指出“缺什么依赖/权限/配置”。

---

## 5) 安全：新手默认安全配置（建议照抄）

### 5.1 网关不要裸奔

- 推荐保持：`gateway.bind = "loopback"`（只监听本机）
- 需要远程访问 UI：优先 **Tailscale Serve / VPN / SSH 隧道**
- 不建议直接把 Control UI 暴露到公网

### 5.2 DM 默认用 pairing

- Telegram：`dmPolicy: "pairing"`
- WhatsApp（如果用）：`dmPolicy: "allowlist"` 或 `pairing`

### 5.3 群聊默认 requireMention + allowlist

- 降低误触发、降低信息泄露概率

### 5.4 一键安全审计（推荐定期跑）

```bash
openclaw security audit
openclaw security audit --deep
```

想让它做“安全且可预期的自动修复”：

```bash
openclaw security audit --fix
```

> `--fix` 通常做权限收紧/日志脱敏等；**不会**替你轮换 token/key。

---

## 6) 排错：2 分钟“救命梯子”（通用顺序）

遇到“没回复 / UI 打不开 / 渠道不通 / 任务不跑”，先别猜，按顺序跑：

```bash
openclaw status
openclaw status --all
openclaw gateway probe
openclaw gateway status
openclaw doctor
openclaw channels status --probe
openclaw channels logs --channel all --lines 500
openclaw logs --follow
```

你要重点看：
- `gateway status`：服务是否 running；probe 是否 ok；是否提示 unauthorized
- `channels status --probe`：Telegram 是否 connected/ready
- 日志关键词：`unauthorized`、`token mismatch`、`pairing required`、`mention required`、`allowlist blocked`、`EADDRINUSE`

### 6.1 常见报错：`unauthorized` / `gateway token mismatch`

本质：CLI（或某些工具）用的鉴权和网关实际使用的不一致。

处理建议：

```bash
openclaw gateway status --no-probe
openclaw gateway status
openclaw gateway probe
```

如果你显式传了 `--url ws://...`，通常也需要同时显式传 `--token` 或 `--password`（否则可能连不上）。

### 6.2 Control UI 报：`disconnected (1008): pairing required`

含义：新浏览器/新设备连接 UI，需要设备配对审批。

```bash
openclaw devices list
openclaw devices approve
```

---

## 7) 定时：cron vs heartbeat（够用版）

### 7.1 关键概念（只记这两句）

- **cron**：到点触发（网关停了就不跑）
- **heartbeat**：定期“巡逻”，在 main session 执行队列里的系统事件

### 7.2 20 分钟后提醒一次（main session）

```bash
openclaw cron add \
  --name "Reminder" \
  --at "20m" \
  --session main \
  --system-event "提醒：20 分钟后检查一下 OpenClaw。" \
  --wake now
```

### 7.3 排错：cron 不跑先看这几个

```bash
openclaw cron status
openclaw cron list --all
openclaw system heartbeat last
openclaw logs --follow
```

---

## 8) 附录：常用命令速查（收藏）

### 8.1 网关服务

```bash
openclaw gateway install
openclaw gateway start
openclaw gateway restart
openclaw gateway status
openclaw gateway stop
```

### 8.2 渠道

```bash
openclaw channels list
openclaw channels status --probe
openclaw channels logs --channel all --lines 200
```

### 8.3 文档（在线/离线）

- 在线：<https://docs.openclaw.ai>
- 本机：`~/.npm-global/lib/node_modules/openclaw/docs`

用内置 docs 搜索：

```bash
openclaw docs cron
openclaw docs telegram
openclaw docs troubleshooting
```
