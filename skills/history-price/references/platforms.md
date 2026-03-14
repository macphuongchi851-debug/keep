# Supported platforms (MVP)

## JD / 京东
- Common host patterns: `item.jd.com`, `item.m.jd.com`, `u.jd.com` short links
- Preferred identifier: numeric SKU from URL
- Notes: some pages require JS rendering; short links may need redirect resolution first

## Taobao / Tmall
- Common host patterns: `item.taobao.com`, `detail.tmall.com`, short/share links
- Preferred identifier: `id` query parameter when present
- Notes: anti-bot protections are common; extraction should degrade gracefully

## Pinduoduo
- Common host patterns: `mobile.yangkeduo.com`, `pinduoduo.com`
- Preferred identifier: product/goods ID when present in query or path
- Notes: links vary more than JD/Taobao, so normalization should preserve original URL when ID extraction fails

## General guidance
- Always keep the original input URL alongside the normalized URL
- If redirect resolution is needed, preserve the final resolved URL for storage
- If platform detection fails, return `unsupported`
