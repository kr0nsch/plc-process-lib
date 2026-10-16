"""Проверки соглашений библиотеки, которые не ловят линтер и компилятор CODESYS.

1. Регистрация наборов coUnit (docs/TESTING.md): набор, объявленный в GVL без
   {attribute 'linkalways'}, или тест-метод, который тело набора не вызывает, молча не выполняются —
   CODESYS 3.5.17 компилирует только объекты, достижимые из задач.
2. Имена тестов: TEST('<Fb>_<Case>_<Expectation>'), имя метода — без первого сегмента и без
   подчёркиваний (A-08), имена тестов уникальны во всей библиотеке.
3. GVL_Const и DUT против контракта API.md: значения констант, карты битов, коды перечислений,
   состав DUT, размеры структур обмена (таблица 4.6).

Запуск: python -m pytest (каталог входит в testpaths, pyproject.toml).
"""

from __future__ import annotations

import os
import re

import pytest

import common
import stlayout as L

REPO_ROOT = common.REPO_ROOT
_SCAN_CACHE: dict[str, L.ScanResult] = {}


def scan(subdir: str) -> L.ScanResult:
    if subdir not in _SCAN_CACHE:
        _SCAN_CACHE[subdir] = L.scan(REPO_ROOT, subdir)
    return _SCAN_CACHE[subdir]


def code_text(text: str) -> str:
    """Текст без комментариев (для поиска вызовов)."""
    return L.strip_comments(text, pragmas=False)


def suites() -> list[L.StObject]:
    """Наборы coUnit: FUNCTION_BLOCK ... EXTENDS coUnit.FB_TestSuite в tests/."""
    return [
        obj
        for obj in scan("tests").objects
        if obj.kind == L.KIND_POU
        and obj.header is not None
        and any(base.lower() == "counit.fb_testsuite" for base in obj.header.extends)
    ]


_TEST_RE = re.compile(r"coUnit\.TEST\s*\(\s*'(?P<name>[^']*)'\s*\)", re.IGNORECASE)
_FINISHED_RE = re.compile(r"coUnit\.TEST_FINISHED\s*\(\s*\)", re.IGNORECASE)


def suite_cases(suite: L.StObject) -> list[tuple[L.StMethod, str]]:
    """(метод, имя TEST) для методов набора, которые объявляют тест."""
    result = []
    for method in suite.methods:
        match = _TEST_RE.search(method.impl or "")
        if match:
            result.append((method, match.group("name")))
    return result


def suite_gvls() -> list[L.StObject]:
    """GVL наборов: tests/GVLs/GVL_Tests<Семейство>.gvl.st."""
    return [obj for obj in scan("tests").objects if obj.kind == L.KIND_GVL]


# ---------------------------------------------------------------------------
# 1. Регистрация наборов
# ---------------------------------------------------------------------------


def test_layout_is_valid() -> None:
    for subdir in ("src", "tests"):
        result = scan(subdir)
        assert result.ok, [issue.format() for issue in result.errors]


def test_suites_exist() -> None:
    assert suites(), "в tests/ нет наборов coUnit"


def test_suite_gvls_are_linked_always() -> None:
    """Каждая GVL наборов — с {attribute 'linkalways'}: без него CODESYS не включает её в приложение."""
    gvls = suite_gvls()
    assert gvls, "нет tests/GVLs/GVL_Tests<Семейство>.gvl.st"
    for gvl in gvls:
        assert gvl.name.startswith("GVL_Tests"), f"{gvl.name}: GVL наборов называется GVL_Tests<Семейство>"
        assert re.search(r"\{\s*attribute\s+'linkalways'\s*\}", gvl.decl), (
            f"{gvl.name}: нет {{attribute 'linkalways'}} — наборы этой GVL не выполнятся"
        )


def _instances(objects: list[L.StObject]) -> dict[str, list[str]]:
    """Тип набора -> где объявлены его экземпляры."""
    names = {s.name.lower() for s in suites()}
    found: dict[str, list[str]] = {}
    for obj in objects:
        for block in L.parse_var_blocks(obj.decl):
            for decl in block.decls:
                type_name = decl.type_text.strip().lower()
                if type_name in names:
                    for name in decl.name_list:
                        found.setdefault(type_name, []).append(f"{obj.name}.{name}")
    return found


