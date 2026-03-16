# Day 1：先把脑子装对 —— Gateway、Control UI、Workspace 到底是什么

## 今天为什么学这个

很多人一上来就想接 Telegram、装技能、跑自动化，结果越玩越乱。

OpenClaw 最容易把人绕晕的，不是命令，而是**架构关系**没搞懂：
- Gateway 是谁
- Control UI 是谁
- Workspace 又是个什么鬼
- 为什么你改了文件，它会“记得”

今天不追求花活，先把骨架搭正。骨架歪了，后面全是邪修。

## 今天的目标

你需要做到 3 件事：

1. 能说清 **Gateway / Control UI / Workspace** 各自职责
2. 知道 OpenClaw 当前是否正常运行
3. 能打开 Control UI 并完成一次对话

---

## 一、先建立正确心智模型

### 1. Gateway

Gateway 是 **常驻后台服务 / 守护进程**。

它负责：
- 持有渠道连接（Telegram、Discord、Slack 等）
- 维护 session 状态
- 暴露 WebSocket / HTTP 控制入口
- 驱动工具、定时任务、节点、浏览器等能力

你可以把它理解成：**OpenClaw 的中枢神经**。

### 2. Control UI

Control UI 是 **网页控制台**。

它不是 OpenClaw 本体，只是连接 Gateway 的一个前端界面，用来：
- 发消息
- 看状态
- 看配置
- 调试和观察系统

你可以把它理解成：**操作台**。

### 3. Workspace

Workspace 是代理的“家目录 / 工作区”。

里面通常有：
- `AGENTS.md`
- `SOUL.md`
- `USER.md`
- `MEMORY.md`
- `memory/YYYY-MM-DD.md`
- `skills/`

重点：
- **文件才是记忆载体**
- OpenClaw 不是凭空“永久记住”，而是靠写进 workspace 里的 Markdown 文件

你可以把它理解成：**可读写的大脑外置硬盘**。

---

## 二、动手：检查系统状态

先在终端执行：

```bash
openclaw status
```

你重点看这些：
- Gateway 是否在运行
- 是否有可用 agent
- 当前 workspace 指向哪里
- 有没有明显报错

如果 Gateway 没起来，再试：

```bash
openclaw gateway start
```

然后重新执行：

```bash
openclaw status
```

### 你现在应该观察到什么

至少要确认：
- 状态命令能正常返回
- Gateway 不是挂的
- 没有直接爆红错误

---

## 三、打开 Control UI

通常浏览器里打开：

```text
http://127.0.0.1:18789
```

如果你的环境改过端口，就以 `openclaw status` 里显示的地址为准。

如果要求 token，再看你自己的 gateway 配置或状态提示。

### 试着发第一句话

在 Control UI 里发：

```text
你好，我在学习 OpenClaw。请用一句话告诉我你是谁。
```

你不需要追求回答多惊艳，今天重点只是确认：
- 页面能打开
- 能发消息
- 能收到响应

---

## 四、顺手认一下 workspace

看看当前 workspace 里都有什么：

```bash
cd ~/.openclaw/workspace
ls
```

如果想看得更清楚：

```bash
find ~/.openclaw/workspace -maxdepth 2 -type f | sort
```

你至少应该认出：
- 哪些是人格/用户设定文件
- 哪些是 memory 文件
- 哪些是 skill 或项目文件

---

## 五、今天的验收标准

你做完后，至少要能回答下面 3 题：

### 验收题 1
**Gateway 是什么？**

合格答案要点：
- 后台服务 / 守护进程
- 持有渠道连接与会话状态
- 提供控制与调度能力

### 验收题 2
**Control UI 是什么？**

合格答案要点：
- 网页控制台
- 用来和 Gateway 交互
- 不是系统本体，只是操作界面

### 验收题 3
**Workspace 为什么重要？**

合格答案要点：
- 是代理工作的默认目录
- 记忆和规则主要以文件形式存在
- 代理能否持续“记住”信息，依赖这里的文件

---

## 常见坑

### 1）把 UI 当成本体
错。UI 只是壳，Gateway 才是中枢。

### 2）以为“记忆”是玄学
错。长期记忆本质上是 workspace 里的文件。

### 3）状态不看就直接折腾配置
这很容易把自己玩炸。先 `openclaw status`，再动手。

---

## 做完后怎么回我

直接把这 3 样发给我：

1. `openclaw status` 的关键结果（不用全贴，挑重点）
2. 你是否成功打开了 Control UI
3. 你用自己的话解释：
   - Gateway 是什么
   - Control UI 是什么
   - Workspace 是什么

你发来后，我给你验收。通过了再进 Day 2。