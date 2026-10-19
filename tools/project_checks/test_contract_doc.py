"""docs/API.md (публикуемая копия контракта) против исходников src/.

test_conventions.py сверяет src/ с таблицами, перенесёнными в код теста. Здесь источник — сам
документ docs/API.md: тексты DUT (без комментариев, токен в токен), таблица констант 5.1, карты
битов и сигнатуры интерфейсов раздела 6. Тест падает, если правка попала только в документ или
только в исходники. Известные отступления имён — в KNOWN_RENAMES (с 1.0.0 их нет: F-17 закреплено в контракте).

Запуск: python -m pytest (каталог входит в testpaths, pyproject.toml).
"""

from __future__ import annotations

import os
import re

import common
import stlayout as L

REPO_ROOT = common.REPO_ROOT
API_MD = os.path.join(REPO_ROOT, "docs", "API.md")

# (интерфейс, имя по контракту) -> имя в исходниках: отступления, записанные в ASSUMPTIONS.md.
# Пусто с контракта 1.0.0: AlarmPriority (F-17) — имя самого контракта.
KNOWN_RENAMES: dict[tuple[str, str], str] = {}

_TYPE_RE = re.compile(r"((?:\{attribute '[^']+'\}\s*)*)TYPE\s+(\w+)\s*:(.*?)END_TYPE", re.S)
_ATTR_RE = re.compile(r"\{attribute '([^']+)'\}")
_MASK_RE = re.compile(r"`((?:DEV|AI|DI|MOT|VLV|CV|PID)_(?:STS|FLT|WRN|CFG)_\w+)`")
_SLOT_ENUM_RE = re.compile(r"E_\w+Alarm$")


def api_text() -> str:
    with open(API_MD, encoding="utf-8") as handle:
        return handle.read()


def section(text: str, start: str, end: str) -> str:
    first = text.index(start)
    return text[first : text.index(end, first)]


def norm(text: str) -> str:
    """Текст ST без комментариев и прагм, пробелы не значимы, граница массива слотов — одним видом."""
    body = L.strip_comments(text, pragmas=True)
    body = re.sub(r"\s+", " ", body).strip()
    body = re.sub(r"\s*([:;,=\[\]()+\-])\s*", r"\1", body)
    return body.replace("ARRAY[0..7]", "ARRAY[0..GVL_Const.DEV_ALARMS_MAX-1]")


def contract_types() -> dict[str, tuple[set[str], str]]:
    types: dict[str, tuple[set[str], str]] = {}
    for block in re.findall(r"```st\n(.*?)```", api_text(), re.S):
        for match in _TYPE_RE.finditer(block):
            types[match.group(2)] = (set(_ATTR_RE.findall(match.group(1))), norm(match.group(3)))
    return types


def source_types() -> dict[str, tuple[set[str], str]]:
    types: dict[str, tuple[set[str], str]] = {}
    for obj in L.scan(REPO_ROOT, "src").objects:
        if obj.kind != L.KIND_DUT:
            continue
        match = _TYPE_RE.search(L.strip_comments(obj.decl, pragmas=False))
        assert match is not None, obj.name
        types[match.group(2)] = (set(_ATTR_RE.findall(match.group(1))), norm(match.group(3)))
    return types


def test_api_doc_has_all_duts() -> None:
    assert len(contract_types()) == 50
    assert set(contract_types()) == set(source_types())


def test_dut_texts_match_api_doc() -> None:
    contract = contract_types()
    source = source_types()
    for name, (_, body) in contract.items():
        assert source[name][1] == body, f"{name}: текст DUT отличается от docs/API.md"


def test_dut_attributes_match_api_doc() -> None:
    contract = contract_types()
    for name, (attrs, _) in source_types().items():
        expected = set(contract[name][0])
        # 2.7: все DUT — с qualified_only (в кратких записях раздела 4.1/4.5 атрибут опущен)
        expected.add("qualified_only")
        if _SLOT_ENUM_RE.match(name):
            assert "strict" not in attrs, f"{name}: индекс слотов — без strict (зонд P8)"
        assert attrs == expected, f"{name}: атрибуты {sorted(attrs)}, по docs/API.md {sorted(expected)}"


def gvl_const() -> dict[str, tuple[str, str]]:
    gvl = L.scan(REPO_ROOT, "src").find("GVL_Const")
    assert gvl is not None
    result: dict[str, tuple[str, str]] = {}
    for block in L.parse_var_blocks(gvl.decl):
        for decl in block.decls:
            for name in decl.name_list:
                result[name] = (decl.type_text.strip(), (decl.init_text or "").strip())
    return result


def test_constants_table_matches_gvl_const() -> None:
    rows = re.findall(r"^\| `(\w+)` \| (\w+) \| ([^|]+?) \|", section(api_text(), "### 5.1", "### 5.2"), re.M)
    assert len(rows) == 27
    constants = gvl_const()
    for name, type_name, value in rows:
        assert constants.get(name) == (type_name, value.strip()), f"{name}: {constants.get(name)}"


