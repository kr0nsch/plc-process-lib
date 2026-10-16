#!/usr/bin/env python3
"""Эталонные значения для тестов основы библиотеки (FB_Common_Test, FB_Util_Test, FB_Time_Test).

Только стандартная библиотека Python 3.11+ и разбор раскладки tools/codesys/stlayout.py.
Каждое число, которое тест берёт отсюда, помечено в комментарии теста:
«источник: tools/reference/common.py, сценарий <имя>».

Сценарии:
- ``sts_sizes``, ``cfg_sizes``, ``cmd_sizes``, ``retain_sizes`` — SIZEOF структур по исходникам
  src/DUTs/ и правилам раскладки CODESYS Control Win V3 (32 бит): поле 1, 2 или 4 байта
  выравнивается по своему размеру, структура — по наибольшему выравниванию полей, размер кратен
  выравниванию. 64-битных полей в этих структурах нет, поэтому правило для LTIME/LREAL (4 или
  8 байт — у 32-битных целей по-разному) на результат не влияет. Совпадение с компилятором:
  зонды контракта (ST_DeviceRetain = 36, ST_AlarmCfg = 16, ST_MotorSts = 68) и тесты
  Common_SizeOf* в CODESYS 3.5.17.30 (16.10.2026: все Sts, Cfg и Cmd совпали).
- ``rate_limit`` — шаги F_RateLimit;
- ``ltime_to_sec`` — перевод LTIME/TIME в секунды;
- ``starts_window`` — FB_StartsWindow.Count и TimeToFree.

Запуск: ``python tools/reference/common.py`` печатает все сценарии.
"""

from __future__ import annotations

import math
import os
import re
import sys
from dataclasses import dataclass

REFERENCE_DIR = os.path.dirname(os.path.abspath(__file__))
REPO_ROOT = os.path.dirname(os.path.dirname(REFERENCE_DIR))
sys.path.insert(0, os.path.join(REPO_ROOT, "tools", "codesys"))

import stlayout as L  # noqa: E402

# Размеры элементарных типов CODESYS, байт. Выравнивание = размер (не больше MAX_ALIGN).
ELEMENTARY_SIZES: dict[str, int] = {
    "BOOL": 1,
    "BYTE": 1,
    "SINT": 1,
    "USINT": 1,
    "WORD": 2,
    "INT": 2,
    "UINT": 2,
    "DWORD": 4,
    "DINT": 4,
    "UDINT": 4,
    "REAL": 4,
    "TIME": 4,
}
# 64-битные типы: выравнивание на 32-битной цели не подтверждено зондом — расчёт с ними отказывается
WIDE_TYPES = {"LWORD", "LINT", "ULINT", "LREAL", "LTIME"}
MAX_ALIGN = 4

_ARRAY_RE = re.compile(r"^ARRAY\s*\[(?P<lo>[^.\]]+)\.\.(?P<hi>[^\]]+)\]\s*OF\s+(?P<elem>\w+)$", re.IGNORECASE)


@dataclass(frozen=True)
class Layout:
    size: int
    align: int


class LayoutError(Exception):
    pass


def _align_up(value: int, align: int) -> int:
    return (value + align - 1) // align * align


def load_constants(root: str = REPO_ROOT) -> dict[str, int]:
    """Целочисленные константы GVL_Const (для границ массивов)."""
    path = os.path.join(root, "src", "GVLs", "GVL_Const.gvl.st")
    text = L.read_text(path)
    result: dict[str, int] = {}
    for block in L.parse_var_blocks(text):
        for decl in block.decls:
            init = (decl.init_text or "").strip()
            value: int | None = None
            if re.fullmatch(r"\d+", init):
                value = int(init)
            elif re.fullmatch(r"16#[0-9A-Fa-f_]+", init):
                value = int(init[3:].replace("_", ""), 16)
            if value is not None:
                for name in decl.name_list:
                    result[name] = value
    return result


def load_types(root: str = REPO_ROOT) -> dict[str, L.TypeDecl]:
    """Все DUT из src/DUTs/ (по имени)."""
    scan = L.scan(root, "src")
    types: dict[str, L.TypeDecl] = {}
    for obj in scan.objects:
        if obj.kind == L.KIND_DUT:
            tdecl = L.parse_type_decl(obj.decl)
            if tdecl is not None:
                types[obj.name] = tdecl
    return types


