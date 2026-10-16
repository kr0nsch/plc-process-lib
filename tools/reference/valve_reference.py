#!/usr/bin/env python3
"""Эталонные значения для тестов арматуры (FB_Valve_Test, FB_ControlValve_Test).

Только стандартная библиотека Python 3.11+. Каждое число, которое тест берёт отсюда, помечено в
комментарии теста: «источник: tools/reference/valve_reference.py, сценарий <имя>».

Модель повторяет арифметику ST:
- рампа регулирующего клапана — шаг F_RateLimit в LREAL с округлением результата до REAL
  (float32) на каждом шаге, шаг времени dt = F_LTimeToSec(ltDt);
- плотное закрытие применяется к выходу, а не к состоянию рампы (FB_ControlValve, 6.5);
- ток выхода: 4 + 16 * x / 100, при инверсии x = 100 - rOut_pct (раздел 16.3 контракта);
- остаток времени хода задвижки — целые секунды вверх от tTravel - прошедшее;
- время работы привода — накопление MIN(dt, DT_ACCUM_MAX) по выходу прошлого вызова, в stRetain
  переносятся целые секунды; часы — секунды / 3600 в LREAL с округлением до REAL.

Сценарии:
- ``cv_manual_ramp`` — задание Manual 0 -> 50 % (рост 10 %/с), затем 50 -> 10 % (спад 20 %/с), шаг 0,1 с;
- ``cv_tight_ramp`` — плотное закрытие 5 %, рост 1 %/с, задание 0 -> 20 %, шаг 0,5 с;
- ``cv_return_ramp`` — возврат рампы от положения безопасности 10 % к 60 % (1 %/с, шаг 1 с) и от 20 %
  к 50 % (10 %/с, шаг 0,1 с);
- ``cv_bumpless`` — после Auto -> Manual задание 70 -> 60 % (спад 5 %/с, шаг 0,1 с);
- ``cv_positioner`` — от положения безопасности 100 % к 40 % (спад 2 %/с, шаг 0,1 с);
- ``cv_cycle_independence`` — рампа 10 %/с за 2 с при шаге 10 мс и 100 мс;
- ``cv_ma`` — ток выхода для набора положений, прямой и инверсный;
- ``valve_travel_remain`` — остаток времени хода при tTravel = 10 с;
- ``valve_act_time`` — время работы привода: 12,5 с шагами 0,1 с; один шаг 60 с; часы.

Запуск: ``python tools/reference/valve_reference.py`` печатает все сценарии.
"""

from __future__ import annotations

import math
import struct
import sys

PCT_FULL = 100.0
MA_ZERO = 4.0
MA_SPAN = 16.0
DT_ACCUM_MAX_S = 10.0  # GVL_Const.DT_ACCUM_MAX = LTIME#10S
S_PER_H = 3600


def f32(value: float) -> float:
    """Округление до REAL (IEEE 754 single), как присваивание LREAL -> REAL в ST."""
    return float(struct.unpack("<f", struct.pack("<f", value))[0])


def is_finite_real(value: float, sane_max: float = 1.0e30) -> bool:
    """F_IsFinite: не NaN, не ±Inf и |x| <= REAL_SANE_MAX."""
    return math.isfinite(value) and abs(value) <= sane_max


def rate_limit(current: float, target: float, rate_up: float, rate_down: float, dt_s: float) -> float:
    """Шаг F_RateLimit: расчёт в LREAL, результат — REAL."""
    if dt_s <= 0.0 or not is_finite_real(target):
        return current
    if target > current and rate_up > 0.0:
        return f32(min(target, current + rate_up * dt_s))
    if target < current and rate_down > 0.0:
        return f32(max(target, current - rate_down * dt_s))
    return f32(target)


def ramp(start: float, target: float, rate_up: float, rate_down: float, dt_s: float, steps: int) -> float:
    """Положение рампы после steps шагов dt_s от start к target."""
    value = f32(start)
    for _ in range(steps):
        value = rate_limit(value, f32(target), rate_up, rate_down, dt_s)
    return value


def tight_shut(ramp_pct: float, threshold_pct: float) -> float:
    """Плотное закрытие: выход 0, если порог > 0 и положение рампы ниже порога."""
    return 0.0 if threshold_pct > 0.0 and ramp_pct < threshold_pct else ramp_pct


def out_ma(out_pct: float, invert: bool) -> float:
    """Ток выхода позиционера, мА."""
    x = PCT_FULL - out_pct if invert else out_pct
    return f32(MA_ZERO + MA_SPAN * x / PCT_FULL)


def travel_remain_s(travel_s: float, elapsed_s: float) -> int:
    """Остаток до таймаута хода: целые секунды вверх."""
    return math.ceil(round(travel_s - elapsed_s, 9))


