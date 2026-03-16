# Day 7：Browser 浏览器自动化 —— 让它自己去网页上看、点、截

## 今天为什么学这个

能聊天不稀奇，能上网页替你看东西，才开始像回事。

OpenClaw 的 browser 能做的事情包括：
- 打开网页
- 抓页面快照
- 截图
- 点击、输入、导航
- 在隔离浏览器里完成自动化

今天你要从“嘴上会查网页”升级到“真的能控制浏览器”。

## 今天的目标

你需要做到：

1. 理解 `openclaw` / `user` / `chrome-relay` 三种浏览器模式
2. 启动或检查受控浏览器
3. 打开一个页面并抓取结果
4. 理解为什么默认优先用隔离浏览器

---

## 一、先搞懂三种 profile

### 1. `openclaw`
OpenClaw 自己管理的隔离浏览器。

特点：
- 独立 profile
- 不污染你日常浏览器
- 默认最适合自动化

### 2. `user`
连接你真实正在使用的、已登录的 Chrome 会话。

适合：
- 必须复用登录状态
- 必须访问你平时已登录的网站

缺点：
- 需要用户配合
- 风险和干扰更高

### 3. `chrome-relay`
基于扩展/工具栏 attach 的显式接管模式。

适合：
- 你明确要控制当前 tab
- 你希望手动附着某个浏览器页面

---

## 二、先看有哪些 profile

执行：

```bash
openclaw browser profiles
```

如果你要看状态：

```bash
openclaw browser --browser-profile openclaw status
```

---

## 三、启动隔离浏览器

```bash
openclaw browser --browser-profile openclaw start
```

然后打开一个网页：

```bash
openclaw browser --browser-profile openclaw open https://docs.openclaw.ai
```

再抓快照：

```bash
openclaw browser --browser-profile openclaw snapshot
```

你也可以进一步尝试截图：

```bash
openclaw browser --browser-profile openclaw screenshot
```

---

## 四、今天至少完成一个真实浏览动作

建议你做其中一个：

### 任务 A：打开 OpenClaw 官方文档首页并截图
### 任务 B：打开任意网页，抓取 snapshot
### 任务 C：让 OpenClaw 帮你从网页提取一个标题或关键信息

重点不是命令背得多，而是要实际看到：
- 浏览器起来了
- 页面真的开了
- 快照或截图真的拿到了

---

## 五、为什么默认优先用隔离浏览器

因为它：
- 不碰你日常浏览器数据
- 更稳定
- 更容易排障
- 自动化行为可控

一句话：
**默认拿隔离浏览器干活，是因为省心又少作死。**

---

## 六、今天的验收标准

你做完后要给我：

1. 你用的是哪个 browser profile
2. 你打开了哪个网页
3. 你拿到了 snapshot 还是 screenshot
4. 你如何理解 `openclaw` 和 `user` 的区别

---

## 常见坑

### 1）一上来就想接管日常浏览器
没必要。除非必须复用登录态，否则先用 `openclaw`。

### 2）浏览器没启动就直接 snapshot
那当然容易扑街。

### 3）把浏览器自动化理解成“纯搜索”
不是。这里是真的可控页面、可点、可输入。

---

## 做完后怎么回我

发我：

1. 你使用的 profile
2. 你打开的网址
3. 你拿到的结果（snapshot / screenshot / 提取信息）
4. 你自己的理解：为什么默认优先用隔离浏览器

过了 Day 7，你已经不是在“聊天”，而是在指挥一个能上网页干活的系统。