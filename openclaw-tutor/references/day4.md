# Day 4：把 OpenClaw 接到 Telegram —— 真正开始远程可用

## 今天为什么学这个

如果 OpenClaw 只能在本机网页里用，那它还只是个“桌面玩具”。

一旦接上 Telegram，你就拥有了：
- 随时随地私聊它
- 不开网页也能下指令
- 真正像“私人助手”一样使用

今天这节就是把它从本地工具，变成你口袋里的东西。

## 今天的目标

你需要做到：

1. 创建 Telegram Bot
2. 配好 OpenClaw 的 Telegram 渠道
3. 知道 `dmPolicy` 是什么
4. 成功在 Telegram 私聊机器人

---

## 一、先创建 Bot

去 Telegram 里找：

```text
@BotFather
```

然后：
1. 发 `/newbot`
2. 按提示设置 bot 名称
3. 拿到 Bot Token

Token 看起来一般像这样：

```text
123456789:ABCxxxxxxxxxxxxxxxxxxxx
```

这玩意儿就是钥匙，别乱贴、别乱发。

---

## 二、配置 Telegram 渠道

官方口径里，Telegram 主要看这些：
- `enabled`
- `botToken`
- `dmPolicy`
- 必要时 `allowFrom`

一个最基础的思路大概是：

```json5
{
  channels: {
    telegram: {
      enabled: true,
      botToken: "你的 token",
      dmPolicy: "pairing"
    }
  }
}
```

### `dmPolicy` 先搞懂

常见值：
- `pairing`：默认更安全，陌生人先走配对
- `allowlist`：只允许白名单用户
- `open`：全开放（通常不建议乱开）
- `disabled`：禁用私聊

如果这号就是你自己用，通常：
- 要么 `pairing`
- 要么 `allowlist`

别一上来就 `open`，那是在邀请陌生人进门喝茶。

---

## 三、启动或重启 Gateway

配置好后，重启让它生效：

```bash
openclaw gateway restart
```

然后看状态：

```bash
openclaw status
```

如果 Telegram 有报错，优先看：
- token 是否正确
- 格式是否写对
- 配置是否通过校验

---

## 四、和 Bot 私聊测试

在 Telegram 里给你的机器人发一条消息：

```text
你好，测试一下。
```

### 如果你用了 `pairing`
可能需要先完成 pairing / approve。

### 如果你用了 `allowlist`
那就要确保你的 Telegram 用户 ID 已经在 `allowFrom` 里。

---

## 五、如何找自己的 Telegram 用户 ID

最稳妥的方式之一：
- 给 bot 发消息
- 然后查看 OpenClaw 日志 / 事件里对应的 `from.id`

有些人会用第三方机器人查 ID，也不是不行，但隐私上没那么优雅。

---

## 六、今天的验收标准

你做完后需要告诉我：

1. Bot 是否创建成功
2. 你用的 `dmPolicy` 是什么
3. Gateway 重启后 Telegram 是否正常
4. 你是否已经能在 Telegram 私聊它

### 合格表现
- 机器人能收到并回复你的消息
- 你知道自己选的访问策略是什么
- 不是“能用但不知道为什么能用”

---

## 常见坑

### 1）token 写错
最常见，尤其复制时带空格、少字符。

### 2）`allowlist` 配了，但没把自己放进去
那你当然聊不到，自己把门焊死了。

### 3）以为 Telegram 也能像某些渠道那样随便登录
不一样。Telegram Bot API 走的是 bot token 配置方式。

### 4）重启后不检查状态
配置能不能生效，不是靠玄学，是靠 `status` 和实际对话验证。

---

## 做完后怎么回我

发我这几样：

1. 你采用的是 `pairing` 还是 `allowlist`
2. 你是否成功给 bot 发消息并收到回复
3. 如果卡住，报错原文是什么

通过后，Day 5 我们开始进 workspace 和文件操作。那时 OpenClaw 才算真正开始替你“干活”。