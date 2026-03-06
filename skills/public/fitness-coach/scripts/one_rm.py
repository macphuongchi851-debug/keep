#!/usr/bin/env python3
"""Estimate 1RM from reps.

Formulas vary; we print a few common ones.
Example:
  python3 one_rm.py --weight 100 --reps 5
"""

from __future__ import annotations

import argparse


def main() -> None:
    p = argparse.ArgumentParser()
    p.add_argument("--weight", type=float, required=True, help="Weight used")
    p.add_argument("--reps", type=int, required=True, help="Completed reps")
    args = p.parse_args()

    w = args.weight
    r = args.reps
    if w <= 0 or r <= 0:
        raise SystemExit("weight and reps must be > 0")

    # Common estimators
    epley = w * (1 + r / 30)
    brzycki = w * (36 / (37 - r)) if r < 37 else float("inf")
    lombardi = w * (r ** 0.10)

    print("=== 1RM estimates ===")
    print(f"Input: {w:.2f} x {r}")
    print(f"Epley   : {epley:.2f}")
    print(f"Brzycki : {brzycki:.2f}")
    print(f"Lombardi: {lombardi:.2f}")


if __name__ == "__main__":
    main()
