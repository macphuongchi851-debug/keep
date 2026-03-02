# sop-remote.md — 远程三件套（Tailscale + SSH + RDP）SOP

## 目标
- 最稳优先：Tailscale 组网 → SSH 可用 → （可选）RDP 可用。
- 安全优先：尽量只对 Tailscale 网段放行，避免公网暴露。

## Tailscale 常见故障与修法
### 1) `NeedsLogin` / `Logged out`
- 先跑：`sudo tailscale up`
- 如无输出或卡住：
  - 检查是否 sudo 等密码（在可交互终端执行 `sudo -v`）
  - `sudo systemctl restart tailscaled`
  - `sudo tailscale login --force-reauth`

### 2) `controlplane.tailscale.com -> 198.18.*`（Fake-IP 劫持）
症状：注册超时、`context deadline exceeded`。
- 这是 Meta/Clash TUN/Fake-IP 劫持导致。
- 快速修复：临时关闭 Meta/Clash TUN（或断开 Meta 连接）后登录。
- 长期修复：在 Clash/Mihomo 配置加入 fake-ip-filter/bypass：
  - `*.tailscale.com`
  - `controlplane.tailscale.com`
  - `login.tailscale.com`
  - `*.ts.net`

## SSH 开通
Ubuntu：
```bash
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager -l
```
验证监听：`sudo ss -lntp | grep ':22'`

## RDP（xrdp）开通
```bash
sudo apt install -y xrdp xorgxrdp
sudo adduser xrdp ssl-cert
sudo systemctl enable --now xrdp
sudo systemctl restart xrdp
sudo ss -lntp | grep 3389
```

### xrdp 黑屏修复（常见）
- 安装 xorgxrdp（上面已含）。
- 禁用 Wayland：编辑 `/etc/gdm3/custom.conf` 设置 `WaylandEnable=false` 后重启。
- 兜底：安装 XFCE 并在 `~/.xsession` 写 `startxfce4`。

## iPhone 连接 SSH
- Termius + Tailscale。

## Mac 连接 RDP
- 使用 Windows App（微软新客户端），地址填 Tailscale IP。