def bit_maps() -> dict[str, int]:
    """Маска -> бит по таблицам карт битов документа (заголовок с `wStatus` или «Маска»)."""
    expected: dict[str, int] = {}
    in_map = False
    for line in api_text().splitlines():
        if line.startswith("| Бит |"):
            in_map = "`wStatus`" in line or "| Маска |" in line
            continue
        if not line.startswith("|"):
            in_map = False
            continue
        match = re.match(r"\| (\d+) \|", line)
        if in_map and match:
            for name in _MASK_RE.findall(line):
                assert expected.setdefault(name, int(match.group(1))) == int(match.group(1)), name
    return expected


def test_bit_masks_match_api_doc_maps() -> None:
    expected = bit_maps()
    assert len(expected) == 142
    constants = gvl_const()
    masks = {n for n in constants if _MASK_RE.fullmatch("`" + n + "`")}
    assert masks == set(expected), sorted(masks ^ set(expected))
    for name, bit in expected.items():
        assert constants[name] == ("WORD", f"16#{1 << bit:04X}"), f"{name}: {constants[name]}, бит {bit}"


def contract_interfaces() -> dict[str, tuple[list[str], dict[str, str]]]:
    """Интерфейс -> (базы, {член: тип результата}) по блокам раздела 6."""
    result: dict[str, tuple[list[str], dict[str, str]]] = {}
    for block in re.findall(r"```st\n(.*?)```", section(api_text(), "## 6.", "## 7."), re.S):
        current = None
        for line in L.strip_comments(block, pragmas=False).splitlines():
            words = line.split()
            if words[:1] == ["INTERFACE"]:
                current = words[1]
                result[current] = (words[3:4] if words[2:3] == ["EXTENDS"] else [], {})
            elif words[:1] in (["METHOD"], ["PROPERTY"]) and current is not None:
                result[current][1][words[1]] = words[3] if len(words) > 3 else ""
    return result


def test_interfaces_match_api_doc() -> None:
    contract = contract_interfaces()
    sources = {o.name: o for o in L.scan(REPO_ROOT, "src").objects if o.kind == L.KIND_ITF}
    assert set(contract) == set(sources)
    for name, (bases, members) in contract.items():
        obj = sources[name]
        assert obj.header is not None
        assert list(obj.header.extends) == bases, f"{name}: EXTENDS {obj.header.extends}, по docs/API.md {bases}"
        actual = {m.name: (m.header.return_type or "") for m in obj.methods if m.header is not None}
        actual.update({p.name: (p.header.return_type or "") for p in obj.properties if p.header is not None})
        renamed = {KNOWN_RENAMES.get((name, member), member): rtype for member, rtype in members.items()}
        assert actual == renamed, f"{name}: {actual}, по docs/API.md {renamed}"


def test_known_renames_are_documented() -> None:
    """Каждое отступление имени упомянуто в docs/API.md (раздел 0) и в ASSUMPTIONS.md."""
    with open(os.path.join(REPO_ROOT, "docs", "ASSUMPTIONS.md"), encoding="utf-8") as handle:
        assumptions = handle.read()
    for new_name in KNOWN_RENAMES.values():
        assert f"`{new_name}`" in api_text()
        assert f"`{new_name}`" in assumptions


# ---------------------------------------------------------------------------
# Объявления ФБ: публичный интерфейс (входы, выходы, VAR_IN_OUT) — контракт API.md и docs/fb
# ---------------------------------------------------------------------------

PUBLIC_SECTIONS = ("VAR_INPUT", "VAR_OUTPUT", "VAR_IN_OUT")
_DIRECTIONS = {
    "вход": "VAR_INPUT",
    "вход (база)": "VAR_INPUT",
    "выход": "VAR_OUTPUT",
    "`VAR_IN_OUT`": "VAR_IN_OUT",
    "`VAR_IN_OUT CONSTANT`": "VAR_IN_OUT CONSTANT",
}


def public_interface(text: str) -> dict[str, tuple[str, str, str]]:
    """Имя -> (секция с модификаторами, тип, начальное значение) по секциям VAR_INPUT/OUTPUT/IN_OUT."""
    result: dict[str, tuple[str, str, str]] = {}
    for block in L.parse_var_blocks(text):
        if block.keyword not in PUBLIC_SECTIONS:
            continue
        section = " ".join([block.keyword, *block.modifiers])
        for decl in block.decls:
            for name in decl.name_list:
                result[name] = (section, norm(decl.type_text), norm(decl.init_text or ""))
    return result


def contract_fbs() -> dict[str, str]:
    """Блоки ```st раздела API.md, начинающиеся с FUNCTION_BLOCK: имя -> текст блока."""
    result: dict[str, str] = {}
    for block in re.findall(r"```st\n(.*?)```", api_text(), re.S):
        header = L.parse_header(block)
        if header is not None and header.keyword == "FUNCTION_BLOCK" and header.name:
            result[header.name] = block
    return result


