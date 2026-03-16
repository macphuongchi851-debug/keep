# Day 5：配置文件基础 —— 先学会读和校验，别上来就乱改

## 今天为什么学这个

你后面想接 Telegram、调浏览器、改 session、玩自动化，都绕不开配置文件。

但配置这东西最怕两种人：
- 不敢看
- 乱敢改

今天先把基础功打好：找到配置、读取配置、校验配置。

## 今天的目标

你需要做到：

1. 知道当前配置文件是哪一个
2. 会读取配置项
3. 会校验配置是否合法
4. 理解 OpenClaw 配置为什么是严格校验的

---

## 一、先找配置文件

```bash
openclaw config file
```

确认当前生效配置到底在哪。

别拍脑袋。很多人改半天，结果改的不是当前生效那份。

---

## 二、读取几个关键配置项

```bash
openclaw config get agents.defaults.workspace
openclaw config get session.dmScope
openclaw config get browser.defaultProfile
```

有些路径没配是正常的，重点是学会：
- 路径怎么写
- 配置是怎么分层组织的

---

## 三、校验配置

```bash
openclaw config validate
```

如果你想看结构化结果：

```bash
openclaw config validate --json
```

今天你必须理解一个事实：
**OpenClaw 配置不是“差不多就行”，而是严格校验。**

---

## 四、为什么严格校验反而是好事

因为它能避免：
- 字段拼错但你没发现
- 类型错了系统默默忽略
- 表面启动了，实际上半残

虽然严格校验有时挺烦，但比“静默坏掉”强多了。

---

## 今天的验收标准

你做完后要能告诉我：

1. 当前配置文件路径
2. `agents.defaults.workspace` 的值
3. `session.dmScope` 有没有设置
4. `config validate` 是否通过
5. 为什么严格校验是有价值的

---

## 做完后怎么回我

把这几样发我：

1. `openclaw config file` 结果
2. `openclaw config validate` 结果
3. 你自己的理解：为什么配置不能乱搞

通过后，Day 6 我们讲配置安全和会话边界。