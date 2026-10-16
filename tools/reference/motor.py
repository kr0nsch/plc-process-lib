#!/usr/bin/env python3
"""Эталонные значения для тестов двигателя (FB_Motor_Test, FB_MotorVfd_Test).

Только стандартная библиотека Python 3.11+ и tools/reference/common.py. Каждое число, которое тест
берёт отсюда, помечено в комментарии теста: «источник: tools/reference/motor.py, сценарий <имя>».
Модель повторяет арифметику ФБ (docs/fb/FB_Motor.md, docs/fb/FB_MotorVfd.md), а не логику
автомата состояний: время — целые наносекунды (как LTIME), задание скорости — REAL (float32).

Сценарии:
- ``run_*`` — наработка: накопитель по шагам времени ltDt (не больше DT_ACCUM_MAX = 10 с),
  в retain переносятся целые секунды, доля секунды остаётся в накопителе. Шаг засчитывается, если
  двигатель работал в начале шага (в прошлом вызове);
- ``inhibit_*`` — остаток запрета пуска uiInhibitRemain_s: MAX(остаток tMinStop, TimeToFree окна
  пусков) в секундах с округлением вверх, не больше UINT_MAX;
- ``starts_limit_3`` — лимит пусков в час (окно FB_StartsWindow — common.window_time_to_free);
- ``ramp_*`` — задание ПЧ: F_RateLimit по шагам (common.rate_limit) с округлением до REAL;
- ``maint_runtime`` — порог ТО по наработке: udiMaintInterval_h * S_PER_H.

Запуск: ``python tools/reference/motor.py`` печатает все сценарии.
"""

from __future__ import annotations

import struct
import sys
from dataclasses import dataclass

import common

NS_PER_S = common.NS_PER_S
DT_ACCUM_MAX_NS = 10 * NS_PER_S  # GVL_Const.DT_ACCUM_MAX = LTIME#10S
UINT_MAX = 65535
S_PER_H = 3600


def ns(seconds: float) -> int:
    """Секунды -> целые наносекунды (LTIME); шаги тестов кратны 1 мс."""
    return round(seconds * NS_PER_S)


def to_real(value: float) -> float:
    """Округление LREAL -> REAL (float32), как LREAL_TO_REAL в F_RateLimit."""
    rounded: float = struct.unpack("<f", struct.pack("<f", value))[0]
    return rounded


# ---------------------------------------------------------------------------
# Наработка (FB_Motor, шаг 8 тела)
# ---------------------------------------------------------------------------


@dataclass
class RunAccumulator:
    """Накопитель наработки: целые секунды в retain, доля секунды — здесь."""

    acc_ns: int = 0
    total_s: int = 0
    current_s: int = 0

    def step(self, dt_ns: int, running_before: bool) -> None:
        """Один вызов ФБ: шаг ltDt засчитывается, если двигатель работал в прошлом вызове."""
        if not running_before:
            return
        self.acc_ns += min(dt_ns, DT_ACCUM_MAX_NS)
        whole = self.acc_ns // NS_PER_S
        self.acc_ns -= whole * NS_PER_S
        self.total_s += whole
        self.current_s += whole


def run_seconds(steps_s: list[float]) -> int:
    """Целые секунды наработки после пуска (вызов пуска — без шага) и вызовов с шагами steps_s."""
    accumulator = RunAccumulator()
    for step in steps_s:
        accumulator.step(ns(step), running_before=True)
    return accumulator.total_s


def run_hours(seconds: int) -> float:
    """rRunTime_h = udiOpTime_s / S_PER_H, округление до REAL."""
    return to_real(seconds / S_PER_H)


# ---------------------------------------------------------------------------
# Запрет пуска (FB_Motor, шаг 8 тела)
# ---------------------------------------------------------------------------


