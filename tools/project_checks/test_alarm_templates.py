"""docs/alarm_templates.csv — шаблоны текстов тревог библиотеки (контракт API.md, раздел 19) против слотов.

Файл читает генератор iolistgen (опция ``templates`` генераторов alarm-list и scada-csv): по строке на каждый
используемый слот каждого типа, колонки ``type;slot;suffix;text_ru;operator_action;cause;consequence``. Здесь
проверяется, что набор строк совпадает с перечислениями слотов ``E_<Dev>Alarm``, числом слотов
``<DEV>_ALARM_COUNT`` и суффиксами таблицы раздела 19, а тексты и действия оператора не пустые.

Запуск: python -m pytest (каталог входит в testpaths, pyproject.toml).
"""

from __future__ import annotations

import csv
import os
import re

import common
import stlayout as L

REPO_ROOT = common.REPO_ROOT
CSV_PATH = os.path.join(REPO_ROOT, "docs", "alarm_templates.csv")
COLUMNS = ["type", "slot", "suffix", "text_ru", "operator_action", "cause", "consequence"]

# тип в шаблонах -> (перечисление слотов, число слотов в GVL_Const, строка таблицы раздела 19, слоты типа)
TYPES: dict[str, tuple[str, str, str, range | None]] = {
    "AnalogInput": ("E_AiAlarm", "AI_ALARM_COUNT", "AnalogInput", None),
    "DigitalInput": ("E_DiAlarm", "DI_ALARM_COUNT", "DigitalInput", None),
    "Motor": ("E_MotorAlarm", "MOT_ALARM_COUNT", "Motor / MotorVfd", range(0, 6)),
    "MotorVfd": ("E_MotorAlarm", "MOT_ALARM_COUNT", "Motor / MotorVfd", range(6, 8)),
    "Valve": ("E_ValveAlarm", "VLV_ALARM_COUNT", "Valve", None),
    "ControlValve": ("E_CvAlarm", "CV_ALARM_COUNT", "ControlValve", None),
    "Pid": ("E_PidAlarm", "PID_ALARM_COUNT", "PID", None),
}


def rows() -> list[dict[str, str]]:
    with open(CSV_PATH, encoding="utf-8", newline="") as handle:
        reader = csv.DictReader(handle, delimiter=";")
        assert reader.fieldnames == COLUMNS, reader.fieldnames
        result = list(reader)
    for row in result:
        # «;» внутри поля сдвинула бы колонки: лишние значения DictReader кладёт под ключ None
        assert None not in row and all(value is not None for value in row.values()), f"{row}: число колонок"
    return result


def slot_enums() -> dict[str, list[str]]:
    result: dict[str, list[str]] = {}
    for obj in L.scan(REPO_ROOT, "src").objects:
        if obj.kind == L.KIND_DUT and re.fullmatch(r"E_\w+Alarm", obj.name):
            decl = L.parse_type_decl(obj.decl)
            assert decl is not None
            result[obj.name] = [name for name, _, _ in decl.enum_values]
    return result


def alarm_counts() -> dict[str, int]:
    gvl = L.scan(REPO_ROOT, "src").find("GVL_Const")
    assert gvl is not None
    result: dict[str, int] = {}
    for block in L.parse_var_blocks(gvl.decl):
        for decl in block.decls:
            for name in decl.name_list:
                if name.endswith("_ALARM_COUNT"):
                    result[name] = int(decl.init_text or "0")
    return result


def section19_suffixes() -> dict[str, list[str]]:
    with open(os.path.join(REPO_ROOT, "docs", "API.md"), encoding="utf-8") as handle:
        text = handle.read()
    part = text[text.index("## 19.") : text.index("## 20.")]
    result: dict[str, list[str]] = {}
    for name, cells in re.findall(r"^\| ([\w /]+) \| (`.*`) \|$", part, re.M):
        result[name.strip()] = re.findall(r"`(\w+)`", cells)
    return result


def test_templates_cover_every_used_slot_once() -> None:
    enums = slot_enums()
    counts = alarm_counts()
    suffixes = section19_suffixes()
    expected: set[tuple[str, int, str]] = set()
    for type_name, (enum, count, table_row, slots) in TYPES.items():
        used = range(counts[count]) if slots is None else slots
        assert len(enums[enum]) == counts[count], f"{enum}: слотов {len(enums[enum])}, {count} = {counts[count]}"
        for slot in used:
            expected.add((type_name, slot, suffixes[table_row][slot]))
    actual = [(row["type"], int(row["slot"]), row["suffix"]) for row in rows()]
    assert len(actual) == len(set(actual)), "строки шаблонов повторяются"
    assert set(actual) == expected, sorted(set(actual) ^ expected)


def test_templates_have_texts() -> None:
    for row in rows():
        where = f"{row['type']}.{row['slot']}"
        assert row["text_ru"].strip(), f"{where}: нет text_ru"
        assert row["operator_action"].strip(), f"{where}: нет operator_action"
        assert row["cause"].strip() and row["consequence"].strip(), f"{where}: нет cause или consequence"
