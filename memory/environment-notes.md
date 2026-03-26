# environment-notes.md

> **用途**：记录环境相关、部署相关、排障相关的可复用结论。
> **什么时候写**：当某个错误、权限问题、代理问题、容器问题已经定位清楚，且以后可能再次遇到时。
> **写什么**：报错场景、优先处理思路、已验证可行的修复方式、关键命令示例。
> **不写什么**：纯用户偏好、项目业务方案、当天无复用价值的临时日志。

## 图片读取

- 处理用户上传图片若遇到权限 / 沙箱报错，可先复制到工作目录再读取。
- 示例：`cp /home/keep/.openclaw/media/inbound/xxx.jpg ~/.openclaw/workspace/temp.jpg`

## Chromium 容器外网访问

- Chromium 容器访问外网报错时，优先补：`HTTP_PROXY`、`HTTPS_PROXY`、`NO_PROXY`
- 启动参数追加：`--proxy-server="http://IP:PORT"`

## 飞牛 OS 容器代理

- 默认代理地址通常是本机 IP（如 `192.168.10.101`）+ Clash 端口（如 `7890`）。
