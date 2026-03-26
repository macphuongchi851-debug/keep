# shared/README.md

> **用途**：说明 shared 目录的定位，以及哪些内容该共享、哪些内容必须留在 bot 私有目录。

## shared 目录是干嘛的

shared 用来放 **跨 bot 都可能复用** 的信息。

适合共享的内容：
- 用户通用偏好
- 通用执行纪律
- 通用环境 / 排障经验
- 通用术语 / 简称

不适合共享的内容：
- 某个 bot 的 `SOUL.md`
- 某个 bot 的 `MEMORY.md` 细节
- 某个 bot 的 `memory/YYYY-MM-DD.md`
- 某个 bot 的项目打法 / 私有业务经验
- 某个 bot 的专属沟通风格

## 当前 shared 文件

- `shared/MEMORY_GLOBAL.md`：跨 bot 公共记忆总索引
- `shared/environment-global.md`：通用环境 / 排障经验
- `shared/terminology.md`：通用术语 / 默认指代

## 一句话原则

> 能被多个 bot 反复复用，才值得共享；否则留在各自目录，别串味。