def test_every_suite_registered_once_in_a_test_gvl() -> None:
    found = _instances(suite_gvls())
    for suite in suites():
        where = found.get(suite.name.lower(), [])
        assert len(where) == 1, f"{suite.name}: экземпляр должен быть ровно один в tests/GVLs/, найдено {where}"


def test_prg_tests_has_no_suite_instances() -> None:
    """PRG_Tests не правит ни одна команда: в нём только coUnit.RUN()."""
    prg = scan("tests").find("PRG_Tests")
    assert prg is not None
    assert not _instances([prg]), "экземпляры наборов объявляются в tests/GVLs/, а не в PRG_Tests"
    assert re.search(r"coUnit\.RUN\s*\(\s*\)", code_text(prg.impl or ""), re.IGNORECASE)


def test_suite_body_calls_every_test_method() -> None:
    for suite in suites():
        body = code_text(suite.impl or "")
        for method, _ in suite_cases(suite):
            call = re.compile(rf"(?<![\w.]){re.escape(method.name)}\s*\(\s*\)\s*;", re.IGNORECASE)
            assert call.search(body), f"{suite.name}: тело набора не вызывает {method.name}() — тест не выполнится"


# ---------------------------------------------------------------------------
# 2. Имена тестов
# ---------------------------------------------------------------------------


# Имена из списка 23.2 контракта, в которых два сегмента вместо трёх: имя контракта нормативно
CONTRACT_TWO_SEGMENT_NAMES = {
    "Alarm_SeqIncrementsOnEachTransition",
    "MotorVfd_SpeedClampedToMinMax",
    "MotorVfd_StartPresetsRampToMin",
    "MotorVfd_StopSetsRefZero",
    "Valve_NeverBothOutputs",
}


def test_test_names_follow_the_convention() -> None:
    seen: dict[str, str] = {}
    for suite in suites():
        for method, test in suite_cases(suite):
            where = f"{suite.name}.{method.name}"
            assert test in CONTRACT_TWO_SEGMENT_NAMES or re.fullmatch(r"[A-Z][A-Za-z0-9]*(_[A-Za-z0-9]+){2,}", test), (
                f"{where}: имя теста '{test}' — вида <Fb>_<Case>_<Expectation>"
            )
            expected = "".join(test.split("_")[1:])
            assert method.name == expected, f"{where}: имя метода должно быть {expected} (A-08)"
            assert re.search(r"\bMETHOD\s+PRIVATE\b", method.decl, re.IGNORECASE), (
                f"{where}: метод-тест объявляется METHOD PRIVATE"
            )
            assert test.lower() not in seen, f"тест '{test}' повторяется: {seen.get(test.lower())} и {where}"
            seen[test.lower()] = where
            assert _FINISHED_RE.search(method.impl or ""), f"{where}: нет coUnit.TEST_FINISHED()"


def test_no_real_time_timers_in_tests() -> None:
    """Время в тестах — только FB_FakeTime: TON/TOF/TP запрещены (контракт, 23.1)."""
    for obj in scan("tests").objects:
        for rel, text in L.object_files(obj):
            for block in L.parse_var_blocks(text):
                for decl in block.decls:
                    assert decl.type_text.strip().upper() not in {"TON", "TOF", "TP"}, f"{rel}: {decl.name_list}"


# ---------------------------------------------------------------------------
# 3. GVL_Const и DUT против контракта
# ---------------------------------------------------------------------------

