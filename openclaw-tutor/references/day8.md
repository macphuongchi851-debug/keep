# Day 8：Telegram 接入（下）—— 真接上、真发消息、真排故障

## 今天为什么学这个

昨天你已经准备好了 bot、token 和访问策略。

今天开始真接入：
- 把 Telegram 配进 OpenClaw
- 重启 Gateway
- 私聊 bot
- 处理 pairing / allowlist 问题

这节过后，OpenClaw 才算真正从“本机工具”变成“远程可聊”。

## 今天的目标

你需要做到：

1. 完成 Telegram 配置
2. 让 bot 能收到并回复你的私聊
3. 会判断是 token 问题、策略问题，还是 Gateway 问题

---

## 一、把 Telegram 配进去

核心思路大概是：
- `channels.telegram.enabled = true`
- 填好 `botToken`
- 选好 `dmPolicy`
- 如果是 allowlist，配置对应用户 ID

今天重点不是背配置片段，而是理解：
**Token 决定能不能接入，策略决定谁能访问。**

---

## 二、重启并看状态

```bash
openclaw gateway restart
openclaw status
```

你要确认：
- Gateway 已经正常回来
- Telegram 没直接报错

---

## 三、去 Telegram 私聊 bot

发一句最简单的：

```text
你好，测试一下。
```

如果你走的是 `pairing`，可能需要先完成配对批准。

如果你走的是 `allowlist`，要确保你的 Telegram 用户 ID 已经在允许列表里。

---

## 四、最常见的 3 类故障

### 1）token 错了
表现：Telegram 相关直接 unauthorized / 无法连接。

### 2）访问策略挡住了
表现：bot 在，但你发消息没法正常进入对话。

### 3）Gateway 本身没好
表现：系统整体状态就不正常，Telegram 只是陪葬。

---

## 今天的验收标准

你做完后要能告诉我：

1. Telegram 是否接入成功
2. 你是否已经能私聊并收到回复
3. 如果失败，你判断更像是哪一类问题

---

## 做完后怎么回我

直接发：

1. 你是否成功和 bot 私聊
2. 当前策略是 pairing 还是 allowlist
3. 如果失败，错误现象是什么

通过后，Day 9 进入 workspace 与文件操作。