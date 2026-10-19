# Статический анализ

Находки компилятора CODESYS, `st_lint`, `iec_checker` и RuSTy, которые не исправлены в коде, — с
обоснованием. Исправленные находки сюда не пишутся (кроме обходов ограничений инструментов: они
меняют вид кода, и это нужно объяснить).

## Как запускается

| Инструмент | Где | Вход | Отчёт |
|---|---|---|---|
| `tools/codesys/cds.py build --tests` | локально, Windows с CODESYS 3.5.17.30 | тестовое приложение: `src/` и `tests/` | `build/build.log`, `build/build.json` |
| `tools/codesys/cds.py check --tests` | то же | все объекты `src/` и `tests/` в пуле проекта, в том числе недостижимые из задач | `build/check.log`, `build/check.json` |
| `tools/codesys/cds.py library` | то же | `src/` без `PRG_Main` — проверка пула библиотеки | `build/library.log`, `build/library.json` |
| `tools/check/st_lint.py --strict` | локально и в CI | `src/`, `tests/` | вывод в консоль, код выхода ≠ 0 при нарушениях |
| `tools/check/run_iec_checker.py --tests` | локально и в CI (обязательно): iec_checker v0.4 | `build/assembled/iec-checker/` (вариант сборки `iec-checker`) | `build/iec_checker.json`, `build/iec_checker.md` |
| то же с `--docker` | CI, необязательное задание: образ `jubnzv1/iec-checker:nightly` | то же | артефакт `iec-checker-nightly-reports` |
| `tools/check/run_rusty.py` | локально и в CI (необязательное задание): RuSTy 1.0.6 `plc --check` | `build/assembled/rusty/` (`src/` и `tests/`) | `build/rusty.log`, `build/rusty.json` |

Обоснования iec_checker — `tools/check/iec_checker_allow.toml`; тест шаблона
`test_integration_repository_sources` требует, чтобы при прогоне с `--tests` использовалась каждая
запись, а без `--tests` и с ним — 0 необоснованных находок (иначе красный `pytest`).

## Последний прогон

<!-- static-analysis:last-run -->
| Дата | Инструмент | Вход | Итог |
|---|---|---|---|
| 2026-10-19 | CODESYS 3.5.17.30, `cds.py build --tests` | тестовое приложение | 0 ошибок, 0 предупреждений (в том числе нет C0371) |
| 2026-10-19 | `cds.py check --tests` | 116 объектов `src/` и `tests/` | 0 ошибок, 0 предупреждений |
| 2026-10-19 | `cds.py library` (1.0.0.0) | 79 объектов библиотеки (`src/` без `PRG_Main`) | проверка пула: 0 ошибок, 0 предупреждений |
| 2026-10-19 | `st_lint --strict` | `src/`, `tests/` (1332 файла) | 0 ошибок, 0 предупреждений; подавлений `lint:allow` нет |
| 2026-10-19 | `run_iec_checker.py` (iec_checker 0.4, Windows) | 80 объектов `src/` | ошибок разбора нет; необоснованных 0; обоснованных 1075; артефактов сборки 483 |
| 2026-10-19 | `run_iec_checker.py --tests` | 116 объектов `src/` и `tests/` | ошибок разбора нет; необоснованных 0; обоснованных 5192; артефактов 522; неиспользованных обоснований нет |
| 2026-10-19 | `run_rusty.py` (RuSTy 1.0.6) | 117 файлов `build/assembled/rusty/`, исключённых нет | 0 ошибок; 399 предупреждений (разбор ниже) |
| — | iec_checker 0.4 и `nightly` (CI, Linux) | 116 объектов | _перенести из отчёта CI_ |
<!-- /static-analysis:last-run -->

## Компилятор CODESYS

