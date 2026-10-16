"""Эталоны tools/reference/pid.py против литералов тестов FB_Pid_Test.

Тест ST помечает ожидаемое значение строкой «// ref: <сценарий>.<ключ>» прямо перед ассертом.
Здесь каждая такая пара сверяется с расчётом pid.py: литерал Expected должен совпадать с эталоном
с запасом в 10 раз меньше допуска Delta ассерта (для ассертов без Delta — точно). Так число в тесте
нельзя поменять, не поменяв эталон, и наоборот. Отдельно проверяются свойства эталонов, на которые
опираются выводы тестов (anti-windup, одинаковый интеграл при разном dt, запас полосы
установления).

Запуск: python -m pytest (каталог входит в testpaths, pyproject.toml).
"""

from __future__ import annotations

import glob
import math
import os
import re
from dataclasses import dataclass

import common
import pid

SUITE_DIR = os.path.join(common.REPO_ROOT, "tests", "POUs", "Suites", "FB_Pid_Test")
_NUMBER = r"-?\d[\d_]*(?:\.\d+)?(?:[Ee][+-]?\d+)?"
_REF_RE = re.compile(r"//\s*ref:\s*(\w+)\.(\w+)")
_EXPECTED_RE = re.compile(rf"Expected\s*:=\s*({_NUMBER})\s*,")
_DELTA_RE = re.compile(rf"Delta\s*:=\s*({_NUMBER})\s*,")


@dataclass(frozen=True)
class Tagged:
    where: str
    scenario: str
    key: str
    literal: float
    delta: float


def tagged_expectations() -> list[Tagged]:
    rows: list[Tagged] = []
    for path in sorted(glob.glob(os.path.join(SUITE_DIR, "*.method.impl.st"))):
        with open(path, encoding="utf-8") as handle:
            lines = handle.read().splitlines()
        rel = os.path.relpath(path, common.REPO_ROOT).replace(os.sep, "/")
        for index, line in enumerate(lines):
            tag = _REF_RE.search(line)
            if tag is None:
                continue
            where = f"{rel}:{index + 1}"
            assert index + 1 < len(lines), f"{where}: после «// ref:» нет ассерта"
            assert_line = lines[index + 1]
            expected = _EXPECTED_RE.search(assert_line)
            assert expected is not None, f"{where}: в следующей строке нет «Expected := <число>,»"
            delta = _DELTA_RE.search(assert_line)
            rows.append(
                Tagged(
                    where=where,
                    scenario=tag.group(1),
                    key=tag.group(2),
                    literal=float(expected.group(1).replace("_", "")),
                    delta=float(delta.group(1)) if delta else 0.0,
                )
            )
    return rows


def test_suite_has_reference_tags() -> None:
    assert len(tagged_expectations()) >= 80


def test_tagged_literals_match_reference() -> None:
    for row in tagged_expectations():
        assert row.scenario in pid.SCENARIOS, f"{row.where}: нет сценария {row.scenario} в pid.py"
        result = pid.reference(row.scenario)
        assert row.key in result, f"{row.where}: в сценарии {row.scenario} нет ключа {row.key}"
        tolerance = row.delta / 10.0 if row.delta > 0.0 else 1.0e-9
        value = result[row.key]
        assert abs(row.literal - value) <= tolerance, (
            f"{row.where}: литерал {row.literal} != эталон {row.scenario}.{row.key} = {value:.6f} (допуск {tolerance})"
        )


def test_every_scenario_is_used_by_a_test() -> None:
    used = {row.scenario for row in tagged_expectations()}
    assert used == set(pid.SCENARIOS), f"сценарии без тестов: {sorted(set(pid.SCENARIOS) - used)}"


def test_reference_properties_behind_the_tests() -> None:
    ref = pid.reference
    # интеграл: скорость Kp·e/Ti
    assert math.isclose(ref("integral")["rate_pctps"], 2.0 * 4.0 / 10.0, abs_tol=1e-6)
    # фильтр Д: (Tf/(Tf + dt))^5 за Tf
    assert math.isclose(ref("d_filter")["ratio"], (0.5 / 0.6) ** 5, abs_tol=1e-6)
    # anti-windup: с обратным расчётом выход уходит с предела сразу, без него — нет и через Tt
    aw = ref("aw_recovery")
    assert aw["out_rev_aw"] < 100.0 and aw["out_tt_noaw"] == 100.0
    # внешний предел: с xUseOutAct механизм отвечает сразу, без него остаётся на минимуме
    act = ref("outact")
    assert act["out_rev_act"] > 30.0 > act["out_rev_noact"]
    # реальный dt: интеграл одинаков, выходы различаются на приращение одного шага
    real = ref("real_dt")
    assert math.isclose(real["i_10ms"], real["i_100ms"], abs_tol=1e-5)
    assert math.isclose(real["out_10ms"] - real["out_100ms"], 0.08 - 0.008, abs_tol=1e-5)
    # насыщение в контуре: обратный расчёт раньше снимает насыщение и убирает перерегулирование
    sat = ref("fopdt_sat")
    assert sat["unsat_aw"] < sat["unsat_noaw"] and sat["peak_aw"] <= 40.0 < sat["peak_noaw"]
    # время установления: PV на последнем выходе из полосы ±2 % далеко от её границы — расхождение
    # округления ST и Python (около 1e-6) момент не сдвинет
    assert ref("fopdt_step")["band_margin"] > 1.0e-3


def test_reference_rejects_invalid_cfg() -> None:
    """Сценарий с Cfg, которую FB_PID не примет (rSafeOut_pct вне пределов выхода), не считается."""
    try:
        pid.PidSim(pid.PidCfg(out_min=10.0))
    except ValueError:
        return
    raise AssertionError("PidSim принял Cfg с rSafeOut_pct < rOutMin_pct")
