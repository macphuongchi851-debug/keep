# environment-global.md

> **用途**：沉淀跨 bot 通用的环境、容器、代理、权限、排障经验。
> **什么时候写**：当某个环境问题的修法对多个 bot 都可能复用时。
> **写什么**：通用报错场景、优先排查思路、已验证有效的修法、关键命令。
> **不写什么**：某个 bot 私有项目方案、单次临时过程、只和单一 bot 强绑定的细节。

## 图片读取

- 处理用户上传图片若遇到权限 / 沙箱报错，可先复制到工作目录再读取。
- 示例：`cp /home/keep/.openclaw/media/inbound/xxx.jpg ~/.openclaw/workspace/temp.jpg`

## Chromium 容器外网访问

- Chromium 容器访问外网报错时，优先补：`HTTP_PROXY`、`HTTPS_PROXY`、`NO_PROXY`
- 启动参数追加：`--proxy-server="http://IP:PORT"`

## 飞牛 OS 容器代理

- 默认代理地址通常是本机 IP（如 `192.168.10.101`）+ Clash 端口（如 `7890`）。