- Рабочая и тестовая сборки — 0 ошибок, 0 предупреждений; `check --tests` — тоже.
- **C0371** («обращение к `VAR_IN_OUT` из внешнего контекста», метод читает или пишет `VAR_IN_OUT`
  экземпляра) по контракту (R2) считается ошибкой. `cds.py build` роняет сборку только на ошибках,
  поэтому критерий для библиотеки — «предупреждений 0» в итоге сборки. В основе `VAR_IN_OUT` есть
  только у параметров методов (`I_AlarmSink.OnAlarmEvent`; у `FB_DeviceBase` — `ProcessMode`,
  `SwitchRemoteMode`, `RunAlarms`, `FinishCycle`, `CheckAlarmCfg`): методы получают структуры
  параметром и к `VAR_IN_OUT` экземпляра не обращаются. Хуки наследников (`OnModeChanged`)
  `VAR_IN_OUT` устройства не трогают; у устройств методы-шаги получают `stCfgIn`/`stCmd` параметром
  так же.
- Рабочая сборка проверяет только объекты, достижимые из задач (F-03 в
  [ASSUMPTIONS.md](ASSUMPTIONS.md)): проверку всей библиотеки дают `build --tests` и `check --tests`.

## st_lint

Подавлений `lint:allow` в `src/` и `tests/` нет. До синхронизации инструментов с шаблоном их было
48 (F-13): правило STL007 ждало заглавную букву сразу после префикса массива `a`, а `VAR_IN_OUT
CONSTANT` принимало за секцию констант. Линтер шаблона теперь понимает оба случая:

| Что | Как проверяет `st_lint` шаблона | Примеры в библиотеке |
|---|---|---|
| составной префикс массива: `a` + префикс типа элемента | `array_element_prefixes = "match"` в `tools/check/st_lint.toml`: префикс элемента должен соответствовать типу | `astAlarm` (ARRAY OF `ST_*`), `afbAlarm`, `afbLimit` (`FB_*`), `aitfDev` (`I_*`), `altStart` (LTIME), `axAlmCond` (BOOL), `arAlmValue` (REAL), `audiReserve` (UDINT) |
| `VAR_IN_OUT CONSTANT` — параметр только для чтения | префикс по типу, а не UPPER_SNAKE_CASE | `stCfg`, `stCfgIn`, `stEvent`, `astCfg` |

`tools/check/st_lint.toml` принадлежит проекту и совпадает с файлом шаблона; тест шаблона
`test_repository_toml_is_valid` проверяет, что каждый его ключ известен линтеру.

## iec_checker 0.4: находки