# Таблица 5.1 контракта: имя -> (тип, значение как в исходнике)
CONTRACT_CONSTANTS: dict[str, tuple[str, str]] = {
    "NE43_FAIL_LOW_MA": ("REAL", "3.6"),
    "NE43_MEAS_LOW_MA": ("REAL", "3.8"),
    "NE43_MEAS_HIGH_MA": ("REAL", "20.5"),
    "NE43_FAIL_HIGH_MA": ("REAL", "21.0"),
    "MA_ZERO": ("REAL", "4.0"),
    "MA_SPAN": ("REAL", "16.0"),
    "PCT_FULL": ("REAL", "100.0"),
    "REAL_SANE_MAX": ("REAL", "1.0E30"),
    "AI_LOWCUT_MAX_PCT": ("REAL", "20.0"),
    "NS_PER_S": ("LREAL", "1.0E9"),
    "MS_PER_S": ("LREAL", "1000.0"),
    "S_PER_H": ("UDINT", "3600"),
    "DT_ACCUM_MAX": ("LTIME", "LTIME#10S"),
    "DEV_ALARMS_MAX": ("UINT", "8"),
    "NO_FIRST_OUT": ("UINT", "16#FFFF"),
    "WORD_ALL": ("WORD", "16#FFFF"),
    "UINT_MAX": ("UINT", "65535"),
    "STARTS_WINDOW_MAX": ("UINT", "30"),
    "STARTS_WINDOW": ("LTIME", "LTIME#1H"),
    "PID_DFILTER_N_MIN": ("REAL", "2.0"),
    "PID_DFILTER_N_MAX": ("REAL", "50.0"),
    "PID_DEADBAND_MAX_PCT": ("REAL", "10.0"),
    "REAL_EXP_MASK": ("DWORD", "16#7F800000"),
    "WORD_LOW_BYTE": ("WORD", "16#00FF"),
}


def _seq(*names: str) -> dict[str, int]:
    """Биты подряд с нуля: номер бита — позиция имени."""
    return {name: bit for bit, name in enumerate(names)}


# Карты битов разделов 5.2, 11.5, 12.4, 13.9, 15.5, 16.4, 17.6: <ПРЕФИКС>_<СЛОВО> -> {имя: бит}
BIT_MAPS: dict[str, dict[str, int]] = {
    "DEV_STS": {
        "MODE_AUTO": 8,
        "MODE_MANUAL": 9,
        "MODE_LOCAL": 10,
        "MODE_OOS": 11,
        "CFG_ERROR": 12,
        "FAILURE": 13,
        "WARNING": 14,
        "ALARM_UNACK": 15,
    },
    "AI_STS": _seq("HH", "H", "L", "LL", "SIGNAL_FAIL", "OUT_OF_RANGE", "FAIL_PENDING", "LOW_CUT"),
    "AI_FLT": _seq("FAIL_LOW", "FAIL_HIGH", "CHANNEL", "NOT_FINITE"),
    "AI_WRN": _seq("UNDER_RANGE", "OVER_RANGE", "CLAMPED"),
    "AI_CFG": _seq(
        "INPUT_TYPE",
        "RANGE",
        "LIMIT_ORDER",
        "LIMIT_OUT_OF_RANGE",
        "HYST",
        "LOW_CUT",
        "FAIL_VALUE",
        "ALARM",
        "RAW_RANGE",
    ),
    "DI_STS": _seq("VALUE", "RAW", "TIMING_ON", "TIMING_OFF", "CHANNEL_FAULT", "ALARM_COND"),
    "DI_FLT": _seq("CHANNEL"),
    "DI_CFG": _seq("FAIL_VALUE", "ALARM"),
    "MOT_STS": _seq(
        "RUNNING", "RUN_CMD", "STARTING", "STOPPING", "INTERLOCKED", "PERMIT_MISSING", "START_INHIBIT", "AVAILABLE"
    ),
    "MOT_FLT": _seq("FAIL_TO_START", "FEEDBACK_LOST", "FAIL_TO_STOP", "UNCOMMANDED_RUN", "EXT_FAULT", "COMM_LOSS"),
    "MOT_WRN": _seq(
        "MAINT_RUNTIME",
        "MAINT_STARTS",
        "SPEED_DEV",
        "STARTS_LIMIT",
        "POWER_LOST",
        "INTERLOCK_IN_LOCAL",
        "COMM_LOSS",
        "FB_SUSPENDED",
        "SPEED_SP_INVALID",
    ),
    "MOT_CFG": {
        "FB_TIMES": 0,
        "STARTS_LIMIT": 1,
        "RESET": 2,
        "ALARM": 3,
        "VFD_SPEED_LIMITS": 8,
        "VFD_RAMP": 9,
        "VFD_COMM": 10,
        "VFD_SPEED_DEV": 11,
    },
    "VLV_STS": _seq("OPENED", "CLOSED", "OPENING", "CLOSING", "INTERLOCKED", "PERMIT_MISSING", "TORQUE", "AVAILABLE"),
    "VLV_FLT": _seq("FAIL_TO_OPEN", "FAIL_TO_CLOSE", "BOTH_LIMITS", "POSITION_LOST", "TORQUE_TRIP", "EXT_FAULT"),
    "VLV_WRN": _seq("MAINT_CYCLES", "POWER_LOST", "INTERLOCK_IN_LOCAL", "POSITION_BY_TIME", "POSITION_UNKNOWN"),
    "VLV_CFG": _seq("TYPE", "TRAVEL", "SAFE_POS", "TORQUE", "REVERSE", "RESET", "ALARM"),
    "CV_STS": _seq(
        "AT_SETPOINT", "RAMPING", "LIMITED_MIN", "LIMITED_MAX", "INTERLOCKED", "TIGHT_SHUT", "SAFE_POS", "AVAILABLE"
    ),
    "CV_FLT": _seq("DEVIATION", "POSITIONER"),
    "CV_WRN": _seq("DEVIATION", "FB_INVALID", "SP_INVALID"),
    "CV_CFG": _seq("LIMITS", "RATE", "SAFE_POS", "DEVIATION", "TIGHT_SHUT", "FAULT_ACTION", "ALARM"),
    "PID_STS": _seq(
        "SAT_HIGH", "SAT_LOW", "SP_RAMPING", "IN_DEADBAND", "PV_FAIL", "DT_GAP", "TRACKING", "OUT_RATE_LIMITED"
    ),
    "PID_FLT": _seq("PV_INVALID"),
    "PID_WRN": _seq("DT_GAP", "SP_INVALID"),
    "PID_CFG": _seq(
        "ACTION",
        "KP",
        "TI_TD",
        "DFILTER",
        "TT",
        "PV_RANGE",
        "SP_RANGE",
        "OUT_RANGE",
        "DEADBAND",
        "RATES",
        "SAMPLE",
        "PV_FAIL",
        "ALARM",
    ),
}


