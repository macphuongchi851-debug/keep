# Day 3：配置文件不是许愿池 —— 会看、会改、会校验，别把自己配炸

## 今天为什么学这个

OpenClaw 很强，但强的代价就是：**配置项不少**。

你后面不管接 Telegram、调模型、开浏览器、改 session 策略，都绕不开配置文件。

如果你不会看配置、不会校验配置、也不知道哪些地方最容易出事，那你后面基本就是：
> 改一下，炸一次；再改一下，再炸一次。

今天先把配置系统的基本功练扎实。

## 今天的目标

你需要做到：

1. 知道配置文件在哪
2. 会用命令读取配置项
3. 会校验配置是否合法
4. 理解“严格校验”意味着什么
5. 知道哪些改动是高风险区

---

## 一、配置文件在哪里

OpenClaw 默认配置文件通常是：

```text
~/.openclaw/openclaw.json
```

先执行：

```bash
openclaw config file
```

确认当前生效的是哪一个文件。

别想当然。很多人切过 profile、换过路径，结果改了半天改到空气里。

---

## 二、先读，不要一上来就改

先读几个关键配置项：

```bash
openclaw config get agents.defaults.workspace
openclaw config get session.dmScope
openclaw config get browser.defaultProfile
```

如果某个路径没配，返回空也正常。

今天重点不是堆配置，而是熟悉：
- path 怎么写
- 哪些配置属于 agent
- 哪些属于 session
- 哪些属于 browser / channel

---

## 三、校验配置是否合法

执行：

```bash
openclaw config validate
```

如果你想看结构化结果：

```bash
openclaw config validate --json
```

### 你要理解一个关键事实

OpenClaw 配置是**严格校验**的：
- 未知字段不认
- 类型不对不认
- 值不合法不认
- 配炸了，Gateway 可能直接拒绝启动

这事儿很烦，但也很对。因为它能避免“看似启动了，其实一堆配置 silently broken”的恶心情况。

---

## 四、认识几个你马上就会碰到的配置区块

### 1. `agents.defaults.*`
定义默认 agent 行为，比如：
- workspace
- 默认模型
- heartbeat
- sandbox

### 2. `session.*`
定义会话怎么隔离、怎么维护、怎么 reset。

特别是：
- `dmScope`

如果是多用户 DM 场景，`dmScope` 配不好，可能会串上下文，隐私直接起飞。

### 3. `channels.*`
每个渠道一套配置：
- Telegram
- Discord
- Slack
- WhatsApp
……

### 4. `browser.*`
浏览器控制相关：
- 是否启用
- 默认 profile
- executablePath
- profiles

---

## 五、今天只做“低风险观察”，不做乱改

今天建议你只做下面这两个安全动作：

### 动作 1：读取配置
```bash
openclaw config get agents.defaults.workspace
openclaw config get session.dmScope
openclaw config get channels.telegram
```

### 动作 2：校验配置
```bash
openclaw config validate
```

如果你非常想试一次 set，也可以只改一个**低风险、你看得懂的字段**，比如一个无关紧要的值，然后再改回去。

但如果你不熟，就先别手贱。

---

## 六、今天的验收标准

你做完后要能告诉我：

1. 当前配置文件路径
2. `agents.defaults.workspace` 的值
3. `session.dmScope` 有没有配
4. `openclaw config validate` 是否通过
5. 你自己的理解：为什么 OpenClaw 要严格校验配置

---

## 常见坑

### 1）直接手改 JSON/JSON5，结果括号逗号写炸
很常见。改完一定校验。

### 2）改了错文件
所以第一步先 `openclaw config file`。

### 3）看不懂路径就乱 set
路径写错、数组位置写错、字段名拼错，都可能直接把配置整报废。

### 4）在多用户环境里忽视 `session.dmScope`
这不是小问题，是隐私边界问题。

---

## 做完后怎么回我

把这几样发我：

1. `openclaw config file` 结果
2. `openclaw config get agents.defaults.workspace` 结果
3. `openclaw config validate` 结果
4. 你用一句话解释：
   - 为什么配置不能乱改
   - `dmScope` 为什么值得重视

过了 Day 3，后面接 Telegram 时你就不会一边配置一边骂街。