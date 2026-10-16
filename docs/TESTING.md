# Тесты библиотеки: соглашения

Юнит-тесты — coUnit 1.2.0.0 (бывший CfUnit, пространство имён `coUnit`), прогон — в CODESYS Control
Win V3 командой `python tools/codesys/cds.py test`. Документ задаёт правила, по которым команды
семейств ФБ пишут тесты параллельно, не мешая друг другу. Нормативный список тестов — раздел 23
контракта [API.md](API.md); здесь — как их оформлять. Что устройство обязано проверить само — раздел
[«Чек-лист устройства»](#чек-лист-устройства).

## Коротко: что делает команда семейства

1. **Набор** — `tests/POUs/Suites/FB_<X>_Test/`: объявление `FB_<X>_Test.decl.st`
   (`FUNCTION_BLOCK FB_<X>_Test EXTENDS coUnit.FB_TestSuite`), тело `FB_<X>_Test.impl.st` (вызов
   каждого метода-теста) и по паре `<Метод>.method.decl.st` / `<Метод>.method.impl.st` на тест.
2. **Регистрация** — своя GVL `tests/GVLs/GVL_Tests<Семейство>.gvl.st` с атрибутами
   `qualified_only` и **`linkalways`**, в ней по экземпляру каждого набора семейства.
   `PRG_Tests` не правит никто: в нём только `coUnit.RUN();`.
3. **Имена** — `coUnit.TEST('<Fb>_<Case>_<Expectation>')` из списка контракта; метод — то же имя
   без первого сегмента и без подчёркиваний, `METHOD PRIVATE`.
4. **Время** — только `FB_FakeTime` из библиотеки; `TON`/`TOF`/`TP` и реальное ожидание запрещены.
   Тест целиком проходит за один вызов метода.
5. **Проверка перед сдачей** — `cds.py build --tests` (0 ошибок, 0 предупреждений), `cds.py test`
   (всё зелёное), `cds.py roundtrip`, `st_lint.py --strict`, `run_iec_checker.py --tests`,
   `python -m pytest` (в том числе проверка этих соглашений).

```
tests/
  DUTs/TestDevice/                    типы тестового устройства, U_TestEnumInt
  GVLs/
    GVL_TestsFoundation.gvl.st        наборы основы, этап 1: время, утилиты, общие типы
    GVL_TestsAlarm.gvl.st             наборы основы, этап 2: FB_Alarm, FB_DeviceBase, зонды
    GVL_Tests<Семейство>.gvl.st       по GVL на семейство (AiDi, Motor, Valve, Pid)
    GVL_TestsIntegration.gvl.st       межсемейные тесты: все семь типов устройств вместе
  POUs/
    PRG_Tests/                        coUnit.RUN(); экземпляров наборов нет
    Suites/FB_<X>_Test/               наборы
    Helpers/<FB_Помощник>/            общие тестовые ФБ (FB_TestSink, FB_TestDevice, FB_FopdtModel)
```

## Регистрация наборов: GVL на семейство с `linkalways`

Набор coUnit регистрируется в `FB_init` базового `FB_TestSuite` — значит, достаточно объявить
экземпляр, вызывать его не нужно (раннер вызывает наборы сам). Экземпляры объявляются не в
`PRG_Tests`, а в GVL семейства: тогда каждая команда правит только свои файлы и конфликтов слияния
нет.

```st
// tests/GVLs/GVL_TestsMotors.gvl.st
// Назначение: экземпляры наборов семейства двигателей. {attribute 'linkalways'} обязателен.
{attribute 'qualified_only'}
{attribute 'linkalways'}
VAR_GLOBAL
    fbMotorTest    : FB_Motor_Test;
    fbMotorVfdTest : FB_MotorVfd_Test;
END_VAR
```

**Атрибут `linkalways` обязателен.** CODESYS 3.5.17 компилирует и загружает только объекты,
достижимые из задач. На GVL наборов никто не ссылается: без атрибута компилятор её выбрасывает,
`FB_init` экземпляров не выполняется, и набор **молча пропадает** — без ошибок и предупреждений.
Проверено зондом в отдельной копии репозитория (CODESYS 3.5.17.30, Control Win V3, 16.10.2026,
`cds.py test`):

| Прогон | Где объявлены экземпляры | Итог `cds.py test` |
|---|---|---|
| 1 | `PRG_Tests.fbProbePrg`; GVL `GVL_TestsProbeA`, `GVL_TestsProbeB` без `linkalways` | наборов 1, тестов 2: выполнился только набор из `PRG_Tests` |
| 2 | то же, у `GVL_TestsProbeA` — `{attribute 'linkalways'}` | наборов 2, тестов 4: `GVL_TestsProbeA.fbProbeGvlA` и `PRG_Tests.fbProbePrg` |
| 3 | только GVL, обе с `linkalways`; в `PRG_Tests` экземпляров нет | наборов 2, тестов 4: `GVL_TestsProbeA.fbProbeGvlA`, `GVL_TestsProbeB.fbProbeGvlB` |
| 4 | как 3, но у `GVL_TestsProbeB` атрибут `linkalways` убран (повтор зонда) | наборов 1, тестов 2: только `GVL_TestsProbeA.fbProbeGvlA`; сборка — 0 ошибок, 0 предупреждений |
| 5 | атрибут возвращён (повтор прогона 3) | наборов 2, тестов 4 |

В отчёте имя набора — путь экземпляра без `Device.Application.`: `GVL_TestsFoundation.fbTimeTest`.
Атрибут `qualified_only` на регистрацию не влияет (прогон 3: одна GVL с ним, другая без).

Разбиение (правило — одна GVL на семейство, чужие не правятся):

| GVL | Наборы |
|---|---|
| `GVL_TestsFoundation` | `FB_Time_Test`, `FB_Util_Test`, `FB_Common_Test` (основа, этап 1) |
| `GVL_TestsAlarm` | `FB_Alarm_Test`, `FB_DeviceBase_Test`, `FB_Runtime_Test` (основа, этап 2) |
| `GVL_TestsAiDi` | `FB_AnalogInput_Test`, `FB_DigitalInput_Test` |
| `GVL_TestsMotor` | `FB_Motor_Test`, `FB_MotorVfd_Test` |
| `GVL_TestsValve` | `FB_Valve_Test`, `FB_ControlValve_Test` |
| `GVL_TestsPid` | `FB_Pid_Test` |
| `GVL_TestsIntegration` | `FB_Integration_Test` (после слияния семейств, F-26) |

Тесты `Common_SizeOfSts_MatchesRegisterMap` и `Common_SizeOfDeviceRetain_Is36` (в контракте — в
`FB_DeviceBase_Test`) уже есть в `FB_Common_Test`: типы DUT сделаны на этапе 1. В
`FB_DeviceBase_Test` их не повторять.

Две ошибки, которые теряют тесты без единого сообщения, ловит `python -m pytest`
(`tools/project_checks/test_conventions.py`): GVL наборов без `linkalways` и метод-тест, который
тело набора не вызывает. Там же проверяется, что экземпляр набора ровно один и только в
`tests/GVLs/`, что имена тестов уникальны и соответствуют имени метода.

## Имена

| Где | Правило | Пример |
|---|---|---|
| набор | `FB_<X>_Test`, `X` — как в списке наборов контракта (22.5) | `FB_AnalogInput_Test` |
| экземпляр набора | `fb<X>Test` в GVL семейства | `fbAnalogInputTest` |
| имя теста в `coUnit.TEST('...')` | из списка 23.2: `<Fb>_<Case>_<Expectation>`, ASCII, до 255 символов, уникально во всей библиотеке. Пять имён контракта из двух сегментов (`Valve_NeverBothOutputs` и др.) проверка допускает (F-25) | `AnalogInput_WireBreak_SetsFailureAfterDelay` |
| метод-тест | имя теста без первого сегмента и без `_`, PascalCase, `METHOD PRIVATE` (A-08: правило STL006 запрещает `_` в именах методов) | `WireBreakSetsFailureAfterDelay` |
| вспомогательный метод набора | PascalCase, без `coUnit.TEST` | `MakeRunningMotor` |

Сверх списка контракта допускаются свои тесты с тем же форматом имени (на этапе 1 их 32, например
`Delay_FirstCallWithInputTrue_StartsOnDelay`). Первый сегмент — объект под тестом (`Delay`, `Util`,
`AnalogInput`), а не имя набора.

## Шаблон метода-теста

```st
// tests/POUs/Suites/FB_Time_Test/OnDelayOutputExactlyAtDelay.method.decl.st
// Задержка включения 2 с, шаг 100 мс: выход включается ровно на 20-м шаге (t0 + 2,0 с), не на 19-м.
METHOD PRIVATE OnDelayOutputExactlyAtDelay
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
    iStep   : INT;           // шаг цикла
END_VAR
```

```st
// ...method.impl.st
coUnit.TEST('Delay_OnDelay_OutputExactlyAtDelay');

fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);              // t0: фронт
FOR iStep := 1 TO 19 DO
    fbTime.Advance(tStep := T#100MS);
    fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);
END_FOR
AssertFalse(Condition := fbDelay.xOut, Message := 'no output at t0 + 1.9 s');
fbTime.Advance(tStep := T#100MS);
fbDelay(xIn := TRUE, tOnDelay := T#2S, itfTime := fbTime);              // t0 + 2,0 с
AssertTrue(Condition := fbDelay.xOut, Message := 'output exactly at t0 + 2.0 s');

coUnit.TEST_FINISHED();
```

- Функции coUnit — с пространством имён (`coUnit.TEST`, `coUnit.TEST_FINISHED`, `coUnit.RUN`),
  ассерты — методы набора без него (`AssertTrue`, `AssertFalse`, `AssertEquals_REAL(Expected, Actual,
  Delta, Message)`, `AssertEquals_LREAL`, `AssertEquals_TIME`, `AssertEquals_LTIME`, `AssertEquals_INT`,
  `AssertEquals_UINT`, `AssertEquals_UDINT`, `AssertEquals_WORD`).
- ФБ под тестом, `FB_FakeTime`, Cmd/Cfg/Retain — локальные `VAR` метода: они создаются заново при
  каждом вызове, тесты не зависят друг от друга. Входы ФБ сохраняют значение между вызовами, но в
  тестах их лучше передавать в каждом вызове явно.
- Устройства вызываются со всеми `VAR_IN_OUT` в каждом вызове (R1 контракта, иначе C0039). Литерал
  структуры в `VAR_IN_OUT CONSTANT` передать нельзя (C0032): Cfg — локальная переменная метода.
- Комментарий объявления — что проверяет тест (по-русски); сообщения ассертов — ASCII по-английски
  (`STRING` в 3.5.17 — Windows-1252).

## Время: `FB_FakeTime`

`FB_FakeTime` лежит в библиотеке (`src/POUs/Time/`), им же пользуются тесты проектов 02 и 10.

| Действие | Как |
|---|---|
| подать время в ФБ | `itfTime := fbTime` во входе ФБ под тестом; устройства передают его вложенным `FB_Delay`, `FB_Alarm`, `FB_LimitMonitor` сами |
| шаг | `fbTime.Advance(tStep := T#100MS)`; меньше 1 мс или больше 49 сут — `fbTime.AdvanceL(ltStep := LTIME#250US)` |
| «время назад», скачок | `fbTime.SetNow(ltValue := LTIME#59M50S)` — ФБ библиотеки обязаны это переживать |
| текущее | `fbTime.Now()`; старт — `LTIME#1H`, а не 0: ловит код, который считает «0 = не инициализировано» |

- Цикл «шаг — вызов ФБ», затем ассерты. Ассерт — не внутри цикла: состояние в цикле копится в
  переменную (`xEverOn := xEverOn OR fbDelay.xOut;`) и проверяется после.
- Порядок в цикле — сначала `Advance`, потом вызов ФБ: вызов видит уже новое время. Отметка `t0` —
  первый вызов до цикла; в комментарии справа писать момент (`// t0 + 2,0 с`).
- Не больше ~1500 итераций на тест: все тесты выполняются в одном цикле задачи. Длинные интервалы
  (час окна пусков, `tShelveMax` = 8 ч) — крупными шагами.
- Границы проверяются с двух сторон: «нет выхода на шаге до задержки» и «выход ровно на задержке».
- Реальное время допустимо только в проверках, которые ничего не ждут (`Time_SystemTime_IsMonotonic`,
  `Delay_NoTimeSource_FallsBackToSystemTime`).

## Ожидаемые значения и эталоны

- Ожидаемое значение не должно быть нулём, если это возможно: невыставленный выход равен 0, и тест
  прошёл бы ложно.
- Посчитанные значения (масштабирование, фильтр, ПИД, размеры структур) считает скрипт
  `tools/reference/<имя>.py` (Python 3, только стандартная библиотека, проходит ruff и mypy), а тест
  ссылается на него комментарием: `источник: tools/reference/common.py, сценарий cfg_sizes`. Основа —
  `tools/reference/common.py`; контракт называет и `ai_reference.py`, `pid_reference.py` для своих
  семейств. Запуск: `python tools/reference/common.py`.
- Допуск сравнения REAL — по смыслу (обычно `1.0E-5` относительно значения порядка 100); для значений,
  которые ФБ возвращает без арифметики, — `0.0`. Для LREAL — типизированные литералы
  (`LREAL#1.0E-9`), иначе литерал округлится до REAL.
- **NaN проходит `AssertEquals_REAL`.** coUnit сравнивает `ABS(Expected - Actual) > Delta`, а любое
  сравнение с NaN ложно: при `Actual = NaN` ассерт **проходит**, хотя значение испорчено (найдено
  мутационной проверкой ПИД: мутант, пропускавший NaN в выход, выживал). Правило: в тесте с
  неконечным входом (NaN, ±Inf, больше `REAL_SANE_MAX` — через `U_RealBits`) каждый REAL-выход, который
  тест сравнивает или который может принять мусор (выход, значение в Sts, слежение в Cmd), сначала
  проверяется на конечность, затем на значение:

  ```st
  // AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
  AssertTrue(Condition := F_IsFinite(rIn := fbCv.rOut_pct) AND F_IsFinite(rIn := fbCv.rOut_mA),
             Message := 'output finite');
  AssertEquals_REAL(Expected := 35.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'held on NaN setpoint');
  ```

  Так же для `AssertEquals_LREAL`. Проверено по всем наборам: тесты с неконечными входами
  `FB_Util_Test` (`F_RateLimit`), `FB_AnalogInput_Test`, `FB_MotorVfd_Test`, `FB_ControlValve_Test`,
  `FB_Pid_Test` проверяют конечность; тесты, где NaN подаётся только в Cfg (`*_CfgErrBits*`,
  `*_CfgChecks*`), сравнивают только биты `wCfgErr`, а `FB_LimitMonitor` — только `BOOL`.
  Мутационная проверка правила (Control Win V3, 16.10.2026): `F_RateLimit` без проверки конечности
  цели возвращает NaN — прежний `AssertEquals_REAL(Expected := 42.0, …)` проходил, проверка
  `F_IsFinite` роняет `Util_RateLimit_NonFiniteTarget_HoldsCurrent` («NaN target: result finite»).

## Ограничения coUnit и инструментов, которые влияют на текст тестов

| Что | Правило |
|---|---|
| лимиты coUnit по умолчанию | не больше 100 тестов и 1000 ассертов на набор; больше — второй набор (`config.json`: `max_tests_per_suite` = 100) |
| приёмник событий | `GVL_Lib.itfAlarmSink := fbSink` только в тестах, которым нужны события; `GVL_Lib.itfAlarmSink := 0` до `coUnit.TEST_FINISHED()` |
| iec_checker 0.4 (CI, `--tests`) | понижение шаблона разбирает поле элемента `a[i].x`, вызов элемента массива ФБ `afb[i](...)`, константы в границах массивов, `TIME()`/`LTIME()`, типизированные литералы (`WORD#16#0001`), длительности с пропуском единиц (`LTIME#1H500MS`), пустые ветви и пустой оператор `;`. По-прежнему не разбирает: `JMP`, метки `CASE` с константами библиотек, `NOT NOT x`, `F(x).y`, `NOT` в начале позиционного аргумента (`SEL(NOT x, a, b)` — пишите `SEL(x, b, a)`), параметры экземпляра в объявлении (`tools/README.md`, «Понижение для iec_checker») |
| iec_checker 0.4, ложные «неиспользуемые» | экземпляры ФБ, структуры и объединения в тестах (префиксы `fb`, `st`, `u`, `itf`) обоснованы общей записью в `tools/check/iec_checker_allow.toml`, массивы структур и ФБ, к которым обращаются только через поле элемента (`astCfg[i].ePriority`), — тоже; остальное — запись в разделе своего семейства |
| iec_checker 0.4, PLCOPEN-L17 | `IF` без `ELSE` обоснован общей записью; пустую ветвь `ELSE` не писать |
| iec_checker 0.4, имена | ключевые слова МЭК, которые в CODESYS идентификаторами быть могут (`Priority`, `Interval`, `Single`, `On`, `Task`, `Ref`, `Null`, …), в именах членов и переменных не используются: так сделано в API (F-17), так и в тестах |
| RuSTy 1.0.6 | `VAR_IN_OUT CONSTANT` вариант сборки `rusty` понижает до `VAR_IN_OUT` (замена R13 шаблона): `tools/check/rusty_exclude.txt` пуст, ошибок 0. Новая ошибка RuSTy — исправить или исключить файл с причиной ([STATIC_ANALYSIS.md](STATIC_ANALYSIS.md#rusty-plc---check)) |
| coUnit: тест на несколько циклов | состояние — в `VAR` набора (локальные переменные метода создаются заново); пока тест не завершён, тело набора вызывает **все** его методы каждый цикл (ассерты завершённых пропускаются), поэтому многоцикловый тест — в небольшом наборе (`FB_Runtime_Test`) |
| CODESYS | предупреждение C0371 (обращение к `VAR_IN_OUT` из метода) считается ошибкой: сборка тестов — 0 предупреждений |

## Вспомогательные ФБ (`tests/POUs/Helpers/`)

`FB_TestSink` (`IMPLEMENTS I_AlarmSink`) — тестовый приёмник событий тревог, кольцо на 32 события:

| Член | Что делает |
|---|---|
| `OnAlarmEvent(stEvent)` | запись события (самое старое затирается), всегда `TRUE` |
| `Count : UINT` | событий с последнего `Clear` |
| `Last : ST_AlarmEvent` | последнее событие (пустое, если событий нет) |
| `GetEvent(uiBack) : ST_AlarmEvent` | событие `uiBack` событий назад (0 — последнее); сверх контракта |
| `Clear()` | забыть все события |

Новый общий помощник (например, `FB_FopdtModel` команды ПИД) — своя папка в `Helpers/` и свой тест.
Метод, добавленный в чужой помощник, — отдельный файл; объявление и тело помощника не меняются.

## Тестовое устройство

`FB_TestDevice EXTENDS FB_DeviceBase` (`tests/POUs/Helpers/FB_TestDevice/`) — наследник базы для
тестов `FB_DeviceBase_Test` и **рабочий образец порядка тела устройства** (9.4 контракта): `ResolveTime`
до вложенного `FB_Delay`, первый вызов (`uiAlarmCount`, `eDevType`, у AI/DI-подобного — `stModeMem`),
`BeginCycle`, `AcceptCfg(CheckConfig)` с LKG, Reset с фиксируемым отказом, `ProcessMode`, команды
пуск/стоп («Стоп» в Auto — `SwitchRemoteMode`), безопасный выход, `RunAlarms`, `FinishCycle`, хук
`OnModeChanged` (безударность, снятие отказа при входе в OutOfService).

| Вход | Что задаёт |
|---|---|
| `xAutoRun`, `xLocal`, `xMoving`, `xFaultCause`, `xShedToManual` | запрос автоматики, переключатель «Местное», механизм в движении (OOS запрещён), причина механического отказа, перевод логикой в Manual |
| `xInputLike`, `xLocalSupported` | AI/DI-подобное устройство: режим в `stModeMem`, Manual = CheckFunction, без Local (задаются до первого вызова) |
| `uiAlarmSlots`, `eTypeSel` | число слотов тревог и тип (в первом вызове) |
| `eDevStatusIn`, `wWarnIn` | вклад логики в NE 107, предупреждения |
| `axCondIn[0..7]`, `axSuppressIn[0..7]`, `rValueIn` | условия и подавление слотов, значение для событий (пишутся по имени: `fbDev.axCondIn[1] := TRUE;`) |

Cfg — `ST_TestDeviceCfg` (`rGain` > 0 и конечен — иначе бит 0 `wCfgErr`; `tRunDelay`; поля тревог),
результат — `xOutput`, `rOut_eu = rGain · 10` по LKG. Журнал хука (`uiHookCalls`, `eHookOld`,
`eHookNew`, `xHookInFirst`, `udiHookTrace`) и счётчик тел (`uiBodyCalls`) тесты читают по имени
экземпляра — это тестовое устройство, правило R6 к нему не относится. Наследники:
`FB_TestDeviceExt` (тело через `SUPER^`, хук второго уровня — проверки R2, R3) и
`FB_TestDeviceNoSuper` (тело без `SUPER^` — L1). Значение вне строгого перечисления — через
`U_TestEnumInt` (`uBad.iValue := 7; stRetain.eRemoteMode := uBad.eMode;`), приоритет слота —
помощником набора `SetSlotCfg`.

Командам устройств: тесты своего устройства пишутся на настоящем ФБ, а не на `FB_TestDevice`;
поведение базы (режимы, LKG, NE 107, маски тревог) уже проверено — повторять его не нужно, кроме
мест, где устройство его меняет (свой `xOosAllowed`, `xLocalSupported`, хук).

## Чек-лист устройства

База проверена на тестовом устройстве. Устройство отвечает за то, что задаёт само, — и проверяет
это тестами своего набора на настоящем ФБ:

| № | Что задаёт устройство | Как не ошибиться | Чем проверить |
|---|---|---|---|
| 1 | Первый вызов: `uiAlarmCount := GVL_Const.<DEV>_ALARM_COUNT`, `eDevType` (у `FB_Motor` — только при `eDevType = None`); у AI/DI ещё `xManualIsCheck := TRUE` и `stModeMem.eRemoteMode := E_DeviceMode.Auto` | блок `IF xFirstCall` — **до** `ProcessMode` (как у тестового устройства), иначе AI/DI первый цикл проведёт в Manual | тип в `stSts.stCommon.eDevType`, режим после первого вызова |
| 2 | Результат `xReset` и `Reset()` | пишет устройство в шаге 3 (`SetCmdResult`), **даже если фиксируемых отказов нет** (AI, DI): `RunAlarms` квитирует тревоги, но результата сброса не пишет. Без этого `uiCmdSeq` на сброс не вырастет | `xReset` → `Accepted`, `uiCmdSeq` + 1 |
| 3 | `xOosAllowed`, `xLocalSupported`, `xLocalSel` для `ProcessMode` | значения — из раздела устройства в контракте (механизм движется — вывод из работы запрещён) | `xSetOos` при работе или движении → `RejectedState`; Local у типа без Local не включается |
| 4 | Безопасный выход без корректной Cfg с первого вызова | ветка `NOT xCfgEverOk` в шаге 6, таблица 2.6 контракта | тест `<Dev>_InvalidCfg*` из списка 23.2 |
| 5 | Хук `OnModeChanged` | первым — `SUPER^.OnModeChanged(eOld := eOld, eNew := eNew)`; безударность; вход в OutOfService снимает фиксацию; `VAR_IN_OUT` не трогать (R2, C0371); хук вызывается и в первом цикле, если режим из `stRetain` не Manual (`xFirstCall = TRUE`) | тесты безударности и `Device_OosEntry_*`-подобный тест устройства |
| 6 | Слоты тревог | индекс — `E_<Dev>Alarm`, условие, подавление и `arAlmValue` — по таблице слотов устройства; приоритеты по умолчанию — в DUT, `CheckConfig` вызывает `CheckAlarmCfg(astCfg := stCfgIn.astAlarm)` | тест тревоги устройства через `GetAlarm(uiIndex := E_<Dev>Alarm.X)` |
| 7 | Константы | маски и пределы — только в `GVL_Const`, в конце блока своего устройства; локальные `VAR CONSTANT` у тестового устройства — исключение для тестов, в ФБ библиотеки их нет | `st_lint.py --strict` (STL008), pytest |
| 8 | Наследник с телом базы через `SUPER^(...)` (`FB_MotorVfd`) | после `SUPER^` тело базы уже выполнило `FinishCycle`: `xFirstCall = FALSE`, `ltPrevCall = ltNow`, `stSts.stCommon` записан; `ltNow` и `ltDt` ещё действительны. Что нужно знать о первом вызове — запомнить **до** `SUPER^`; точки расширения пишутся до `SUPER^`, `ResolveTime()` — первым | `MotorVfd_FirstCallFakeTime_CommLossDeterministic` |
| 9 | Отклонение запроса режима по своим причинам (ПИД: Auto без Cfg или с негодной PV, 17.2) | до `ProcessMode`: снять `stCmd.stCommon.xSetAuto` и `xModeReq` (если `eModeReq = E_DeviceMode.Auto`), записать `SetCmdResult(RejectedCfg / RejectedFault)` | `Pid_SetAutoWithInvalidPv_Rejected` |
| 10 | Порядок результатов | `eCmdResult` — последней команды в порядке тела: Reset → режим → команды устройства → `xAck`/`AckAll()` и маски тревог (F-28) | — |

Тесты `Device_DevType_ReportedInStsCommon` и `Device_DefaultCfg_PassesCheck` (все семь типов в одном
тесте, F-26) — в наборе `FB_Integration_Test` ([ниже](#межсемейные-тесты)); команда проверяет
пункты 1 и 4 и умолчания своей Cfg и в своём наборе.

## Межсемейные тесты

`FB_Integration_Test` (`tests/POUs/Suites/FB_Integration_Test/`, регистрация —
`GVL_TestsIntegration`) проверяет все семь типов устройств вместе, на настоящих ФБ (тесты 23.2,
отложенные основой до слияния семейств, F-26):

| Тест | Что проверяет |
|---|---|
| `Device_DefaultCfg_PassesCheck` | умолчания Cfg семи типов проходят `CheckConfig`: после первого вызова `wCfgErr = 0` и нет бита `DEV_STS_CFG_ERROR` (инвариант генератора, 2.3 и 20) |
| `Device_DevType_ReportedInStsCommon` | до первого вызова `eDevType = None`, после — свой `E_DeviceType` у каждого типа; `FB_MotorVfd` — `MotorVfd`, а не `Motor`, и во втором вызове тоже |
| `Device_AllTypes_AlarmCountThroughIDevice` | все семь типов доступны через `I_Device`: `AlarmCount` = `<DEV>_ALARM_COUNT`, слот 0 доступен через `GetAlarm`, режим — из перечисления |

Семь экземпляров со структурами — локальные переменные метода (R5: стека задачи хватает, прогон
Control Win V3).

## Зонды времени выполнения

`FB_Runtime_Test` отвечает тестами на вопросы раздела 24.2 контракта и ограничения 2.8, которые
решаются на Control Win V3: монотонность и разрешение `LTIME()` (`Runtime_LTime_*`, один тест идёт
50 циклов задачи), связывание вызова без `THIS^` (`FB_ProbeHookBase`/`FB_ProbeHookDerived`),
частичный инициализатор массива структур, беззнаковая арифметика, локальные экземпляры устройств в
стеке метода, цена копирования LKG. Ответы и числа — [TEST_REPORT.md](TEST_REPORT.md#вопросы-раздела-242-контракта-ответы-прогона)
и [ASSUMPTIONS.md](ASSUMPTIONS.md). Тест с реальным временем допустим только здесь и в
`Time_SystemTime_IsMonotonic`: он ничего не ждёт сверх циклов задачи.

## Наборы основы

| Набор | Тестов | Из контракта (★ / всего) | Сверх контракта | Что покрыто |
|---|---|---|---|---|
| `FB_Time_Test` | 24 | 10 / 15 | 9 | `F_LTimeToSec`, `F_TimeToSec`, `FB_FakeTime`, `FB_SystemTime`, `FB_Delay`: задержки включения, отключения и обе, короткие импульсы и провалы, смена задержки в отсчёте, `Preset`, время назад, первый вызов, без источника времени, `tRemaining` и флаги отсчёта |
| `FB_Util_Test` | 26 | 5 / 12 | 14 | `F_IsFinite` (NaN, ±Inf, денормализованные, граница `REAL_SANE_MAX`), `F_Ne107Worst`, `F_RateLimit` (скорости роста и спада, 0, dt ≤ 0, мусорная цель и текущее значение, без перелёта), `FB_StartsWindow` (скользящий час, граница часа, кольцо, время назад, `TimeToFree`, `Clear`, ёмкость), `FB_LimitMonitor` (гистерезис верхней и нижней, задержки, `xForceOff`, выключение, неконечное значение) |
| `FB_Common_Test` | 11 | 2 / 2 | 9 | `SIZEOF` Sts (таблица 4.6), Retain, Cfg, Cmd, `ST_AlarmCfg`; умолчания Cfg, Sts, Retain по контракту; коды перечислений; слоты тревог; ссылки на интерфейсы; `FB_TestSink` и `GVL_Lib.itfAlarmSink` |
| `FB_Alarm_Test` | 38 | 9 / 18 | 20 | все переходы ISA-18.2, задержки появления и снятия с границами, shelve (таймаут с повторным оповещением, обрезка, запрет, повторный, остаток, время назад, под подавлением и OOS), подавление, OutOfService, правила квитирования, приоритет None и вне перечисления, события и их порядок, `I_Alarm`, без источника времени |
| `FB_DeviceBase_Test` | 44 | 7 / 15 (+2 в `FB_Common_Test`) | 29 | на `FB_TestDevice`: режимы (санитизация retain, старшинство запросов, Local и возврат в запомненный режим, OOS при движении и выход в Local, retain OOS при старте, `SwitchRemoteMode`), результат и номер команд, сброс импульсов, LKG при старте и в работе, приоритет тревоги в Cfg, сводный NE 107 и все поля `stCommon`, безопасное состояние и Reset, тревоги в слотах (маски, OOS устройства, номера, сводка, 0 слотов), время цикла, `I_Device`, хук и `SUPER^` (R2, R3, L1) |
| `FB_Runtime_Test` | 8 | — | 8 | R1 (по циклам задачи и внутри цикла), L6, R9, L7, счётчики по кругу, R5, R13 |
| **Всего** | **151** | **33 / 62** | **89** | |

Тесты `Device_DevType_ReportedInStsCommon` и `Device_DefaultCfg_PassesCheck` (все семь типов) —
в `FB_Integration_Test` ([выше](#межсемейные-тесты)). Наборы семейств — в `docs/fb/<ФБ>.md`, раздел
«Тесты»; итоги по наборам и список тестов с описаниями — [TEST_REPORT.md](TEST_REPORT.md).

## Как запускать

```bat
python tools\codesys\cds.py build --tests       :: сборка тестового приложения: 0 ошибок, 0 предупреждений
python tools\codesys\cds.py test                :: импорт, сборка, прогон в Control Win (~20 с)
python tools\codesys\cds.py report              :: итоги последнего прогона -> docs/TEST_REPORT.md
python tools\codesys\cds.py roundtrip           :: импорт -> экспорт -> побайтное сравнение
python -m pytest                                :: инструменты и соглашения tools/project_checks/
python tools\check\st_lint.py --strict
python tools\check\run_iec_checker.py --tests
python tools\check\run_rusty.py
```

- `cds.py test` печатает итог (`наборов 6, тестов 151, пройдено 151`); по наборам и тестам —
  `build/test.log`, `build/test-results.json`, `build/junit.xml`. Если набора нет в итоге, а в
  исходниках он есть, — проверьте `linkalways` в его GVL (это же ловит pytest).
- Рантайм один на машину: `cds.py test` ждёт глобальную блокировку, если тесты гоняет другой
  репозиторий («ожидание блокировки …»), — просто подождать.
- Сообщение упавшего теста — текст `Message` первого упавшего ассерта; ожидаемое и фактическое
  значения coUnit в нём не показывает, поэтому в `Message` пишут, что именно ожидалось.
- Проверка, что тесты ловят ошибки: на этапе 1 три однобуквенные мутации (`>=` → `>` в `FB_Delay`,
  `<=` → `<` в `F_IsFinite`, `>=` → `>` в `FB_StartsWindow.Count`) уронили 22 теста из 59 (прогон
  16.10.2026); после отката — снова все зелёные. На этапе 2 — шесть мутаций `FB_Alarm` и
  `FB_DeviceBase`; на ревью основы — 17 мутаций, четыре из них не ловил ни один тест: добавлены шесть
  тестов (пять — на непойманные мутации, один — на найденную ошибку `RunAlarms`), теперь каждую неэквивалентную мутацию ловит хотя бы один тест
  ([TEST_REPORT.md](TEST_REPORT.md#мутационная-проверка-ревью-основы-перед-устройствами)). Свою мутационную
  проверку стоит сделать и командам устройств: копия репозитория, одна однострочная мутация на прогон.

## Чьи файлы

| Файл | Кто правит |
|---|---|
| `tests/GVLs/GVL_Tests<Семейство>.gvl.st`, `tests/POUs/Suites/FB_<X>_Test/` | команда семейства |
| `tests/POUs/PRG_Tests/` | никто |
| `tests/GVLs/GVL_TestsFoundation.gvl.st`, `tests/GVLs/GVL_TestsAlarm.gvl.st`, наборы основы, `FB_TestSink`, `FB_TestDevice` и его наследники, `tests/DUTs/TestDevice/` | основа (этапы 1–2) |
| `src/GVLs/GVL_Const.gvl.st` | основа; новые константы семейства — в конец блока своего устройства |
| `tools/check/iec_checker_allow.toml` | общие записи — основа; записи семейства — в своём разделе в конце файла |
| `tools/check/rusty_exclude.txt` | строка на файл с причиной; своё семейство — свои строки |
| `docs/TEST_REPORT.md` | раздел прогона пишет `cds.py report`; таблицу «что проверяют тесты» — команда своего набора |