def _enum(*names: str, start: int = 0) -> list[tuple[str, int]]:
    """Значения перечисления подряд от start."""
    return [(name, start + index) for index, name in enumerate(names)]


# Коды перечислений (разделы 4.1, 11.1–17.1): тип -> (значения, базовый тип, strict)
CONTRACT_ENUMS: dict[str, tuple[list[tuple[str, int]], str, bool]] = {
    "E_DeviceMode": (_enum("Auto", "Manual", "Local", "OutOfService", start=1), "INT", True),
    "E_DeviceType": (
        _enum("None", "AnalogInput", "DigitalInput", "Motor", "MotorVfd", "Valve", "ControlValve", "Pid"),
        "INT",
        True,
    ),
    "E_Ne107Status": (
        _enum("Good", "MaintenanceRequired", "OutOfSpecification", "CheckFunction", "Failure"),
        "INT",
        True,
    ),
    "E_CmdResult": (
        _enum(
            "None",
            "Accepted",
            "RejectedMode",
            "RejectedInterlock",
            "RejectedPermit",
            "RejectedInhibit",
            "RejectedFault",
            "RejectedState",
            "RejectedNotSupported",
            "RejectedCfg",
            "SubstExpired",
        ),
        "INT",
        True,
    ),
    "E_AlarmState": (
        _enum("Normal", "ActiveUnack", "ActiveAck", "RtnUnack", "Shelved", "SuppressedByDesign", "OutOfService"),
        "INT",
        True,
    ),
    "E_AlarmPriority": (_enum("None", "Low", "Medium", "High", "Critical"), "INT", True),
    "E_AlarmEventReason": (
        _enum(
            "None",
            "Activated",
            "Cleared",
            "Acked",
            "Shelved",
            "Unshelved",
            "ShelveExpired",
            "Suppressed",
            "Unsuppressed",
            "OosOn",
            "OosOff",
        ),
        "INT",
        True,
    ),
    "E_AiAlarm": (_enum("HH", "H", "L", "LL", "Failure", "OutOfRange"), "UINT", False),
    "E_DiAlarm": (_enum("State", "Failure"), "UINT", False),
    "E_MotorAlarm": (
        _enum(
            "FailToStart",
            "FeedbackLost",
            "FailToStop",
            "UncommandedRun",
            "ExtFault",
            "InterlockTrip",
            "CommLoss",
            "SpeedDeviation",
        ),
        "UINT",
        False,
    ),
    "E_ValveAlarm": (
        _enum("FailToOpen", "FailToClose", "BothLimits", "PositionLost", "TorqueTrip", "ExtFault", "InterlockAct"),
        "UINT",
        False,
    ),
    "E_CvAlarm": (_enum("Deviation", "FbFailure", "PositionerFault", "InterlockAct"), "UINT", False),
    "E_PidAlarm": (_enum("PvInvalid"), "UINT", False),
    "E_AiInputType": (_enum("MilliAmp", "Norm420", "Norm01", "Eng", "Raw"), "INT", True),
    "E_AiSignalState": (
        _enum("Good", "UnderRange", "OverRange", "FailLow", "FailHigh", "ChannelFault", "NotFinite"),
        "INT",
        True,
    ),
    "E_AiFailValue": (_enum("HoldLast", "Substitute"), "INT", True),
    "E_DiFailValue": (_enum("HoldLast", "ForceFalse", "ForceTrue"), "INT", True),
    "E_MotorState": (_enum("Stopped", "Starting", "Running", "Stopping", "Fault"), "INT", True),
    "E_ValveType": (_enum("SolenoidEto", "SolenoidEtc", "Motorized"), "INT", True),
    "E_ValveSafePos": (_enum("Closed", "Open", "Stay"), "INT", True),
    "E_ValveState": (
        _enum("Unknown", "Closed", "Opening", "Open", "Closing", "Intermediate", "Reversing", "Fault"),
        "INT",
        True,
    ),
    "E_CvFaultAction": (_enum("Hold", "SafePos"), "INT", True),
    "E_PidAction": (_enum("Reverse", "Direct"), "INT", True),
    "E_PidPvFailAction": (_enum("Hold", "SafeOut", "ShedToManual"), "INT", True),
}