| Правило | Где | Находка | Решение / обоснование |
|---|---|---|---|
| PLCOPEN-CP3 | `src/*`, `tests/*` | «Variable … shall be initialized before being used» | Обосновано (общая запись). Переменная без явного начального значения получает значение по умолчанию своего типа (МЭК 61131-3, как в CODESYS). Вариант сборки `iec-checker` удаляет неконстантные начальные значения (`:= E_DeviceMode.Manual`), отсюда часть находок; находки на копиях переменных в методах, вынесенных в функции, — артефакты сборки |
| UnusedVariable | `src/*`, `tests/*`: имена с префиксами `st`, `fb`, `itf` | «Found unused local variable» | Ложное срабатывание (общая запись): обращение к полям структуры, вызов экземпляра ФБ и его методов, аргумент `SIZEOF` iec_checker 0.4 использованием не считает. Префикс объединения `u` в общую запись не включён: в сообщении имя в верхнем регистре, `UBITS` не отличить от `UINEXT`; `UBITS` (`U_RealBits`) — отдельная запись |
| UnusedVariable | `src/*`: массивы структур и ФБ (`ast…`, `afb…`, `aitf…`) | то же | Ложное срабатывание (общая запись): к массиву обращаются только через поле элемента (`astCfg[i].ePriority` в `FB_DeviceBase.CheckAlarmCfg`); понижение пишет такое обращение как `astCfg.ePriority[i]`, а поле iec_checker 0.4 использованием не считает — как у структур (`tools/README.md`, «Что понижение скрывает и добавляет») |
| UnusedVariable | `FB_Delay`: `tOnDelay`, `tOffDelay` | то же | Ложное: входы используются только как аргументы `SEL(xIn, tOffDelay, tOnDelay)` |
| UnusedVariable | `F_LTimeToSec`: `ltIn` | то же | Ложное: вход — аргумент вложенного преобразования `ULINT_TO_LREAL(LTIME_TO_ULINT(ltIn))` |
| UnusedVariable | `FB_FakeTime`: `ltNow`; `FB_StartsWindow`: `altStart`, `uiNext`, `uiUsed`; `FB_TestSink`: `EVENTS_MAX`, `astEvent`, `uiNext`, `uiCount` | то же | Артефакт понижения: переменные используют только методы, которые сборка выносит в отдельные функции; тел у ФБ нет. Константа в границе массива (`EVENTS_MAX`) понижением заменена числом |
| UnusedVariable | `Util_StartsWindow_RingCapacity_MatchesConst`: `ltOne` | то же | Ложное: переменная — аргумент `SIZEOF` |
| PLCOPEN-CP9 | `FB_LimitMonitor` | «Code is too complex (19 McCabe complexity)» | Обосновано. Классическая цикломатическая сложность тела — 5 (4 точки ветвления); iec_checker 0.4 считает завышенно (одна конструкция `IF … ELSE … END_IF` прибавляет 5). Делить короткую линейную логику на методы ради метрики — хуже для чтения |
| PLCOPEN-CP9 | `tests/*` | то же, 16…40 | Обосновано: методы-тесты — последовательности вызовов и проверок без ветвлений |
| PLCOPEN-CP9 | `FB_Alarm` | «Code is too complex» | Обосновано. Классическая сложность: тело 8, `UpdateShelve` 8, `UpdateState` 18 — таблица переходов ISA-18.2 одной цепочкой `IF/ELSIF`, строка в строку с таблицей 10.2 контракта |
| PLCOPEN-CP9 | `FB_DeviceBase` | то же | Обосновано. Классическая сложность методов: `RunAlarms` 14, `ProcessMode` 11, `FinishCycle` 11; каждый метод — один шаг цикла по контракту (9.3, 10.5) |
| PLCOPEN-CP9 | устройства: `FB_AnalogInput`, `FB_DigitalInput`, `FB_Motor`, `FB_MotorVfd`, `FB_Valve`, `FB_ControlValve`, `FB_PID` | то же | Обосновано записями разделов семейств в `iec_checker_allow.toml` с классической сложностью тела и каждого метода (наибольшие: тело `FB_Motor` 81 — автомат 13.7 одной цепочкой, по шагам ≤ 27; `FB_Valve.DriveToTarget` 20; тело `FB_PID` 27). Защищённые методы-шаги семейств (AI-1, DI-5, VLV-18, CV-10, P-06 в [ASSUMPTIONS.md](ASSUMPTIONS.md)) снизили сложность тел |
| PLCOPEN-L17 | `src/*`, `tests/*` | «Each IF instruction should have an ELSE clause» | Обосновано (общие записи). Правило стиля PLCopen; где `ELSE` нет, состояние в этом вызове сознательно не меняется. Заглушка `x := x;` хуже для чтения |
| UnusedVariable | `FB_Alarm`, `FB_DeviceBase`, устройства: переменные, которые используют только методы | то же | Артефакт понижения: методы вынесены сборкой в функции; тело `FB_DeviceBase` и хук `OnModeChanged` пусты по контракту (9.1, 9.3). Списки имён — в записях `iec_checker_allow.toml` |
| UnusedVariable | тесты: `FB_TestDevice` (константы, журнал хука), `FB_TestDeviceExt`, `FB_Runtime_Test` (состояние многоциклового теста), `FB_FopdtModel`, индексы помощников (`SetSlotCfg.uiSlot`, `SetLimit.uiIdx` …), объединения `uBad`, `uEnum`, `uPrio` | то же | Артефакт понижения (используют методы) или ложное срабатывание: индекс массива, граница цикла `FOR` и поля объединения iec_checker использованием не считает |

