#!/usr/bin/env python3
"""Эталонные значения для тестов аналогового входа (FB_AnalogInput_Test).

Только стандартная библиотека Python 3.11+. Каждое число, которое тест берёт отсюда, помечено в
комментарии теста: «источник: tools/reference/ai_reference.py, сценарий <имя>».

Модель повторяет цепочку обработки раздела 11.3 контракта (docs/API.md) и реализацию
src/POUs/Devices/FB_AnalogInput/:
- нормировка, корень, отсечка, инженерные единицы, ограничение шкалой и фильтр считаются в LREAL
  (двойная точность, как float в Python) от входов REAL;
- результат для логики — REAL: значение округляется до одинарной точности (``to_real``);
- фильтр первого порядка — точная экспонента по реальному шагу времени:
  ``alpha = 1 - exp(-dt / T)``, ``y += alpha * (x - y)``; первый шаг (и шаг после отказа сигнала)
  начинает фильтр с текущего значения.

Сценарии:
- ``scale`` — масштабирование по типам входа (мА, Norm420, Norm01, Eng, Raw), корень и отсечка,
  ограничение шкалой, экстраполяция вне 4–20 мА;
- ``filter`` — реакция фильтра на ступень: одна постоянная времени (63,2 %), один и тот же интервал
  с разным шагом цикла, возврат сигнала после отказа (фильтр начинается заново).

Запуск: ``python tools/reference/ai_reference.py`` печатает все сценарии.
"""

from __future__ import annotations

import math
import struct
import sys
from dataclasses import dataclass

MA_ZERO = 4.0
MA_SPAN = 16.0
PCT_FULL = 100.0


def to_real(value: float) -> float:
    """Округление до REAL (IEEE 754, одинарная точность)."""
    result: float = struct.unpack("<f", struct.pack("<f", value))[0]
    return result


@dataclass(frozen=True)
class AiCfg:
    """Поля ST_AnalogInputCfg, от которых зависит значение (имена — как в DUT)."""

    e_input: str = "MilliAmp"  # MilliAmp, Norm420, Norm01, Eng, Raw
    range_lo: float = 0.0
    range_hi: float = 100.0
    raw_lo: float = 0.0
    raw_hi: float = 0.0
    sqrt: bool = False
    low_cut_pct: float = 0.0
    clamp: bool = False


def scale(cfg: AiCfg, r_in: float) -> float:
    """Значение в инж. ед. до фильтра (LREAL): шаги 2–4 раздела 11.3."""
    r_in = to_real(r_in)
    lo = to_real(cfg.range_lo)
    hi = to_real(cfg.range_hi)
    span = hi - lo
    if cfg.e_input == "MilliAmp":
        x = (r_in - MA_ZERO) / MA_SPAN
    elif cfg.e_input == "Eng":
        x = (r_in - lo) / span
    elif cfg.e_input == "Raw":
        raw_lo = to_real(cfg.raw_lo)
        x = (r_in - raw_lo) / (to_real(cfg.raw_hi) - raw_lo)
    else:  # Norm420, Norm01
        x = r_in
    if cfg.sqrt:
        x = math.sqrt(max(x, 0.0))
    if cfg.low_cut_pct > 0.0 and x * PCT_FULL < to_real(cfg.low_cut_pct):
        x = 0.0
    eng = lo + x * span
    if cfg.clamp:
        eng = min(max(eng, lo), hi)
    return eng


def filter_steps(t_filter_s: float, start: float, target: float, steps_s: list[float]) -> float:
    """Фильтр: первый вызов со значением start, затем вызовы со значением target через steps_s."""
    y = start
    for dt in steps_s:
        alpha = 1.0 - math.exp(-dt / t_filter_s)
        y = y + alpha * (target - y)
    return y


