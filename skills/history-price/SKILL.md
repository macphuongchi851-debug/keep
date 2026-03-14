---
name: history-price
description: Check current price, historical price, and whether a product link is near a "good deal" or "神价" threshold. Use when a user sends a JD/Taobao/Tmall/Pinduoduo product link and asks whether it is worth buying, what the historical low was, whether the current price is a good deal, or when building/maintaining a local price history database for future deal checks.
---

# History Price

## Overview

Use this skill to evaluate product prices from shopping links.

Prioritize a practical result over perfect coverage:
1. Detect platform and extract a stable product identifier.
2. Fetch current price when possible.
3. Try one or more public history-price sources.
4. If public history fails, still save the current observation locally.
5. Judge whether the current price is a good deal using available history plus user-defined thresholds.

## Workflow

### 1. Normalize the input

Accept any of these:
- Full product URL
- Short URL that redirects to a product page
- Product title plus URL
- Raw text containing a JD/Taobao/Tmall/Pinduoduo link

Use `scripts/detect_platform.py` to:
- extract the first supported URL from input text
- classify platform
- derive a product ID when possible

If the link is unsupported, say so plainly and stop.

### 2. Fetch current price first

Run `scripts/fetch_current_price.py`.

Goals:
- get a current price if possible
- capture title if available
- record the normalized URL and product ID

If the script cannot fetch a price reliably, return a partial result instead of hallucinating.

### 3. Try public history-price sources

Run `scripts/fetch_history_price.py`.

Current strategy for MVP:
- keep the source layer pluggable
- prefer public webpages/APIs if available
- tolerate failure gracefully
- never pretend a history source succeeded when it did not

If no history source works, explicitly say:
- current price was checked
- no public historical data was available right now
- the price has still been saved locally for future comparisons

### 4. Save a local observation every time

Run `scripts/save_price_record.py` whenever you have at least:
- platform
- normalized URL or product ID
- current timestamp
- current price if available

Store data under the skill directory so later runs can build a local history even when external sources fail.

### 5. Judge whether it is a good deal

Run `scripts/judge_deal.py`.

Use these judgment layers in order:
1. **User threshold** if one is configured for that product/category/keyword
2. **Historical low proximity** if external or local history exists
3. **Recent range comparison** using local records
4. **Fallback wording** when evidence is weak

Recommended wording:
- **可冲 / 接近神价**: current price is within about 5% of the known low, or below a user threshold
- **可买但不算神价**: price is reasonable but not close to the known low
- **再等等**: price is clearly above recent norm or known low
- **信息不足**: only current price available, no trustworthy history yet

## Output format

Prefer a short, decision-first answer:

- 商品：<title>
- 平台：<platform>
- 当前价：<price>
- 历史最低：<price or unknown>
- 最近区间：<range or unknown>
- 结论：<可冲 / 可买但不算神价 / 再等等 / 信息不足>
- 说明：<one or two short reasons>

If local history was updated, mention it briefly.

## Local data

Use these files:
- `references/platforms.md` for supported platform notes and caveats
- `data/price-history.jsonl` for appended observations
- `data/rules.json` for user-defined thresholds

Create `data/` on demand.

## Guardrails

- Do not invent historical lows.
- Do not claim a product is a 神价 unless there is evidence or an explicit user rule.
- Be explicit when public sources fail.
- Keep the scripts modular so data-source adapters can be swapped later.
- Prefer deterministic extraction and storage over clever but fragile scraping logic.

## Resources

### scripts/
- `detect_platform.py`: classify platform, normalize URL, extract product ID
- `fetch_current_price.py`: fetch current price from page content when possible
- `fetch_history_price.py`: query public history sources or return a structured miss
- `save_price_record.py`: append local observations to JSONL
- `judge_deal.py`: combine history and rules into a verdict

### references/
- `platforms.md`: supported platforms, extraction notes, and known caveats