# Раздел 22.1: папка -> DUT
CONTRACT_DUTS: dict[str, list[str]] = {
    "Common": [
        "E_DeviceMode",
        "E_DeviceType",
        "E_Ne107Status",
        "E_CmdResult",
        "ST_DeviceCmd",
        "ST_DeviceSts",
        "ST_DeviceRetain",
        "U_RealBits",
    ],
    "Alarm": ["E_AlarmState", "E_AlarmPriority", "E_AlarmEventReason", "ST_AlarmCfg", "ST_AlarmEvent"],
    "AnalogInput": [
        "E_AiInputType",
        "E_AiSignalState",
        "E_AiFailValue",
        "E_AiAlarm",
        "ST_AiLimitCfg",
        "ST_AnalogInputCmd",
        "ST_AnalogInputSts",
        "ST_AnalogInputCfg",
    ],
    "DigitalInput": ["E_DiFailValue", "E_DiAlarm", "ST_DigitalInputCmd", "ST_DigitalInputSts", "ST_DigitalInputCfg"],
    "Motor": ["E_MotorState", "E_MotorAlarm", "ST_MotorCmd", "ST_MotorSts", "ST_MotorCfg", "ST_VfdCfg"],
    "Valve": [
        "E_ValveType",
        "E_ValveSafePos",
        "E_ValveState",
        "E_ValveAlarm",
        "ST_ValveCmd",
        "ST_ValveSts",
        "ST_ValveCfg",
    ],
    "ControlValve": [
        "E_CvFaultAction",
        "E_CvAlarm",
        "ST_ControlValveCmd",
        "ST_ControlValveSts",
        "ST_ControlValveCfg",
    ],
    "Pid": ["E_PidAction", "E_PidPvFailAction", "E_PidAlarm", "ST_PidCmd", "ST_PidSts", "ST_PidCfg"],
}


def gvl_constants() -> dict[str, tuple[str, str]]:
    gvl = scan("src").find("GVL_Const")
    assert gvl is not None
    result: dict[str, tuple[str, str]] = {}
    for block in L.parse_var_blocks(gvl.decl):
        assert "CONSTANT" in block.modifiers, "в GVL_Const только VAR_GLOBAL CONSTANT"
        for decl in block.decls:
            for name in decl.name_list:
                assert name not in result, f"константа {name} объявлена дважды"
                result[name] = (decl.type_text.strip(), (decl.init_text or "").strip())
    return result


def test_gvl_const_has_contract_constants() -> None:
    constants = gvl_constants()
    for name, expected in CONTRACT_CONSTANTS.items():
        assert name in constants, f"нет константы {name}"
        assert constants[name] == expected, f"{name}: {constants[name]}, по контракту {expected}"


