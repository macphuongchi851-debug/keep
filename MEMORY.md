# MEMORY.md

- 用于长期记忆（精炼版）。
- A8Ads 相关长期记忆：网站为 `https://www.a8ads.com/`；后续用户若直接提“A8Ads 那套/剪映方案/口播方案”，默认接这次沉淀的 42 秒横版宣传片方案：结构为「首页 → Ads → Advertisers → Products → 首页收尾」，主打“洞察竞对广告，发掘全球爆款产品”，不把套餐页放进第一版主宣传片。已整理过可直接执行的内容：剪映一步步执行稿、42 秒时间轴清单、AI 口播逐句复制版；默认推荐 AI 配音方向为商务稳重男声/专业解说男声，其次知性专业女声。
- 用户约定简称：以后提到“PW爬虫”，默认指 `Playwright Scraper Skill`。
- 处理用户上传的图片（inbound media）若遇到权限/沙箱报错，可尝试将其 cp（复制）到工作目录再读取，例如 `cp /home/keep/.openclaw/media/inbound/xxx.jpg ~/.openclaw/workspace/temp.jpg`。
- 处理 Chromium 容器访问外网报错，优先建议在容器环境变量中添加 `HTTP_PROXY`、`HTTPS_PROXY` 和 `NO_PROXY`，并在启动参数（Command）中追加 `--proxy-server="http://IP:PORT"`。
- 飞牛 OS 容器代理地址默认为本机 IP（如 192.168.10.101）及 Clash 端口（如 7890）。
- 用户新增长期纪律要求（2026-03-18，2026-03-26 补强）：凡是去做事，必须及时汇报、阶段性汇报，不能长时间闷头不反馈。默认规则：开工先报预计耗时；超过 60 秒主动同步；有阶段性结果先报；卡点/报错/换方案立刻说明；用户一催先回进展再继续。额外强调：接到任务后不能“假死/空转装忙”，必须真的开始执行；不管是否做成，都要先给出真实进展、结果或卡点，再继续找解决方案。- 关于 gstack 的长期记忆（2026-03-23）：gstack 不是单独一个 skill，而是一套工作流包装器家族。用户以后若提到“gstack skill / gstack 那套”，默认按任务类型匹配这批 skill：`review`（审代码/审 diff）、`investigate`（排查 bug / 查根因）、`qa` / `qa-only`（测站点/找问题）、`ship`（发版前检查）、`browse`（看网页流程/截图/UI）、`office-hours`（脑暴产品想法），以及 `plan-eng-review`、`design-review`、`canary`、`land-and-deploy` 等专项流程；用户可直接用“用某个 skill 帮我做某件事”的自然语言方式调用，无需记参数。
- 教学推送长期规则（2026-03-24）：`openclaw-tutor` 每日课程默认必须是“完整版讲义”，至少包含：学什么、为什么、具体步骤、示例/操作思路、验收标准、常见坑、做完后怎么回报；不能再发只有提纲和方向的摘要版。
