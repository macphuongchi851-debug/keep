# Day 12：Browser 浏览器自动化 —— 让它自己去网页上看

## 今天为什么学这个

OpenClaw 不只是会查资料，它还能真的控制浏览器：
- 打开网页
- 抓快照
- 截图
- 点击和输入

这节过后，你会明显感觉它从“会说”进化到“会看、会动”。

## 今天的目标

你需要做到：

1. 理解 `openclaw` / `user` / `chrome-relay`
2. 启动或检查受控浏览器
3. 打开网页并获得 snapshot 或 screenshot
4. 知道为什么默认优先用隔离浏览器

---

## 一、三种 profile 的人话版

### `openclaw`
隔离浏览器，默认最适合自动化。

### `user`
连接你真实浏览器，适合必须复用登录态时。

### `chrome-relay`
显式通过扩展附着当前 tab，更偏手动接管。

---

## 二、先看 profile

```bash
openclaw browser profiles
openclaw browser --browser-profile openclaw status
```

---

## 三、启动并打开网页

```bash
openclaw browser --browser-profile openclaw start
openclaw browser --browser-profile openclaw open https://docs.openclaw.ai
openclaw browser --browser-profile openclaw snapshot
```

如果你愿意，也可以试 screenshot。

---

## 今天的验收标准

你做完后要能告诉我：

1. 你用了哪个 profile
2. 你打开了哪个网页
3. 你拿到了什么结果
4. 为什么默认优先用 `openclaw`

---

## 做完后怎么回我

发我：

1. profile 名
2. 打开的网址
3. 结果类型（snapshot / screenshot / 提取信息）

通过后，Day 13 我们讲自动化。