def test_gvl_const_bit_masks_match_contract_maps() -> None:
    constants = gvl_constants()
    expected = {f"{word}_{name}": bit for word, bits in BIT_MAPS.items() for name, bit in bits.items()}
    for name, bit in expected.items():
        assert name in constants, f"нет маски {name}"
        type_name, value = constants[name]
        assert type_name == "WORD", f"{name}: тип {type_name}, ожидается WORD"
        assert value == f"16#{1 << bit:04X}", f"{name}: {value}, по карте битов бит {bit} = 16#{1 << bit:04X}"
    masks = {n for n in constants if re.fullmatch(r"(DEV|AI|DI|MOT|VLV|CV|PID)_(STS|FLT|WRN|CFG)_\w+", n)}
    assert masks == set(expected), f"маски вне карт битов контракта: {sorted(masks - set(expected))}"


def test_dut_set_matches_contract() -> None:
    duts = {obj.name: obj for obj in scan("src").objects if obj.kind == L.KIND_DUT}
    expected = {name: folder for folder, names in CONTRACT_DUTS.items() for name in names}
    assert len(expected) == 50
    assert set(duts) == set(expected)
    for name, folder in expected.items():
        assert duts[name].folder == [folder], f"{name}: папка {duts[name].folder}, по контракту {folder}"
        assert "{attribute 'qualified_only'}" in duts[name].decl, f"{name}: нет qualified_only"


@pytest.mark.parametrize("name", sorted(CONTRACT_ENUMS))
def test_enum_matches_contract(name: str) -> None:
    obj = scan("src").find(name)
    assert obj is not None, f"нет {name}"
    tdecl = L.parse_type_decl(obj.decl)
    assert tdecl is not None and tdecl.kind == "enum"
    values, base, strict = CONTRACT_ENUMS[name]
    assert [(item, int(value or "-1")) for item, value, _ in tdecl.enum_values] == values
    assert (tdecl.enum_base_type or "").strip() == base
    assert ("{attribute 'strict'}" in obj.decl) == strict, f"{name}: strict должен быть {strict}"


def test_sts_sizes_match_register_map() -> None:
    """Таблица 4.6: расчёт раскладки по исходникам совпадает с картой регистров контракта."""
    assert common.sizes(list(common.STS_CONTRACT)) == common.STS_CONTRACT


def test_reference_layout_rejects_wide_types() -> None:
    calc = common.LayoutCalc()
    with pytest.raises(common.LayoutError):
        calc.of_type("LTIME")


def test_reference_scenarios_are_consistent() -> None:
    """Сценарии tools/reference/common.py, на которые ссылаются тесты ST."""
    assert [common.rate_limit(*row[1:]) for row in common.RATE_LIMIT_SCENARIOS] == [
        25.0,
        79.0,
        27.5,
        78.5,
        80.0,
        75.0,
        50.0,
        50.0,
    ]
    frees = [common.window_time_to_free(s, now, limit) / 60 for _, s, now, limit in common.STARTS_SCENARIOS]
    assert frees == [30.0, 40.0, 0.0, 0.0, 31.0]
    assert common.time_to_sec(common.TIME_MAX_MS) == pytest.approx(4294967.295, abs=1e-9)


# Документы, которые пишут команды семейств устройств (на них уже ссылаются заголовки DUT основы)
PLANNED_DOCS = {
    "docs/fb/FB_AnalogInput.md",
    "docs/fb/FB_DigitalInput.md",
    "docs/fb/FB_Motor.md",
    "docs/fb/FB_MotorVfd.md",
    "docs/fb/FB_Valve.md",
    "docs/fb/FB_ControlValve.md",
    "docs/fb/FB_PID.md",
}


def test_documents_referenced_by_headers_exist() -> None:
    """Заголовки объектов ссылаются на существующие документы docs/ (кроме PLANNED_DOCS)."""
    for subdir in ("src", "tests"):
        for obj in scan(subdir).objects:
            for rel, text in L.object_files(obj):
                for doc in re.findall(r"docs/[\w/.-]+\.md", text):
                    if doc not in PLANNED_DOCS:
                        assert os.path.isfile(os.path.join(REPO_ROOT, doc)), f"{rel}: нет документа {doc}"
