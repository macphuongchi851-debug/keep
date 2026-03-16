# Day 7：Telegram 接入（上）—— 先把门、钥匙、门禁规则搞明白

## 今天为什么学这个

Telegram 是很多人第一次真正把 OpenClaw 用起来的入口。

但接 Telegram 最容易踩的，不是技术本身，而是这几个问题：
- bot 怎么创建
- token 怎么配
- 谁能给它发消息
- pairing / allowlist / open 到底怎么选

今天先把这些概念和前置准备讲清楚。

## 今天的目标

你需要做到：

1. 创建 Telegram Bot
2. 拿到并保管 bot token
3. 理解 `dmPolicy` 是什么
4. 知道 `allowFrom` 大概是干嘛的

---

## 一、创建 Telegram Bot

去 Telegram 里找：

```text
@BotFather
```

然后：
1. 发 `/newbot`
2. 按步骤设置名称和用户名
3. 拿到 bot token

这个 token 就是钥匙，别乱贴，别截图乱发。

---

## 二、理解 `dmPolicy`

常见选项：
- `pairing`
- `allowlist`
- `open`
- `disabled`

你先记住人话版：

### `pairing`
更安全，默认思路通常更推荐。
陌生人先配对，通过后再聊。

### `allowlist`
只有白名单里的用户能私聊。

### `open`
所有人都能来聊。

### `disabled`
直接不接私聊。

---

## 三、`allowFrom` 是干嘛的

它本质上就是：
**允许哪些用户来触发这个 bot。**

如果你走 `allowlist`，那你就得把允许的人放进去。

别出现这种傻事：
> 门装好了，结果把自己关外面。

---

## 四、今天先不急着全配完，先完成准备工作

今天建议你完成：
- Bot 创建
- Token 安全保存
- 想好你准备用 `pairing` 还是 `allowlist`

---

## 今天的验收标准

你做完后要能告诉我：

1. Bot 是否创建成功
2. 你是否已经拿到 token
3. 你倾向使用 `pairing` 还是 `allowlist`
4. 你为什么这么选

---

## 做完后怎么回我

你直接发：

1. Bot 是否创建好了
2. 你选哪种私聊策略
3. 你的理由

通过后，Day 8 我们再正式接到 OpenClaw 上并验证收发。