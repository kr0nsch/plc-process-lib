"""Эталоны tools/reference/ai_reference.py против чисел в тестах FB_AnalogInput_Test.

Тест ST берёт ожидаемое значение из сценария эталона и пишет его литералом с комментарием-источником.
Здесь проверяется, что литерал в тесте совпадает со сценарием (в пределах допуска ассерта) и что
сценарии эталона не разошлись с моделью цепочки 11.3. Падает, если поменяли число только в тесте или
только в эталоне.

Запуск: python -m pytest (каталог входит в testpaths, pyproject.toml).
"""

from __future__ import annotations

import math
import os
import re

import pytest

import ai_reference as ref
import common

SUITE = os.path.join(common.REPO_ROOT, "tests", "POUs", "Suites", "FB_AnalogInput_Test")


def scale_value(title: str) -> float:
    for name, cfg, r_in in ref.SCALE_SCENARIOS:
        if name == title:
            return ref.to_real(ref.scale(cfg, r_in))
    raise KeyError(title)


def filter_value(title: str) -> float:
    for name, t_s, start, target, steps in ref.FILTER_SCENARIOS:
        if name == title:
            return ref.to_real(ref.filter_steps(t_s, start, target, steps))
    raise KeyError(title)


# (метод-тест, литерал Expected в тесте, значение эталона, допуск ассерта)
CITED: list[tuple[str, str, float, float]] = [
    ("Scale4mAReturnsRangeLo", "2.0", scale_value("4 мА, шкала 2..12"), 1.0e-5),
    ("Scale20mAReturnsRangeHi", "12.0", scale_value("20 мА, шкала 2..12"), 1.0e-5),
    ("Scale12mAReturnsMidRange", "7.0", scale_value("12 мА, шкала 2..12"), 1.0e-5),
    ("Norm420ScalesLikeMilliamps", "7.0", scale_value("Norm420 0,5, шкала 2..12"), 1.0e-5),
    ("Norm01NoNe43Check", "-3.0", scale_value("Norm01 -0,03, шкала 0..100"), 1.0e-4),
    ("Norm01NoNe43Check", "70.0", scale_value("Norm01 0,7, шкала 0..100"), 1.0e-4),
    ("EngInputPassesThrough", "123.4", scale_value("Eng 123,4, шкала -50..150"), 1.0e-4),
    ("RawInputScalesCounts", "8.0", scale_value("Raw 6000, 2000..10000 -> 0..16"), 1.0e-5),
    ("RawInputScalesCounts", "-2.0", scale_value("Raw 1000 (ниже RawLo)"), 1.0e-5),
    ("At3p7mAIsOutOfSpecification", "-1.875", scale_value("3,7 мА, шкала 0..100 (экстраполяция)"), 1.0e-4),
    ("At20p7mAIsOutOfSpecification", "104.375", scale_value("20,7 мА, шкала 0..100 (экстраполяция)"), 1.0e-4),
    ("Sqrt25PctDpReturns50PctFlow", "50.0", scale_value("корень: 8 мА (25 % перепада), 0..100"), 1.0e-4),
    ("LowCutBelowCutReturnsZero", "9.999995", scale_value("корень: 4,16 мА (1 %), отсечка 5 %"), 1.0e-4),
    ("ClampLimitsToRange", "102.5", scale_value("20,4 мА без ограничения"), 1.0e-4),
    (
        "FilterOneTimeConstantReaches63Pct",
        "62.84233",
        filter_value("ступень 0 -> 100, T = 10 с, 99 шагов по 0,1 с"),
        1.0e-3,
    ),
    (
        "FilterOneTimeConstantReaches63Pct",
        "63.21206",
        filter_value("ступень 0 -> 100, T = 10 с, 100 шагов по 0,1 с"),
        1.0e-3,
    ),
    ("FilterIndependentOfCycleTime", "39.34694", filter_value("ступень 0 -> 100, T = 10 с, 5 с шагом 10 мс"), 1.0e-3),
]


@pytest.mark.parametrize(("method", "literal", "value", "delta"), CITED)
def test_cited_value_matches_reference(method: str, literal: str, value: float, delta: float) -> None:
    with open(os.path.join(SUITE, f"{method}.method.impl.st"), encoding="utf-8") as handle:
        text = handle.read()
    assert re.search(rf"Expected := {re.escape(literal)},", text), f"{method}: нет Expected := {literal}"
    with open(os.path.join(SUITE, f"{method}.method.decl.st"), encoding="utf-8") as handle:
        assert "ai_reference.py" in handle.read(), f"{method}: нет ссылки на эталон в комментарии теста"
    assert abs(float(literal) - value) <= delta / 10, f"{method}: {literal} против эталона {value!r}"


def test_filter_step_independence() -> None:
    """Точная экспонента: одинаковый результат при любом шаге; неявный Эйлер — нет."""
    values = [
        ref.filter_steps(10.0, 0.0, 100.0, steps) for steps in (ref.STEP_10MS, ref.STEP_250MS, ref.STEP_IRREGULAR)
    ]
    assert max(values) - min(values) < 1.0e-9
    assert values[0] == pytest.approx(100.0 * (1.0 - math.exp(-0.5)), abs=1.0e-9)
    assert abs(ref.implicit_euler(10.0, 0.0, 100.0, ref.STEP_250MS) - values[0]) > 0.1


def test_scale_model_basics() -> None:
    """Опорные точки модели: 4/12/20 мА, корень 25 % -> 50 %, отсечка, ограничение шкалой."""
    cfg = ref.AiCfg(range_lo=2.0, range_hi=12.0)
    assert [ref.scale(cfg, ma) for ma in (4.0, 12.0, 20.0)] == [2.0, 7.0, 12.0]
    assert ref.scale(ref.AiCfg(sqrt=True), 8.0) == pytest.approx(50.0)
    assert ref.scale(ref.AiCfg(sqrt=True, low_cut_pct=5.0), 4.032) == 0.0
    assert ref.scale(ref.AiCfg(clamp=True), 20.4) == 100.0
