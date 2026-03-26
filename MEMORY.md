# MEMORY.md

用于长期记忆（精炼版）。只保留稳定偏好、长期规则、可复用结论。

## 用户偏好 / 约定

- 用户偏好中文沟通；默认回复短、直击要害、少废话。
- 用户提到“PW爬虫”时，默认指 `Playwright Scraper Skill`。

## 工作规则 / 执行纪律

- 去做事时必须及时反馈：开工先报预计耗时；超过 60 秒主动同步；有阶段性结果先报；卡点 / 报错 / 换方案立刻说明；用户一催先回进展再继续。
- 接到任务后不能假死、空转装忙；必须真的开始执行。不管是否做成，都要先给出真实进展、结果或卡点，再继续找解决方案。
- `openclaw-tutor` 每日课程默认发完整版讲义，至少包含：学什么、为什么、具体步骤、示例 / 操作思路、验收标准、常见坑、做完后怎么回报；不能只发摘要提纲。

## 项目经验 / 可复用结论

- A8Ads：网站为 `https://www.a8ads.com/`。用户提到“A8Ads 那套 / 剪映方案 / 口播方案”时，默认指这次沉淀的 42 秒横版宣传片方案：结构「首页 → Ads → Advertisers → Products → 首页收尾」，主打“洞察竞对广告，发掘全球爆款产品”，第一版不放套餐页；已有可直接执行素材：剪映一步步执行稿、42 秒时间轴清单、AI 口播逐句复制版；默认优先推荐商务稳重男声 / 专业解说男声，其次知性专业女声。
- gstack 不是单独一个 skill，而是一套工作流包装器家族。用户提到“gstack skill / gstack 那套”时，默认按任务类型匹配：`review`、`investigate`、`qa` / `qa-only`、`ship`、`browse`、`office-hours`，以及 `plan-eng-review`、`design-review`、`canary`、`land-and-deploy` 等。
- 处理用户上传图片若遇到权限 / 沙箱报错，可先复制到工作目录再读取，例如 `cp /home/keep/.openclaw/media/inbound/xxx.jpg ~/.openclaw/workspace/temp.jpg`。
- Chromium 容器访问外网报错时，优先补 `HTTP_PROXY`、`HTTPS_PROXY`、`NO_PROXY`，并在启动参数追加 `--proxy-server="http://IP:PORT"`。
- 飞牛 OS 容器代理地址默认是本机 IP（如 192.168.10.101）+ Clash 端口（如 7890）。