class LayoutCalc:
    """SIZEOF структур по правилам раскладки (см. docstring модуля)."""

    def __init__(self, root: str = REPO_ROOT) -> None:
        self.types = load_types(root)
        self.constants = load_constants(root)
        self._cache: dict[str, Layout] = {}

    def _eval_bound(self, text: str) -> int:
        """Граница массива: целые и константы GVL_Const, соединённые + и -."""
        expr = text.strip()
        for name, value in self.constants.items():
            expr = re.sub(rf"\bGVL_Const\.{name}\b", str(value), expr)
        tokens = re.findall(r"\d+|[+-]|\S", expr)
        if not tokens or not tokens[0].isdigit():
            raise LayoutError(f"граница массива не вычисляется: {text}")
        total = int(tokens[0])
        for k in range(1, len(tokens), 2):
            op = tokens[k]
            arg = tokens[k + 1] if k + 1 < len(tokens) else ""
            if op not in "+-" or not arg.isdigit():
                raise LayoutError(f"граница массива не вычисляется: {text}")
            total = total + int(arg) if op == "+" else total - int(arg)
        return total

    def of_type(self, type_text: str) -> Layout:
        text = " ".join(type_text.split())
        upper = text.upper()
        if upper in ELEMENTARY_SIZES:
            size = ELEMENTARY_SIZES[upper]
            return Layout(size, min(size, MAX_ALIGN))
        if upper in WIDE_TYPES:
            raise LayoutError(f"64-битный тип {text}: выравнивание на 32-битной цели не подтверждено")
        match = _ARRAY_RE.match(text)
        if match:
            count = self._eval_bound(match.group("hi")) - self._eval_bound(match.group("lo")) + 1
            elem = self.of_type(match.group("elem"))
            return Layout(elem.size * count, elem.align)
        return self.of_dut(text)

    def of_dut(self, name: str) -> Layout:
        if name in self._cache:
            return self._cache[name]
        if name not in self.types:
            raise LayoutError(f"неизвестный тип {name}")
        tdecl = self.types[name]
        if tdecl.kind == "enum":
            base = (tdecl.enum_base_type or "INT").strip()
            layout = self.of_type(base)
        elif tdecl.kind in ("struct", "union"):
            offset = 0
            align = 1
            for member in tdecl.members:
                field = self.of_type(member.type_text)
                align = max(align, field.align)
                for _ in member.name_list:
                    if tdecl.kind == "struct":
                        offset = _align_up(offset, field.align) + field.size
                    else:
                        offset = max(offset, field.size)
            layout = Layout(_align_up(offset, align), align)
        else:
            raise LayoutError(f"тип {name}: вид {tdecl.kind} не поддерживается")
        self._cache[name] = layout
        return layout

    def size(self, name: str) -> int:
        return self.of_dut(name).size


# Таблица 4.6 контракта: Sts — карта регистров Modbus (байт)
STS_CONTRACT: dict[str, int] = {
    "ST_DeviceSts": 28,
    "ST_AnalogInputSts": 44,
    "ST_DigitalInputSts": 30,
    "ST_MotorSts": 68,
    "ST_ValveSts": 52,
    "ST_ControlValveSts": 52,
    "ST_PidSts": 64,
}
CFG_TYPES = (
    "ST_AlarmCfg",
    "ST_AiLimitCfg",
    "ST_AnalogInputCfg",
    "ST_DigitalInputCfg",
    "ST_MotorCfg",
    "ST_VfdCfg",
    "ST_ValveCfg",
    "ST_ControlValveCfg",
    "ST_PidCfg",
)
CMD_TYPES = (
    "ST_DeviceCmd",
    "ST_AnalogInputCmd",
    "ST_DigitalInputCmd",
    "ST_MotorCmd",
    "ST_ValveCmd",
    "ST_ControlValveCmd",
    "ST_PidCmd",
)
RETAIN_TYPES = ("ST_DeviceRetain", "U_RealBits")


def sizes(names: tuple[str, ...] | list[str], root: str = REPO_ROOT) -> dict[str, int]:
    calc = LayoutCalc(root)
    return {name: calc.size(name) for name in names}


# ---------------------------------------------------------------------------
# F_RateLimit
# ---------------------------------------------------------------------------


def is_finite_real(value: float, sane_max: float = 1.0e30) -> bool:
    """F_IsFinite: не NaN, не ±Inf и |x| <= REAL_SANE_MAX."""
    return math.isfinite(value) and abs(value) <= sane_max


def rate_limit(current: float, target: float, rate_up: float, rate_down: float, dt_s: float) -> float:
    """Шаг F_RateLimit (в LREAL, как в ST; округление до REAL здесь не моделируется)."""
    if dt_s <= 0.0 or not is_finite_real(target):
        return current
    if target > current and rate_up > 0.0:
        return min(target, current + rate_up * dt_s)
    if target < current and rate_down > 0.0:
        return max(target, current - rate_down * dt_s)
    return target


