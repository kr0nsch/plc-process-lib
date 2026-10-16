"""Эталоны двигателя (tools/reference/motor.py) против чисел, записанных в тестах ST.

Тесты FB_Motor_Test и FB_MotorVfd_Test ссылаются на сценарии motor.py комментарием «источник:
tools/reference/motor.py, сценарий …». Если модель изменится, а числа в тестах ST — нет, этот тест
покажет расхождение.

Запуск: python -m pytest (каталог входит в testpaths, pyproject.toml).
"""

from __future__ import annotations

import motor

# Сценарий -> число в тесте ST
EXPECTED: dict[str, float] = {
    "run_hours_90min_s": 5400,
    "run_hours_90min_h": 1.5,
    "run_fraction_2p5s_s": 2,
    "run_large_step_s": 10,
    "run_large_step_then_3s_s": 13,
    "current_run_65s": 65,
    "current_run_total_68s": 68,
    "maint_runtime_threshold_s": 3600,
    "maint_runtime_after_s": 3600,
    "inhibit_min_stop_at_stop": 30,
    "inhibit_min_stop_after_12p3s": 18,
    "inhibit_min_stop_after_29p9s": 1,
    "inhibit_power_loss_after_5s": 15,
    "starts_limit_3_free_at_30min_s": 1800,
    "starts_limit_3_free_at_59min_s": 60,
    "starts_limit_3_count_at_30min": 3,
    "starts_limit_3_count_at_60min": 2,
    "ramp_up_1p5s": 35.0,
    "ramp_up_3s": 50.0,
    "ramp_down_2s": 40.0,
    "ramp_down_4s": 30.0,
    "start_preset_first_step": 31.0,
    "start_preset_after_1s": 40.0,
}


def test_scenarios_match_numbers_in_st_tests() -> None:
    assert set(motor.SCENARIOS) == set(EXPECTED)
    for name, value in EXPECTED.items():
        assert motor.SCENARIOS[name] == value, f"{name}: модель {motor.SCENARIOS[name]!r}, в тесте ST {value!r}"


def test_run_accumulator_keeps_fraction() -> None:
    """Доля секунды остаётся в накопителе: 25 шагов по 100 мс — 2 с, ещё 5 — 3 с."""
    assert motor.run_seconds([0.1] * 30) == 3


def test_inhibit_remain_is_rounded_up_and_bounded() -> None:
    assert motor.inhibit_remain_s(30.0, 29.999) == 1
    assert motor.inhibit_remain_s(30.0, 31.0) == 0
    assert motor.ceil_seconds(10**18) == motor.UINT_MAX
