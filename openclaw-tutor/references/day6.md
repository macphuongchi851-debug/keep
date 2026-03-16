# Day 6：Skills 不是插件收藏癖 —— 学会判断、检查、使用

## 今天为什么学这个

OpenClaw 的一个核心特色，是它会根据 skill 学会怎么做具体事情。

但很多人一提 skill，就只会两件事：
- 乱装
- 装完也不知道有没有生效

今天这节就是把这个问题狠狠干掉。

## 今天的目标

你需要做到：

1. 理解 skill 是什么
2. 知道 skill 从哪些位置加载
3. 会检查 skill 是否可用
4. 至少确认一个 skill 的信息或实际使用一次

---

## 一、skill 到底是什么

skill 本质上是一个目录，里面最核心的是：

```text
SKILL.md
```

它不是简单“插件开关”，而是：
- 告诉代理这个能力什么时候该用
- 告诉代理怎么使用相关工具
- 可能附带依赖要求、环境要求、配置要求

你可以把它理解成：
**给代理安装了一块“专项经验包”**。

---

## 二、skill 从哪里来

官方文档里，skill 常见加载来源有三层：

1. bundled skills（随 OpenClaw 自带）
2. `~/.openclaw/skills`
3. `<workspace>/skills`

优先级通常是：

```text
workspace/skills > ~/.openclaw/skills > bundled skills
```

也就是说：
- 你工作区里的 skill，优先级最高
- 本地共享 skill 次之
- 系统自带 skill 最后

---

## 三、检查当前 skill

先执行：

```bash
openclaw skills list
```

如果你想看“当前环境真的可用”的：

```bash
openclaw skills list --eligible
```

你现在要做的是：
- 看看有哪些 skill
- 看看哪些只是存在，哪些是真正 eligible

---

## 四、深入看一个 skill

挑一个你感兴趣的 skill：

```bash
openclaw skills info <name>
```

例如：
- weather
- healthcheck
- 你 workspace 里的自定义 skill

你要观察：
- 它是做什么的
- 是否有依赖要求
- 为什么它能用/不能用

---

## 五、今天至少做一个实际动作

你有两个选择：

### 方案 A：实际调用一个现成 skill
比如天气类 skill，如果你环境里可用，就直接用一次。

### 方案 B：至少确认一个 skill 的信息完整链路
比如：
- `openclaw skills list`
- `openclaw skills info weather`
- 说清楚它负责什么

---

## 六、今天的验收标准

你做完后要能告诉我：

1. 你当前看到了哪些 skill
2. 哪个 skill 是 eligible 的
3. 你重点查看了哪个 skill
4. 这个 skill 解决什么问题
5. skill 和普通聊天指令的区别是什么

---

## 常见坑

### 1）能看到 skill 就以为能用
不一定。依赖、环境变量、配置要求都可能卡你。

### 2）一股脑装很多第三方 skill
先看再装。第三方 skill 本质上要当不受信任内容看待。

### 3）不知道优先级
结果系统 skill 被 workspace 同名 skill 覆盖了，自己还一脸懵。

---

## 做完后怎么回我

给我发：

1. `openclaw skills list` 里你最关注的几个
2. 你查看的那个 skill 名称
3. 它的用途
4. 它当前是否真的可用

通过后，Day 7 我们进浏览器自动化。那节会开始明显爽起来。