def ceil_seconds(remain_ns: int) -> int:
    """Секунды с округлением вверх, не больше UINT_MAX."""
    return min((remain_ns + NS_PER_S - 1) // NS_PER_S, UINT_MAX)


def inhibit_remain_s(min_stop_s: float, since_stop_s: float, time_to_free_s: float = 0.0) -> int:
    """uiInhibitRemain_s = MAX(остаток tMinStop, TimeToFree) с округлением вверх."""
    left = max(ns(min_stop_s) - ns(since_stop_s), 0)
    return ceil_seconds(max(left, ns(time_to_free_s)))


# ---------------------------------------------------------------------------
# Задание скорости ПЧ (FB_MotorVfd, шаг 3 тела)
# ---------------------------------------------------------------------------


def ramp(start: float, target: float, rate_up: float, rate_down: float, dt_s: float, steps: int) -> float:
    """Задание после steps вызовов с шагом dt_s: F_RateLimit, результат каждого шага — REAL."""
    value = to_real(start)
    for _ in range(steps):
        value = to_real(common.rate_limit(value, to_real(target), rate_up, rate_down, dt_s))
    return value


# ---------------------------------------------------------------------------
# Сценарии, на которые ссылаются тесты ST
# ---------------------------------------------------------------------------

SCENARIOS: dict[str, float] = {
    # FB_Motor_Test.RunHoursAccumulateInRetain: 540 вызовов с шагом 10 с после пуска
    "run_hours_90min_s": run_seconds([10.0] * 540),
    "run_hours_90min_h": run_hours(run_seconds([10.0] * 540)),
    # там же: 25 вызовов с шагом 100 мс — 2,5 с, в retain 2 с, 0,5 с остаётся в накопителе
    "run_fraction_2p5s_s": run_seconds([0.1] * 25),
    # FB_Motor_Test.RunHoursLargeTimeStepBounded: шаг 1 ч засчитывается как 10 с, затем шаг 3 с
    "run_large_step_s": run_seconds([3600.0]),
    "run_large_step_then_3s_s": run_seconds([3600.0, 3.0]),
    # FB_Motor_Test.CurrentRunSecondsCountsAndResetsOnStop: 65 шагов по 1 с, затем 3 шага по 1 с
    "current_run_65s": run_seconds([1.0] * 65),
    "current_run_total_68s": run_seconds([1.0] * 65) + run_seconds([1.0] * 3),
    # FB_Motor_Test.MaintIntervalReachedMaintenanceRequired: порог 1 ч — 3600 с; 3590 + 10 шагов по 1 с
    "maint_runtime_threshold_s": 1 * S_PER_H,
    "maint_runtime_after_s": 3590 + run_seconds([1.0] * 10),
    # FB_Motor_Test.MinStopTimeInhibitsRestartReportsRemaining: tMinStop 30 с
    "inhibit_min_stop_at_stop": inhibit_remain_s(30.0, 0.0),
    "inhibit_min_stop_after_12p3s": inhibit_remain_s(30.0, 12.3),
    "inhibit_min_stop_after_29p9s": inhibit_remain_s(30.0, 29.9),
    # FB_Motor_Test.PowerLossStopsWithoutFaultStartsMinStop: tMinStop 20 с, питание вернулось через 5 с
    "inhibit_power_loss_after_5s": inhibit_remain_s(20.0, 5.0),
    # FB_Motor_Test.StartsPerHourLimitReachedInhibitsUntilWindowFrees: пуски в 0, 10, 20 мин, лимит 3
    "starts_limit_3_free_at_30min_s": inhibit_remain_s(
        0.0, 0.0, common.window_time_to_free([0.0, 600.0, 1200.0], 1800.0, 3)
    ),
    "starts_limit_3_free_at_59min_s": inhibit_remain_s(
        0.0, 0.0, common.window_time_to_free([0.0, 600.0, 1200.0], 3540.0, 3)
    ),
    "starts_limit_3_count_at_30min": float(common.window_count([0.0, 600.0, 1200.0], 1800.0)),
    "starts_limit_3_count_at_60min": float(common.window_count([0.0, 600.0, 1200.0], 3600.0)),
    # FB_MotorVfd_Test.SpeedRampLimitsRate: min 20 %, рост 10 %/с, спад 5 %/с, шаг 100 мс, цель 50 %
    "ramp_up_1p5s": ramp(20.0, 50.0, 10.0, 5.0, 0.1, 15),
    "ramp_up_3s": ramp(20.0, 50.0, 10.0, 5.0, 0.1, 30),
    # там же: затем цель 30 %, спад 5 %/с
    "ramp_down_2s": ramp(50.0, 30.0, 10.0, 5.0, 0.1, 20),
    "ramp_down_4s": ramp(50.0, 30.0, 10.0, 5.0, 0.1, 40),
    # FB_MotorVfd_Test.StartPresetsRampToMin: min 30 %, рост 10 %/с, цель 80 %, один шаг 100 мс
    "start_preset_first_step": ramp(30.0, 80.0, 10.0, 0.0, 0.1, 1),
    "start_preset_after_1s": ramp(30.0, 80.0, 10.0, 0.0, 0.1, 10),
}


def main() -> int:
    reconfigure = getattr(sys.stdout, "reconfigure", None)
    if reconfigure is not None:  # консоль Windows: вывод по-русски в UTF-8
        reconfigure(encoding="utf-8")
    print("Эталоны двигателя (tools/reference/motor.py):")
    for name, value in SCENARIOS.items():
        print(f"  {name:36} {value!r}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
