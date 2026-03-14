#!/usr/bin/env python3
import json
import sys

# MVP stub: public source adapters will be added later.
# Keep structured output so the workflow can already function.


def main():
    if len(sys.argv) < 3:
        print(json.dumps({'ok': False, 'error': 'usage: fetch_history_price.py <platform> <url_or_id>'}, ensure_ascii=False))
        return 1
    platform = sys.argv[1]
    target = sys.argv[2]
    print(json.dumps({
        'ok': False,
        'platform': platform,
        'target': target,
        'history_found': False,
        'source': None,
        'historical_low': None,
        'recent_range': None,
        'error': 'no_public_source_adapter_yet'
    }, ensure_ascii=False))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
