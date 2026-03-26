# environment-notes.md

## 图片读取

- 处理用户上传图片若遇到权限 / 沙箱报错，可先复制到工作目录再读取。
- 示例：`cp /home/keep/.openclaw/media/inbound/xxx.jpg ~/.openclaw/workspace/temp.jpg`

## Chromium 容器外网访问

- Chromium 容器访问外网报错时，优先补：`HTTP_PROXY`、`HTTPS_PROXY`、`NO_PROXY`
- 启动参数追加：`--proxy-server="http://IP:PORT"`

## 飞牛 OS 容器代理

- 默认代理地址通常是本机 IP（如 `192.168.10.101`）+ Clash 端口（如 `7890`）。
