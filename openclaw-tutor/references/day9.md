# Day 9：Workspace 与文件操作 —— 从会聊天，进化到会干活

## 今天为什么学这个

真正有用的 OpenClaw，不只是会回你消息，而是会：
- 读文件
- 写文件
- 改文件
- 留下可验证结果

今天这节之后，它才开始更像执行型助手，而不是只会嘴上说“好的”。

## 今天的目标

你需要做到：

1. 理解 workspace 是默认工作区
2. 让 OpenClaw 读取一个文件
3. 让 OpenClaw 创建或修改一个文件
4. 学会自己验证结果

---

## 一、先看 workspace

```bash
cd ~/.openclaw/workspace
ls
```

如果想看细一点：

```bash
find ~/.openclaw/workspace -maxdepth 2 -type f | sort
```

你要建立感觉：
- 这里不是杂物堆
- 这里是 OpenClaw 真正做事、记事、留下结果的地方

---

## 二、做一个最小文件实验

你可以让 OpenClaw：

### 方案 A：读文件
```text
读取 USER.md，然后总结里面记录了哪些偏好。
```

### 方案 B：创建文件
```text
在 workspace 里创建一个 test-note.md，写“这是 Day 9 文件测试”。
```

### 方案 C：改文件
```text
把今天开始系统学习文件操作这件事记到今天的 daily memory。
```

---

## 三、别只听它嘴上说完成，要自己查

比如：

```bash
cat ~/.openclaw/workspace/test-note.md
```

或者去看 daily memory 文件。

习惯一定要养成：
**能验证就验证。**

---

## 今天的验收标准

你做完后要能告诉我：

1. 你读了哪个文件
2. 你创建或修改了哪个文件
3. 你是怎么验证成功的
4. 为什么文件结果比聊天里的“已完成”更可信

---

## 做完后怎么回我

直接发：

1. 文件名
2. 操作类型（读/写/改）
3. 你的验证方式

通过后，Day 10 我们进入 memory 系统。