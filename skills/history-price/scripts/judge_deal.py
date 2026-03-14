#!/usr/bin/env python3
import json
import sys


def main():
    if len(sys.argv) < 2:
        print(json.dumps({'ok': False, 'error': 'usage: judge_deal.py <json-payload>'}, ensure_ascii=False))
        return 1
    data = json.loads(sys.argv[1])
    current = data.get('current_price')
    low = data.get('historical_low')
    threshold = data.get('user_threshold')
    verdict = '信息不足'
    reason = '只有当前价格，历史数据还不够。'

    if current is not None and threshold is not None:
        if current <= threshold:
            verdict = '可冲 / 接近神价'
            reason = f'当前价 {current} 低于或等于你的阈值 {threshold}。'
        else:
            verdict = '再等等'
            reason = f'当前价 {current} 高于你的阈值 {threshold}。'
    elif current is not None and low is not None:
        if current <= low * 1.05:
            verdict = '可冲 / 接近神价'
            reason = f'当前价 {current} 已接近历史低价 {low}。'
        elif current <= low * 1.15:
            verdict = '可买但不算神价'
            reason = f'当前价 {current} 比历史低价 {low} 略高。'
        else:
            verdict = '再等等'
            reason = f'当前价 {current} 明显高于历史低价 {low}。'

    print(json.dumps({'ok': True, 'verdict': verdict, 'reason': reason}, ensure_ascii=False))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
