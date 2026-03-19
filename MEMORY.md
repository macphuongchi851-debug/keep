# MEMORY.md

- 用于长期记忆（精炼版）。
- 健身页面固定使用“专属同步入口”再发给用户，避免换设备/换浏览器后训练数据不同步。用户要求以后优先发固定同步链接再开始训练。
- 当前固定家庭版同步入口（2026-03-10 创建）：`https://macphuongchi851-debug.github.io/keep/workout_home.html?sync=FaVIOitNku_XTFZgX0iXe9cCnu_0l2B0`。
- A8Ads 相关长期记忆：网站为 `https://www.a8ads.com/`；后续用户若直接提“A8Ads 那套/剪映方案/口播方案”，默认接这次沉淀的 42 秒横版宣传片方案：结构为「首页 → Ads → Advertisers → Products → 首页收尾」，主打“洞察竞对广告，发掘全球爆款产品”，不把套餐页放进第一版主宣传片。已整理过可直接执行的内容：剪映一步步执行稿、42 秒时间轴清单、AI 口播逐句复制版；默认推荐 AI 配音方向为商务稳重男声/专业解说男声，其次知性专业女声。
- 用户约定简称：以后提到“PW爬虫”，默认指 `Playwright Scraper Skill`。
- 处理用户上传的图片（inbound media）若遇到权限/沙箱报错，可尝试将其 cp（复制）到工作目录再读取，例如 `cp /home/keep/.openclaw/media/inbound/xxx.jpg ~/.openclaw/workspace/temp.jpg`。
- 处理 Chromium 容器访问外网报错，优先建议在容器环境变量中添加 `HTTP_PROXY`、`HTTPS_PROXY` 和 `NO_PROXY`，并在启动参数（Command）中追加 `--proxy-server="http://IP:PORT"`。
- 飞牛 OS 容器代理地址默认为本机 IP（如 192.168.10.101）及 Clash 端口（如 7890）。
- 用户新增长期纪律要求（2026-03-18）：凡是去做事，必须及时汇报、阶段性汇报，不能长时间闷头不反馈。默认规则：开工先报预计耗时；超过 60 秒主动同步；有阶段性结果先报；卡点/报错/换方案立刻说明；用户一催先回进展再继续。