RATE_LIMIT_SCENARIOS: list[tuple[str, float, float, float, float, float]] = [
    # (название, текущее, цель, рост ед./с, спад ед./с, шаг с)
    ("рост 10/с, шаг 0,5 с", 20.0, 80.0, 10.0, 2.0, 0.5),
    ("спад 2/с, шаг 0,5 с", 80.0, 20.0, 10.0, 2.0, 0.5),
    ("рост 10/с, шаг 0,25 с", 25.0, 80.0, 10.0, 2.0, 0.25),
    ("спад 2/с, шаг 0,25 с", 79.0, 20.0, 10.0, 2.0, 0.25),
    ("рост без ограничения", 20.0, 80.0, 0.0, 5.0, 1.0),
    ("спад 5/с при росте без ограничения", 80.0, 20.0, 0.0, 5.0, 1.0),
    ("малый шаг до цели (рост)", 49.5, 50.0, 10.0, 10.0, 1.0),
    ("малый шаг до цели (спад)", 50.4, 50.0, 10.0, 10.0, 0.1),
]


# ---------------------------------------------------------------------------
# Время
# ---------------------------------------------------------------------------

NS_PER_S = 1_000_000_000
MS_PER_S = 1000
TIME_MAX_MS = 2**32 - 1  # T#49D17H2M47S295MS


def ltime_to_sec(ns: int) -> float:
    return ns / NS_PER_S


def time_to_sec(ms: int) -> float:
    return ms / MS_PER_S


LTIME_SCENARIOS: list[tuple[str, float]] = [
    ("LTIME#1S", ltime_to_sec(NS_PER_S)),
    ("LTIME#1MS", ltime_to_sec(NS_PER_S // 1000)),
    ("LTIME#1NS", ltime_to_sec(1)),
    ("LTIME#100D", ltime_to_sec(100 * 86400 * NS_PER_S)),
    ("T#1500MS", time_to_sec(1500)),
    ("T#49D17H2M47S295MS", time_to_sec(TIME_MAX_MS)),
]


# ---------------------------------------------------------------------------
# FB_StartsWindow (время — в секундах от нуля для наглядности)
# ---------------------------------------------------------------------------

WINDOW_S = 3600


def window_count(starts: list[float], now: float) -> int:
    return sum(1 for t in starts if t <= now and now - t < WINDOW_S)


def window_time_to_free(starts: list[float], now: float, limit: int) -> float:
    """Через сколько секунд пусков в окне станет меньше limit (0 — уже меньше или limit = 0)."""
    inside = sorted(t for t in starts if t <= now and now - t < WINDOW_S)
    if limit == 0 or len(inside) < limit:
        return 0.0
    return inside[len(inside) - limit] + WINDOW_S - now


H = 3600.0
M = 60.0
STARTS_SCENARIOS: list[tuple[str, list[float], float, int]] = [
    # (название, отметки пусков, сейчас, лимит)
    ("3 пуска, лимит 3, в 1:30", [1 * H, 1 * H + 10 * M, 1 * H + 20 * M], 1 * H + 30 * M, 3),
    ("3 пуска, лимит 2, в 1:30", [1 * H, 1 * H + 10 * M, 1 * H + 20 * M], 1 * H + 30 * M, 2),
    ("3 пуска, лимит 4, в 1:30", [1 * H, 1 * H + 10 * M, 1 * H + 20 * M], 1 * H + 30 * M, 4),
    ("3 пуска, лимит 3, в 2:00", [1 * H, 1 * H + 10 * M, 1 * H + 20 * M], 2 * H, 3),
    # кольцо на 30: из 31 пуска с шагом 1 мин (1:00…1:30) остаются 1:01…1:30
    ("кольцо: 30 последних из 31, лимит 30, в 1:30", [1 * H + k * M for k in range(1, 31)], 1 * H + 30 * M, 30),
]


def main() -> int:
    reconfigure = getattr(sys.stdout, "reconfigure", None)
    if reconfigure is not None:  # консоль Windows: вывод по-русски в UTF-8
        reconfigure(encoding="utf-8")
    calc = LayoutCalc()
    print("sts_sizes (таблица 4.6 контракта):")
    for name, expected in STS_CONTRACT.items():
        got = calc.size(name)
        mark = "OK" if got == expected else f"ОТЛИЧАЕТСЯ от контракта ({expected})"
        print(f"  {name:22} {got:4}  {mark}")
    for title, names in (("cfg_sizes", CFG_TYPES), ("cmd_sizes", CMD_TYPES), ("retain_sizes", RETAIN_TYPES)):
        print(f"{title}:")
        for name in names:
            print(f"  {name:22} {calc.size(name):4}")
    print("rate_limit:")
    for title, cur, tgt, up, down, dt in RATE_LIMIT_SCENARIOS:
        print(f"  {title:38} {cur} -> {tgt}: {rate_limit(cur, tgt, up, down, dt)!r}")
    print("ltime_to_sec:")
    for title, value in LTIME_SCENARIOS:
        print(f"  {title:22} {value!r} s")
    print("starts_window:")
    for title, starts, now, limit in STARTS_SCENARIOS:
        count = window_count(starts, now)
        free = window_time_to_free(starts, now, limit)
        print(f"  {title:44} Count = {count}, TimeToFree = {free:.0f} s ({free / 60:.0f} мин)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