## Обходы разборщика: что снято после синхронизации с шаблоном

Понижение `iec-checker` шаблона (`tools/st_flavors.py`) теперь разбирает конструкции, которые
библиотека раньше обходила. Каждый обход снят и проверен прогоном инструментов (16.10.2026):
`run_iec_checker.py --tests` — 0 ошибок разбора и 0 необоснованных находок, `st_lint --strict` — 0,
`run_rusty.py` — 0 ошибок, CODESYS `build --tests` и `check --tests` — 0/0, `cds.py test` — все тесты
зелёные.

| № | Было (обход) | Стало | Чем подтверждено |
|---|---|---|---|
| F-07 | `FB_StartsWindow.altStart : ARRAY[0..29]` | `ARRAY[0..GVL_Const.STARTS_WINDOW_MAX - 1]` | понижение подставляет значение константы; тест `Util_StartsWindow_RingCapacity_MatchesConst` |
| F-08 | `FB_SystemTime.Now`: `LTIME()` в инициализаторе локальной переменной | `Now := LTIME();` в теле | понижение `LTIME()` → `CDS__LTIME()`; исчезла ошибка E033 RuSTy; `Time_SystemTime_IsMonotonic` |
| F-13 | 48 подавлений `// lint:allow STL007` | подавлений нет | `st_lint --strict` — 0 замечаний |
| F-18 | границы `[0..7]` у `afbAlarm`, `axAlmCond`, `axAlmSuppress`, `arAlmValue`, параметров `astCfg` (`CheckAlarmCfg`, `RunAlarms`); в тестах — `FB_TestDevice.axCondIn/axSuppressIn`, `ProbeAlarmCfg`, `FB_TestSink` (32), `FB_Runtime_Test` (50), `FB_FopdtModel` (40) | `GVL_Const.DEV_ALARMS_MAX - 1` и локальные `VAR CONSTANT` (`EVENTS_MAX`, `RT_SAMPLES`, `RING_SIZE`) | `Device_AlarmSlotArrays_MatchDevAlarmsMax`, `Device_DefaultAlarmCfgOfAllTypes_PassesCheckAlarmCfg` |
| F-19 | метод `FB_DeviceBase.CallAlarmSlot` (слот через `VAR_IN_OUT`), сводка через `I_Alarm` слота, бит маски сдвигом переменной; копия слота в `CheckAlarmCfg` | вызов `afbAlarm[i](...)`, `afbAlarm[i].Active`/`.Ack()`, `SHL(WORD#16#0001, i)`, `astCfg[i].ePriority`; метод удалён | все тесты `FB_Alarm_Test`, `FB_DeviceBase_Test` и устройств; одна новая общая запись UnusedVariable для массивов (выше) |
| F-24 и разделы семейств | 27 файлов в `tools/check/rusty_exclude.txt` и 10 известных ошибок E034/E036/E031 (`VAR_IN_OUT CONSTANT`) | исключений нет, ошибок нет | замена R13 варианта `rusty`; `run_rusty.py`: 116 файлов, 0 ошибок |

Что осталось в коде сознательно:

