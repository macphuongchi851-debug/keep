#!/usr/bin/env python3
"""Macro / calorie quick helper.

Use cases:
- Suggest starting calories for fat loss / maintenance / slow bulk
- Suggest protein/fat/carb targets based on body weight

This is intentionally simple. It outputs a *starting point*, then the user should
adjust weekly based on weight trend + performance.

Examples:
  python3 macro_calculator.py --weight-kg 80 --goal cut
  python3 macro_calculator.py --weight-kg 62 --goal bulk --activity moderate

"""

from __future__ import annotations

import argparse


ACTIVITY_MULTIPLIER = {
    "low": 30,       # kcal/kg/day (rough)
    "moderate": 33,
    "high": 36,
}


def clamp(x: float, lo: float, hi: float) -> float:
    return max(lo, min(hi, x))


def main() -> None:
    p = argparse.ArgumentParser()
    p.add_argument("--weight-kg", type=float, required=True)
    p.add_argument("--goal", choices=["cut", "maintain", "bulk"], required=True)
    p.add_argument("--activity", choices=["low", "moderate", "high"], default="moderate")
    p.add_argument("--protein-g-per-kg", type=float, default=None)
    p.add_argument("--fat-g-per-kg", type=float, default=None)
    args = p.parse_args()

    w = args.weight_kg
    if w <= 0:
        raise SystemExit("weight must be > 0")

    # Maintenance estimate (very rough): kcal/kg/day by activity
    maintenance = w * ACTIVITY_MULTIPLIER[args.activity]

    if args.goal == "cut":
        calories = maintenance - 400
    elif args.goal == "bulk":
        calories = maintenance + 250
    else:
        calories = maintenance

    # Defaults
    protein = args.protein_g_per_kg if args.protein_g_per_kg is not None else (
        2.0 if args.goal == "cut" else 1.8
    )
    fat = args.fat_g_per_kg if args.fat_g_per_kg is not None else 0.8

    # sanity bounds
    protein = clamp(protein, 1.2, 2.4)
    fat = clamp(fat, 0.5, 1.2)

    protein_g = protein * w
    fat_g = fat * w

    # calories from P/F
    kcal_pf = protein_g * 4 + fat_g * 9
    carbs_kcal = max(0.0, calories - kcal_pf)
    carbs_g = carbs_kcal / 4

    print("=== Fitness Coach: Macro starting point ===")
    print(f"Weight: {w:.1f} kg")
    print(f"Activity: {args.activity}")
    print(f"Goal: {args.goal}")
    print(f"Maintenance est.: {maintenance:.0f} kcal/day")
    print(f"Target calories : {calories:.0f} kcal/day")
    print("\nMacros:")
    print(f"- Protein: {protein_g:.0f} g/day ({protein:.2f} g/kg)")
    print(f"- Fat    : {fat_g:.0f} g/day ({fat:.2f} g/kg)")
    print(f"- Carbs  : {carbs_g:.0f} g/day (rest)")
    print("\nNote: adjust weekly using weight trend + training performance.")


if __name__ == "__main__":
    main()
