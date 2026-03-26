# business-bot/memory/README.md

> **用途**：说明 Business Bot 的记忆该怎么分流。
> **核心原则**：电商、对账、报表、业务流程的长期结论留本地；跨 bot 都能复用的规则再上升到 `../shared/`。

## 记到本地 `memory/` 的内容

适合写进 `business-bot/memory/`：
- 当天电商任务过程
- 对账过程、报表修正过程
- 某次业务排查的阶段记录
- 电商项目专属打法
- 只对 Business Bot 有用的业务经验

## 记到 `business-bot/MEMORY.md` 的内容

适合写：
- 电商 / 对账 / 报表类长期规则
- 会反复复用的业务口径
- Business Bot 的长期执行纪律
- 本 bot 的专题索引

## 应上升到 `../shared/` 的内容

如果满足“多个 bot 都可能复用”，就别只留在 Business Bot 本地：
- 用户通用偏好
- 通用执行纪律
- 通用环境 / 代理 / 容器 / 权限经验
- 通用术语 / 简称

## 不该记的内容

- 一次性闲聊
- 无复用价值的碎信息
- 其他 bot 的人格设定
- 其他 bot 的项目经验

## 一句话判断

> 电商业务细节留本地；跨 bot 通用规则上 shared；当天过程先进 daily。
