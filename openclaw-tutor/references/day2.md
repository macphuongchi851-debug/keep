# Day 2：模型不是玄学 —— 看懂、列出、切换、验证

## 今天为什么学这个

很多人用 OpenClaw 时最常见的迷惑是：
- 我现在到底在用哪个模型？
- 为什么 `/model` 有时候能切，有时候报错？
- primary、fallback、alias 到底是什么关系？

今天把模型系统讲明白。不然你以后切模型全靠猜，像在开盲盒。

## 今天的目标

你需要做到：

1. 看懂当前默认模型配置
2. 列出本机可用模型
3. 成功切换到另一个模型
4. 验证切换真的生效

---

## 一、先搞懂几个核心概念

### 1. Primary model
默认主模型。正常情况下，OpenClaw 优先用它。

### 2. Fallbacks
备用模型。主模型炸了、超时了、鉴权挂了，才会考虑兜底。

### 3. Alias
模型别名。比如给一个很长的 `provider/model-name` 起个短名，方便切换。

### 4. Model catalog / allowlist
配置里声明过的模型集合。很多环境下，`/model` 能切换的前提，是这个模型本身就在配置允许范围内。

---

## 二、先看当前状态

先执行：

```bash
openclaw models status
```

你重点看：
- 当前默认模型是谁
- 有没有 fallback
- 鉴权状态是不是正常

如果你想看得更细：

```bash
openclaw models status --probe
```

注意：
- `--probe` 会做真实探测
- 可能消耗 token
- 也可能撞到限流

所以别像打地鼠一样疯狂 probe。

---

## 三、列出当前可用模型

执行：

```bash
openclaw models list
```

如果你习惯在聊天里操作，也可以尝试：

```text
/models
```

你现在要做的是：
- 记录下至少 3 个可用模型名
- 看看它们是不是 `provider/model` 格式
- 顺手认一下有没有 alias

---

## 四、切换模型

### 命令行方式

```bash
openclaw models set <model-or-alias>
```

例如：

```bash
openclaw models set openai/gpt-5.2
```

### 聊天方式

在对话里尝试：

```text
/model provider/model-name
```

比如：

```text
/model openai/gpt-5.2
```

### 切换后立刻验证

不要切完就自我感动，马上验证：

```bash
openclaw models status
```

或者直接在对话里问：

```text
你现在用的是什么模型？
```

---

## 五、理解两个常见事实

### 1）不是所有你想切的模型都能切
如果模型没配置、没鉴权、或者不在 catalog 里，切换就可能失败。

### 2）provider/model 格式很重要
OpenClaw 识别模型时，核心格式通常是：

```text
provider/model
```

如果模型 ID 本身还带 `/`，就更别乱省略 provider。

---

## 六、今天的验收标准

你做完后，需要给我这 4 样：

1. `openclaw models status` 的关键结果
2. 至少 3 个你能看到的模型名
3. 你切换到的目标模型名
4. 你如何确认切换生效

### 合格表现
- 能说出当前默认模型是谁
- 能说出 fallback 是干嘛的
- 至少成功切换一次
- 不是靠猜，而是通过 status 或实际对话验证

---

## 常见坑

### 1）`not found`
通常是：
- 模型名写错
- provider 写错
- 该模型没配置

### 2）切了但没感觉
可能是：
- 其实没切成功
- 你只发了 `/model`，没看回执或状态
- UI 里看着像切了，实际 session 没更新

### 3）疯狂 probe
`--probe` 是好东西，但不是机关枪。别一顿乱扫，把自己限流了。

---

## 做完后怎么回我

你直接发：

1. 你看到的 3 个模型
2. 你切换成了哪个
3. `openclaw models status` 的关键结果
4. 你用一句话解释：
   - Primary model 是什么
   - Fallback 是什么

通过后，Day 3 我们开始进配置文件和安全边界。那一节很关键，能少踩很多坑。