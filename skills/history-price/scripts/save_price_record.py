#!/usr/bin/env python3
import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path


def main():
    if len(sys.argv) < 2:
        print(json.dumps({'ok': False, 'error': 'usage: save_price_record.py <json-payload>'}, ensure_ascii=False))
        return 1
    payload = json.loads(sys.argv[1])
    root = Path(__file__).resolve().parents[1]
    data_dir = root / 'data'
    data_dir.mkdir(parents=True, exist_ok=True)
    out = data_dir / 'price-history.jsonl'
    payload.setdefault('recorded_at', datetime.now(timezone.utc).isoformat())
    with out.open('a', encoding='utf-8') as f:
        f.write(json.dumps(payload, ensure_ascii=False) + '\n')
    print(json.dumps({'ok': True, 'path': str(out), 'recorded_at': payload['recorded_at']}, ensure_ascii=False))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
