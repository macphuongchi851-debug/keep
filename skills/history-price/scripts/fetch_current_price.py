#!/usr/bin/env python3
import json
import re
import sys
import urllib.request
from html import unescape

UA = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136 Safari/537.36'
PRICE_RE = re.compile(r'(?:¥|￥|price[^0-9]{0,20})(\d+(?:\.\d{1,2})?)', re.I)
TITLE_RE = re.compile(r'<title[^>]*>(.*?)</title>', re.I | re.S)


def fetch(url: str):
    req = urllib.request.Request(url, headers={'User-Agent': UA})
    with urllib.request.urlopen(req, timeout=20) as resp:
        return resp.read().decode('utf-8', 'ignore'), resp.geturl()


def main():
    if len(sys.argv) < 2:
        print(json.dumps({'ok': False, 'error': 'usage: fetch_current_price.py <url>'}, ensure_ascii=False))
        return 1
    url = sys.argv[1]
    try:
        html, final_url = fetch(url)
        title_m = TITLE_RE.search(html)
        price_m = PRICE_RE.search(html)
        title = unescape(title_m.group(1).strip()) if title_m else None
        price = float(price_m.group(1)) if price_m else None
        print(json.dumps({
            'ok': True,
            'url': url,
            'final_url': final_url,
            'title': title,
            'current_price': price,
            'price_found': price is not None,
        }, ensure_ascii=False))
        return 0
    except Exception as e:
        print(json.dumps({'ok': False, 'url': url, 'error': str(e)}, ensure_ascii=False))
        return 2


if __name__ == '__main__':
    raise SystemExit(main())
