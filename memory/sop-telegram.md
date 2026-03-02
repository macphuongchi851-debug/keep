# sop-telegram.md — Telegram 不回/断连排查 SOP

## 常见根因（按概率）
1) 直连被墙/超时：`curl -I https://api.telegram.org/` 超时。
2) 依赖本地代理（如 Mihomo 7897）但代理端口未监听。
3) bot token 冲突：同一个 token 被多个程序轮询（会出现 409 冲突）。

## 10 秒自检
```bash
curl -I --max-time 6 https://api.telegram.org/ || echo direct_fail
ss -lntp | grep ':7897' || echo proxy_down
```

## OpenClaw 场景：代理断导致 Telegram 失联
现象：OpenClaw 配置了 `channels.telegram.proxy=http://127.0.0.1:7897`，但 7897 不通。
- 结论：不是 bot 坏，是 mihomo/clash core 没起来。
- 修复：先恢复 core（确保 7897 LISTEN），再重启 OpenClaw gateway。

## Clash/Mihomo 长期稳定建议
- Telegram 相关域名走代理：
  - `DOMAIN-SUFFIX,telegram.org,PROXY`
  - `DOMAIN-SUFFIX,t.me,PROXY`
  - `DOMAIN,api.telegram.org,PROXY`
- 若启用 Fake-IP/TUN：把 `api.telegram.org`、`*.telegram.org` 加入 fake-ip-filter。

## 记一次真实事故（2026-03-03）
- Telegram 不能用时：直连 api.telegram.org 超时；同时 127.0.0.1:7897 不可达。
- 原因：本机代理 core 未启动/端口未监听。