def act_time(steps: list[float]) -> tuple[int, float]:
    """Время работы привода: (целые секунды в stRetain, остаток накопителя, с).

    steps — шаги времени вызовов, в которые выход привода был включён в прошлом вызове.
    """
    seconds = 0
    accum_ns = 0
    for dt in steps:
        accum_ns += round(min(dt, DT_ACCUM_MAX_S) * 1e9)
        while accum_ns >= 1_000_000_000:
            accum_ns -= 1_000_000_000
            seconds += 1
    return seconds, accum_ns / 1e9


def act_hours(seconds: int) -> float:
    """stSts.rActTime_h = секунды / 3600 (LREAL -> REAL)."""
    return f32(seconds / S_PER_H)


# Сценарии: имя -> {метка: значение}
def scenarios() -> dict[str, dict[str, float]]:
    result: dict[str, dict[str, float]] = {}
    result["cv_manual_ramp"] = {
        "up 1.0 s": ramp(0.0, 50.0, 10.0, 20.0, 0.1, 10),
        "up 4.9 s": ramp(0.0, 50.0, 10.0, 20.0, 0.1, 49),
        "up 5.0 s": ramp(0.0, 50.0, 10.0, 20.0, 0.1, 50),
        "down 1.0 s": ramp(50.0, 10.0, 10.0, 20.0, 0.1, 10),
        "down 2.0 s": ramp(50.0, 10.0, 10.0, 20.0, 0.1, 20),
        "mA at 10 %": out_ma(10.0, False),
    }
    result["cv_tight_ramp"] = {
        "ramp 4.5 s": ramp(0.0, 20.0, 1.0, 0.0, 0.5, 9),
        "out 4.5 s": tight_shut(ramp(0.0, 20.0, 1.0, 0.0, 0.5, 9), 5.0),
        "out 5.0 s": tight_shut(ramp(0.0, 20.0, 1.0, 0.0, 0.5, 10), 5.0),
        "out 10.0 s": tight_shut(ramp(0.0, 20.0, 1.0, 0.0, 0.5, 20), 5.0),
        "out at sp 4": tight_shut(4.0, 5.0),
        "out at sp 6": tight_shut(6.0, 5.0),
    }
    result["cv_return_ramp"] = {
        "10 -> 60, 1 %/s, 1 s": ramp(10.0, 60.0, 1.0, 1.0, 1.0, 1),
        "20 -> 50, 10 %/s, 1.0 s": ramp(20.0, 50.0, 10.0, 10.0, 0.1, 10),
        "20 -> 50, 10 %/s, 3.0 s": ramp(20.0, 50.0, 10.0, 10.0, 0.1, 30),
    }
    result["cv_bumpless"] = {
        "70 -> 60, 5 %/s, 1.0 s": ramp(70.0, 60.0, 5.0, 5.0, 0.1, 10),
    }
    result["cv_positioner"] = {
        "100 -> 40, 2 %/s, 1.0 s": ramp(100.0, 40.0, 2.0, 2.0, 0.1, 10),
    }
    result["cv_cycle_independence"] = {
        "10 ms x 200": ramp(0.0, 80.0, 10.0, 10.0, 0.01, 200),
        "100 ms x 20": ramp(0.0, 80.0, 10.0, 10.0, 0.1, 20),
    }
    result["cv_ma"] = {
        "0 %": out_ma(0.0, False),
        "0 % inverted": out_ma(0.0, True),
        "25 %": out_ma(25.0, False),
        "25 % inverted": out_ma(25.0, True),
        "100 % inverted": out_ma(100.0, True),
        "30 %": out_ma(30.0, False),
        "100 %": out_ma(100.0, False),
    }
    result["valve_travel_remain"] = {
        "elapsed 0 s": travel_remain_s(10.0, 0.0),
        "elapsed 2.0 s": travel_remain_s(10.0, 2.0),
        "elapsed 2.05 s": travel_remain_s(10.0, 2.05),
        "elapsed 9.9 s": travel_remain_s(10.0, 9.9),
    }
    seconds_125, rest_125 = act_time([0.1] * 125)
    seconds_big, _ = act_time([60.0])
    result["valve_act_time"] = {
        "12.5 s by 0.1 s: seconds": seconds_125,
        "12.5 s by 0.1 s: accumulator": rest_125,
        "one 60 s step: seconds": seconds_big,
        "hours of 7190 + 12 s": act_hours(7190 + seconds_125),
    }
    return result


def main() -> int:
    reconfigure = getattr(sys.stdout, "reconfigure", None)
    if reconfigure is not None:  # консоль Windows: вывод по-русски в UTF-8
        reconfigure(encoding="utf-8")
    for name, values in scenarios().items():
        print(f"{name}:")
        for label, value in values.items():
            print(f"  {label:32} {value!r}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
