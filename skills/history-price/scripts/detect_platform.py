#!/usr/bin/env python3
import json
import re
import sys
from urllib.parse import urlparse, parse_qs

SUPPORTED = {
    'jd': ['item.jd.com', 'item.m.jd.com', 'u.jd.com', '3.cn'],
    'taobao': ['item.taobao.com', 'm.tb.cn'],
    'tmall': ['detail.tmall.com'],
    'pinduoduo': ['mobile.yangkeduo.com', 'yangkeduo.com', 'pinduoduo.com'],
}

URL_RE = re.compile(r'https?://\S+')


def find_url(text: str):
    m = URL_RE.search(text or '')
    return m.group(0).rstrip(')>,]') if m else None


def detect(url: str):
    p = urlparse(url)
    host = (p.netloc or '').lower()
    for platform, hosts in SUPPORTED.items():
        if any(host == h or host.endswith('.' + h) for h in hosts):
            return platform, p
    return 'unsupported', p


def extract_id(platform: str, p):
    url = p.geturl()
    if platform == 'jd':
        m = re.search(r'/([0-9]{5,})\.html', p.path)
        return m.group(1) if m else None
    if platform in ('taobao', 'tmall'):
        qs = parse_qs(p.query)
        return (qs.get('id') or [None])[0]
    if platform == 'pinduoduo':
        qs = parse_qs(p.query)
        for key in ('goods_id', 'gid'):
            if key in qs:
                return qs[key][0]
        m = re.search(r'/goods(\.html)?(?:/|\?)?.*?(\d{5,})', url)
        return m.group(2) if m else None
    return None


def main():
    raw = ' '.join(sys.argv[1:]).strip() if len(sys.argv) > 1 else sys.stdin.read().strip()
    url = raw if raw.startswith('http') else find_url(raw)
    if not url:
        print(json.dumps({'ok': False, 'error': 'no_url_found'}, ensure_ascii=False))
        return 1
    platform, parsed = detect(url)
    out = {
        'ok': platform != 'unsupported',
        'platform': platform,
        'url': url,
        'product_id': extract_id(platform, parsed),
    }
    print(json.dumps(out, ensure_ascii=False))
    return 0 if out['ok'] else 2


if __name__ == '__main__':
    raise SystemExit(main())