# (название, конфигурация, rIn) -> значение REAL
SCALE_SCENARIOS: list[tuple[str, AiCfg, float]] = [
    ("4 мА, шкала 2..12", AiCfg(range_lo=2.0, range_hi=12.0), 4.0),
    ("20 мА, шкала 2..12", AiCfg(range_lo=2.0, range_hi=12.0), 20.0),
    ("12 мА, шкала 2..12", AiCfg(range_lo=2.0, range_hi=12.0), 12.0),
    ("Norm420 0,5, шкала 2..12", AiCfg(e_input="Norm420", range_lo=2.0, range_hi=12.0), 0.5),
    ("Norm420 0,25, шкала 0..100", AiCfg(e_input="Norm420"), 0.25),
    ("Norm01 -0,03, шкала 0..100", AiCfg(e_input="Norm01"), -0.03),
    ("Norm01 0,7, шкала 0..100", AiCfg(e_input="Norm01"), 0.7),
    ("Eng 37,5, шкала 0..100", AiCfg(e_input="Eng"), 37.5),
    ("Eng 123,4, шкала -50..150", AiCfg(e_input="Eng", range_lo=-50.0, range_hi=150.0), 123.4),
    ("Raw 6000, 2000..10000 -> 0..16", AiCfg(e_input="Raw", range_hi=16.0, raw_lo=2000.0, raw_hi=10000.0), 6000.0),
    ("Raw 1000 (ниже RawLo)", AiCfg(e_input="Raw", range_hi=16.0, raw_lo=2000.0, raw_hi=10000.0), 1000.0),
    ("3,7 мА, шкала 0..100 (экстраполяция)", AiCfg(), 3.7),
    ("20,7 мА, шкала 0..100 (экстраполяция)", AiCfg(), 20.7),
    ("корень: 8 мА (25 % перепада), 0..100", AiCfg(sqrt=True), 8.0),
    ("корень: 4,032 мА (0,2 %), отсечка 5 %", AiCfg(sqrt=True, low_cut_pct=5.0), 4.032),
    ("корень: 4,16 мА (1 %), отсечка 5 %", AiCfg(sqrt=True, low_cut_pct=5.0), 4.16),
    ("без корня: 4,4 мА (2,5 %), отсечка 3 %", AiCfg(low_cut_pct=3.0), 4.4),
    ("без корня: 6 мА (12,5 %), отсечка 12,5 %", AiCfg(low_cut_pct=12.5), 6.0),
    ("20,4 мА без ограничения", AiCfg(), 20.4),
    ("20,4 мА с ограничением шкалой", AiCfg(clamp=True), 20.4),
    ("3,9 мА с ограничением шкалой", AiCfg(clamp=True), 3.9),
]

STEP_10MS = [0.01] * 500
STEP_250MS = [0.25] * 20
# неравномерный шаг: 0,05 / 0,15 / 0,3 с по кругу, всего 5,0 с
STEP_IRREGULAR = [0.05, 0.15, 0.3] * 10

# (название, T, от, к, шаги) -> значение фильтра (REAL)
FILTER_SCENARIOS: list[tuple[str, float, float, float, list[float]]] = [
    ("ступень 0 -> 100, T = 10 с, 100 шагов по 0,1 с", 10.0, 0.0, 100.0, [0.1] * 100),
    ("ступень 0 -> 100, T = 10 с, 99 шагов по 0,1 с", 10.0, 0.0, 100.0, [0.1] * 99),
    ("ступень 0 -> 100, T = 10 с, 5 с шагом 10 мс", 10.0, 0.0, 100.0, STEP_10MS),
    ("ступень 0 -> 100, T = 10 с, 5 с шагом 250 мс", 10.0, 0.0, 100.0, STEP_250MS),
    ("ступень 0 -> 100, T = 10 с, 5 с неравномерно", 10.0, 0.0, 100.0, STEP_IRREGULAR),
    ("возврат сигнала 50 -> 75 без сброса фильтра, 2 с (не должно быть)", 10.0, 50.0, 75.0, [0.1] * 20),
]


def implicit_euler(t_filter_s: float, start: float, target: float, steps_s: list[float]) -> float:
    """Неявный Эйлер alpha = dt / (T + dt): зависит от шага — контракт его запрещает."""
    y = start
    for dt in steps_s:
        y = y + dt / (t_filter_s + dt) * (target - y)
    return y


def main() -> int:
    reconfigure = getattr(sys.stdout, "reconfigure", None)
    if reconfigure is not None:  # консоль Windows: вывод по-русски в UTF-8
        reconfigure(encoding="utf-8")
    print("scale:")
    for title, cfg, r_in in SCALE_SCENARIOS:
        eng = scale(cfg, r_in)
        print(f"  {title:42} LREAL {eng!r:24} REAL {to_real(eng)!r}")
    print("filter:")
    for title, t_s, start, target, steps in FILTER_SCENARIOS:
        value = filter_steps(t_s, start, target, steps)
        print(f"  {title:62} {value!r:22} REAL {to_real(value)!r}")
    euler = implicit_euler(10.0, 0.0, 100.0, STEP_250MS)
    print(f"  {'для сравнения: неявный Эйлер dt/(T+dt), 5 с шагом 250 мс':62} {euler!r:22} (зависит от шага)")
    print(f"  1 - exp(-1) = {1.0 - math.exp(-1.0)!r}, 1 - exp(-0,5) = {1.0 - math.exp(-0.5)!r}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