def source_fbs() -> dict[str, L.StObject]:
    return {
        obj.name: obj
        for obj in L.scan(REPO_ROOT, "src").objects
        if obj.kind == L.KIND_POU and obj.header is not None and obj.header.keyword == "FUNCTION_BLOCK"
    }


def test_fb_declarations_match_api_doc() -> None:
    """Блоки FUNCTION_BLOCK контракта: заголовок (ABSTRACT, EXTENDS, IMPLEMENTS) и публичные секции — имя,
    тип и начальное значение — совпадают с исходниками. Их копируют потребители (iolistgen, заглушки тестов
    проектов `kns-pump-station` и `iolistgen`): правка только в коде или только в документе ловится здесь (F5)."""
    contract = contract_fbs()
    sources = source_fbs()
    assert len(contract) == 14, sorted(contract)
    for name, block in contract.items():
        assert name in sources, f"{name}: ФБ из docs/API.md нет в src/"
        header = L.parse_header(block)
        source = sources[name]
        assert header is not None and source.header is not None
        assert list(header.modifiers) == list(source.header.modifiers), f"{name}: модификаторы"
        assert list(header.extends) == list(source.header.extends), f"{name}: EXTENDS"
        assert list(header.implements) == list(source.header.implements), f"{name}: IMPLEMENTS"
        documented = public_interface(block)
        actual = public_interface(source.decl)
        assert documented == actual, (
            f"{name}: публичный интерфейс отличается от docs/API.md: "
            f"{sorted(set(documented.items()) ^ set(actual.items()))}"
        )


def inherited_interface(name: str, sources: dict[str, L.StObject]) -> dict[str, tuple[str, str, str]]:
    """Публичный интерфейс ФБ с учётом базовых ФБ библиотеки (EXTENDS)."""
    obj = sources[name]
    result: dict[str, tuple[str, str, str]] = {}
    assert obj.header is not None
    for base in obj.header.extends:
        if base in sources:
            result.update(inherited_interface(base, sources))
    result.update(public_interface(obj.decl))
    return result


def io_table_rows(fb_name: str) -> list[tuple[list[str], str, str]]:
    """Строки таблицы «Входы и выходы» docs/fb/<ФБ>.md: (имена, секция, тип)."""
    with open(os.path.join(REPO_ROOT, "docs", "fb", f"{fb_name}.md"), encoding="utf-8") as handle:
        text = handle.read()
    part = section(text, "## Входы и выходы", "\n## ")
    rows: list[tuple[list[str], str, str]] = []
    for line in part.splitlines():
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if len(cells) < 3 or cells[1] not in _DIRECTIONS:
            continue
        names = re.findall(r"`(\w+)`", cells[0])
        type_match = re.fullmatch(r"`([^`]+)`", cells[2])
        assert names and type_match, f"{fb_name}: строка таблицы не разобрана: {line}"
        rows.append((names, _DIRECTIONS[cells[1]], norm(type_match.group(1))))
    return rows


DEVICE_DOCS = (
    "FB_Alarm",
    "FB_AnalogInput",
    "FB_DigitalInput",
    "FB_Motor",
    "FB_MotorVfd",
    "FB_Valve",
    "FB_ControlValve",
    "FB_PID",
)


def test_fb_io_tables_match_sources() -> None:
    """docs/fb: каждая строка таблицы «Входы и выходы» — член ФБ (или его базы) с той же секцией и типом,
    каждый собственный вход, выход и VAR_IN_OUT ФБ есть в таблице (F5)."""
    sources = source_fbs()
    for fb_name in DEVICE_DOCS:
        interface = inherited_interface(fb_name, sources)
        rows = io_table_rows(fb_name)
        listed: set[str] = set()
        for names, section_name, type_name in rows:
            for name in names:
                assert name in interface, f"docs/fb/{fb_name}.md: `{name}` нет среди членов ФБ"
                actual_section, actual_type, _ = interface[name]
                assert (section_name, type_name) == (actual_section, actual_type), (
                    f"docs/fb/{fb_name}.md: `{name}` — {section_name} {type_name}, в src {actual_section} {actual_type}"
                )
                listed.add(name)
        own = public_interface(sources[fb_name].decl)
        missing = sorted(set(own) - listed)
        assert not missing, f"docs/fb/{fb_name}.md: нет в таблице «Входы и выходы»: {missing}"


def test_non_mask_constants_in_api_doc_table() -> None:
    """Таблица 5.1 и в обратную сторону: каждая константа GVL_Const, которая не маска битов и не число
    слотов тревог (*_ALARM_COUNT — таблица 10.4), описана в таблице 5.1 (F5)."""
    rows = re.findall(r"^\| `(\w+)` \|", section(api_text(), "### 5.1", "### 5.2"), re.M)
    for name in gvl_const():
        if _MASK_RE.fullmatch("`" + name + "`") or name.endswith("_ALARM_COUNT"):
            continue
        assert name in rows, f"GVL_Const.{name} нет в таблице 5.1 docs/API.md"
