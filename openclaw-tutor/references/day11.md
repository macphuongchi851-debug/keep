# Day 11：Skills 体系 —— OpenClaw 为什么不是裸模型

## 今天为什么学这个

OpenClaw 的一个关键特点，是它会通过 skill 学会如何更好地使用工具和完成特定任务。

但很多人对 skill 的理解停留在：
- 像插件
- 能装就装
- 装完不管

今天就是把这个脑回路掰正。

## 今天的目标

你需要做到：

1. 理解 skill 本质是什么
2. 知道 skill 从哪些位置加载
3. 会看 skill 是否 eligible
4. 至少看懂一个 skill

---

## 一、skill 是什么

skill 一般是一个目录，最核心的是：

```text
SKILL.md
```

它的作用不是单纯“加按钮”，而是：
- 告诉代理什么时候该使用某种能力
- 告诉代理如何正确使用相关工具
- 说明依赖、环境要求、配置要求

---

## 二、skill 从哪里来

常见来源：
- bundled skills
- `~/.openclaw/skills`
- `<workspace>/skills`

优先级通常是：

```text
workspace/skills > ~/.openclaw/skills > bundled skills
```

---

## 三、检查当前 skill

```bash
openclaw skills list
openclaw skills list --eligible
```

你重点看：
- 有哪些 skill
- 哪些是存在但当前不一定能用
- 哪些是真正 eligible

---

## 四、深入看一个 skill

```bash
openclaw skills info <name>
```

你可以挑一个感兴趣的，比如 weather 或你自己 workspace 里的。

---

## 今天的验收标准

你做完后要能告诉我：

1. 你看到了哪些 skill
2. 哪个是 eligible 的
3. 你重点查看了哪个 skill
4. 它是干什么的

---

## 做完后怎么回我

发我：

1. 你查看的 skill 名
2. 它的用途
3. 它当前是否真的可用

通过后，Day 12 我们进浏览器自动化。