| Где | Форма | Почему |
|---|---|---|
| `I_Alarm.AlarmPriority`, `FB_Alarm.AlarmPriority` | имя свойства не `Priority` (F-17) | `PRIORITY` — ключевое слово МЭК 61131-3 (объявление задачи `TASK … (PRIORITY := …)`): член с таким именем непереносим между средами. Понижение шаблона переименовало бы `Priority` → `Priority_`, но решение — не от инструмента |
| `FB_Motor`, `FB_PID` | `SEL(x, a, b)` вместо `SEL(NOT x, b, a)` | iec_checker 0.4 не разбирает `NOT` в начале позиционного аргумента, понижение этого не меняет; смысл тот же |
| `FB_AnalogInput.CallLimit`, копии элементов (`stLim := stCfgIn.astLimit[i]`), помощники тестов `SetLimit`, `SetSlotCfg`, `SetSlotPriority`, `SetAlarmPriority`, `CallDevice` | метод или копия элемента | появились как обходы разборщика, теперь не обязательны; оставлены — короче условия и шаги (AI-1) |

Командам и следующим правкам: пустую ветвь `ELSE`, `JMP`, метки `CASE` с константами библиотек,
`NOT NOT x`, обращение к результату вызова `F(x).y` iec_checker 0.4 по-прежнему не разбирает —
перед коммитом `run_iec_checker.py --tests` (таблица понижения — `tools/README.md`).

## RuSTy (`plc --check`)

RuSTy 1.0.6 проверяет синтаксис и типы варианта сборки `rusty` (`src/` и `tests/`, 117 файлов);
компоновки нет. Пространство имён `coUnit.` убирается, объявления coUnit — из прокладок шаблона.
`VAR_IN_OUT CONSTANT` вариант сборки понижает до `VAR_IN_OUT` (замена R13 шаблона): типы и передача
по ссылке проверяются, запрет записи в параметр — нет (его проверяет компилятор CODESYS).
`tools/check/rusty_exclude.txt` пуст. Ошибок нет; предупреждения:

| Предупреждение | Где | Сколько | Обоснование |
|---|---|---|---|
| E049 «Illegal access to private member» | наследники `FB_DeviceBase` и `FB_Motor`, тесты, читающие переменные экземпляра | 359 | В CODESYS переменные `VAR` базы доступны наследнику (контракт 9.1), тесты читают внутренние переменные намеренно (тестовое устройство, раскладка) |
| E067 «Implicit downcast» | `SIZEOF` в тестах (`ULINT` → `UDINT`), сравнения перечислений в аргументе `Condition` (`FB_Motor_Test`, `FB_MotorVfd_Test`, `FB_Valve_Test`), `UINT + 1` в `FB_StartsWindow.Register` | 34 | Разница типов RuSTy: `SIZEOF` — `ULINT`, `UINT + 1` — `DINT`, результат сравнения в именованном аргументе он относит к типу перечисления. В CODESYS предупреждений нет (сборка 0/0) |
| E091 «Value evaluated at run-time, use an enum variant» | `F_Ne107Worst` и `RunAlarms` (`MAX` от перечислений) | 2 | `MAX` строгого перечисления — разрешённая в CODESYS конструкция (зонд P13 контракта) |
| E040 «Non-standard enum value» | `Device_RequestMode_SameEffectAsCmd`, `Device_OosRepeatWhileMovingInOos_Accepted` | 3 | Аргумент `eNewMode := E_DeviceMode.OutOfService` метода — обычное значение перечисления; ложное срабатывание RuSTy |
| E127 «Fewer initial values for array» | `Runtime_PartialArrayInitializer_RestGetsElementDefaults` | 1 | Тест намеренно проверяет частичный инициализатор массива (R9 контракта) |

## Ограничения разборщика, которые понижение уже обходит

Методы и свойства внутри `FUNCTION_BLOCK`, `IMPLEMENTS`/`EXTENDS`, прагмы, `VAR_GLOBAL` вне
конфигурации, массивы в `STRUCT`, базовый тип перечисления, неконстантные начальные значения,
константы в границах массивов, `TIME()`/`LTIME()`, `a[i].x`, вызов элемента массива ФБ, типизированные
литералы, строки с кириллицей и пробелами — подробно в [LAYOUT.md](LAYOUT.md#собранный-текст-buildassembled)
и `tools/README.md`.
