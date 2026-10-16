"""Эталоны тестов арматуры (tools/reference/valve_reference.py) против чисел в тестах ST.

Тесты FB_Valve_Test и FB_ControlValve_Test берут ожидаемые значения из сценариев эталона и ссылаются
на них комментарием. Здесь проверяется, что сценарии дают именно эти числа: изменение модели без
правки тестов ST (или наоборот) ловит pytest.

Запуск: python -m pytest (каталог входит в testpaths, pyproject.toml).
"""

from __future__ import annotations

import pytest

import valve_reference as vr


def test_cv_ramp_scenarios_match_st_expectations() -> None:
    s = vr.scenarios()
    assert s["cv_manual_ramp"]["up 1.0 s"] == pytest.approx(10.0, abs=1e-4)
    assert s["cv_manual_ramp"]["up 4.9 s"] == pytest.approx(49.0, abs=1e-4)
    assert s["cv_manual_ramp"]["up 5.0 s"] == pytest.approx(50.0, abs=1e-4)
    assert s["cv_manual_ramp"]["down 1.0 s"] == pytest.approx(30.0, abs=1e-4)
    assert s["cv_manual_ramp"]["down 2.0 s"] == pytest.approx(10.0, abs=1e-4)
    assert s["cv_manual_ramp"]["mA at 10 %"] == pytest.approx(5.6, abs=1e-4)
    assert s["cv_return_ramp"]["10 -> 60, 1 %/s, 1 s"] == pytest.approx(11.0, abs=1e-4)
    assert s["cv_return_ramp"]["20 -> 50, 10 %/s, 1.0 s"] == pytest.approx(30.0, abs=1e-4)
    assert s["cv_bumpless"]["70 -> 60, 5 %/s, 1.0 s"] == pytest.approx(65.0, abs=1e-4)
    assert s["cv_positioner"]["100 -> 40, 2 %/s, 1.0 s"] == pytest.approx(98.00003, abs=1e-4)


def test_cv_tight_shut_ramp_is_not_stuck_below_threshold() -> None:
    s = vr.scenarios()["cv_tight_ramp"]
    assert s["ramp 4.5 s"] == pytest.approx(4.5)
    assert s["out 4.5 s"] == 0.0
    assert s["out 5.0 s"] == pytest.approx(5.0, abs=1e-4)
    assert s["out 10.0 s"] == pytest.approx(10.0, abs=1e-4)
    assert (s["out at sp 4"], s["out at sp 6"]) == (0.0, 6.0)


def test_cv_ramp_independent_of_cycle_time() -> None:
    s = vr.scenarios()["cv_cycle_independence"]
    assert s["10 ms x 200"] == pytest.approx(20.0, abs=1e-4)
    assert s["100 ms x 20"] == pytest.approx(20.0, abs=1e-4)
    assert s["10 ms x 200"] != s["100 ms x 20"]  # округление REAL на шаге видно, но в допуске теста


def test_cv_output_current() -> None:
    s = vr.scenarios()["cv_ma"]
    assert (s["0 %"], s["0 % inverted"], s["25 %"], s["25 % inverted"], s["100 % inverted"]) == (
        4.0,
        20.0,
        8.0,
        16.0,
        4.0,
    )
    assert s["30 %"] == pytest.approx(8.8, abs=1e-5)


def test_valve_travel_remain_rounds_up() -> None:
    s = vr.scenarios()["valve_travel_remain"]
    assert (s["elapsed 0 s"], s["elapsed 2.0 s"], s["elapsed 2.05 s"], s["elapsed 9.9 s"]) == (10, 8, 8, 1)


def test_valve_act_time_accumulator() -> None:
    s = vr.scenarios()["valve_act_time"]
    assert s["12.5 s by 0.1 s: seconds"] == 12
    assert s["12.5 s by 0.1 s: accumulator"] == pytest.approx(0.5)
    assert s["one 60 s step: seconds"] == 10
    assert s["hours of 7190 + 12 s"] == pytest.approx(2.0005555, abs=1e-6)


def test_rate_limit_matches_f_ratelimit_rules() -> None:
    """Правила F_RateLimit: dt <= 0 или цель не число — без изменения, скорость 0 — сразу к цели."""
    assert vr.rate_limit(20.0, 80.0, 10.0, 10.0, 0.0) == 20.0
    assert vr.rate_limit(20.0, float("nan"), 10.0, 10.0, 0.1) == 20.0
    assert vr.rate_limit(20.0, 80.0, 0.0, 10.0, 0.1) == 80.0
    assert vr.rate_limit(80.0, 20.0, 10.0, 0.0, 0.1) == 20.0
