# Статический анализ

Находки компилятора CODESYS, `st_lint`, `iec_checker` и RuSTy, которые не исправлены в коде, — с
обоснованием. Исправленные находки сюда не пишутся (кроме обходов ограничений инструментов: они
меняют вид кода, и это нужно объяснить).

## Как запускается

| Инструмент | Где | Вход | Отчёт |
|---|---|---|---|
| `tools/codesys/cds.py build --tests` | локально, Windows с CODESYS 3.5.17.30 | тестовое приложение: `src/` и `tests/` | `build/build.log`, `build/build.json` |
| `tools/check/st_lint.py --strict` | локально и в CI | `src/`, `tests/` | вывод в консоль, код выхода ≠ 0 при нарушениях |
| `tools/check/run_iec_checker.py --tests` | локально и в CI (обязательно): iec_checker v0.4 | `build/assembled/iec-checker/` (вариант сборки `iec-checker`) | `build/iec_checker.json`, `build/iec_checker.md` |
| то же с `--docker` | CI, необязательное задание: образ `jubnzv1/iec-checker:nightly` | то же | артефакт `iec-checker-nightly-reports` |
| `tools/check/run_rusty.py` | локально и в CI (необязательное задание): RuSTy 1.0.6 `plc --check` | `build/assembled/rusty/` (`src/` и `tests/`) | `build/rusty.log`, `build/rusty.json` |

Обоснования iec_checker — `tools/check/iec_checker_allow.toml`; тест шаблона
`test_integration_repository_sources` требует, чтобы при прогоне с `--tests` использовалась каждая
запись, а без `--tests` и с ним — 0 необоснованных находок (иначе красный `pytest`).

## Последний прогон

| Дата | Инструмент | Вход | Итог |
|---|---|---|---|
| 2026-10-16 | CODESYS 3.5.17.30, `cds.py build` / `build --tests` | рабочее и тестовое приложения | 0 ошибок, 0 предупреждений (в том числе нет C0371) |
| 2026-10-16 | `st_lint --strict` | `src/`, `tests/` (582 файла) | 0 ошибок, 0 предупреждений; 30 подавлений `lint:allow STL007` |
| 2026-10-16 | `run_iec_checker.py` (iec_checker 0.4, Windows) | 72 объекта `src/` | ошибок разбора нет; необоснованных 0; обоснованных 280; артефактов сборки 142 |
| 2026-10-16 | `run_iec_checker.py --tests` | 91 объект `src/` и `tests/` | ошибок разбора нет; необоснованных 0; обоснованных 1427; артефактов 176 |
| 2026-10-16 | `run_rusty.py` (RuSTy 1.0.6) | 82 файла `build/assembled/rusty/`, 10 исключены | 4 известные ошибки (E033 `FB_SystemTime`; E036, E034 ×2 — `VAR_IN_OUT CONSTANT` в `FB_Alarm`, `FB_DeviceBase`), предупреждения ниже |
| — | iec_checker 0.4 и `nightly` (CI, Linux) | 91 объект | _перенести из отчёта CI_ |

## Компилятор CODESYS

- Рабочая и тестовая сборки — 0 ошибок, 0 предупреждений.
- **C0371** («обращение к `VAR_IN_OUT` из внешнего контекста», метод читает или пишет `VAR_IN_OUT`
  экземпляра) по контракту (R2) считается ошибкой. `cds.py build` роняет сборку только на ошибках,
  поэтому критерий для библиотеки — «предупреждений 0» в итоге сборки. В основе `VAR_IN_OUT` есть
  только у параметров методов (`I_AlarmSink.OnAlarmEvent`; у `FB_DeviceBase` — `ProcessMode`,
  `SwitchRemoteMode`, `RunAlarms`, `FinishCycle`, `CheckAlarmCfg`, `CallAlarmSlot`): методы получают
  структуры параметром и к `VAR_IN_OUT` экземпляра не обращаются. Хуки наследников (`OnModeChanged`)
  `VAR_IN_OUT` устройства не трогают.
- Рабочая сборка проверяет только объекты, достижимые из задач (F-03 в
  [ASSUMPTIONS.md](ASSUMPTIONS.md)): проверку всей библиотеки даёт тестовая сборка.

## st_lint

Подавления (все — `// lint:allow STL007 …` в строке перед объявлением, F-13):

| Где | Что | Почему не исправлено |
|---|---|---|
| `ST_AnalogInputCfg` (`astLimit`, `astAlarm`), `ST_DigitalInputCfg`, `ST_MotorCfg`, `ST_ValveCfg`, `ST_ControlValveCfg`, `ST_PidCfg` (`astAlarm`), `ST_DeviceRetain` (`audiReserve`), `FB_StartsWindow` (`altStart`), `FB_DeviceBase` (`afbAlarm`, `axAlmCond`, `axAlmSuppress`, `arAlmValue`); в тестах — `FB_TestSink` (`astEvent`), `ST_TestDeviceCfg` (`astAlarm`), `FB_TestDevice` (`axCondIn`, `axSuppressIn`), `FB_Runtime_Test` (`altRtStamp`, `afbDev`, `astCmd`, `astRet`), `aitfDev` | STL007 «ожидается префикс 'a'» | Правило шаблона ждёт заглавную сразу после `a` (`aAlarm`); контракт и практика CODESYS — `a` + префикс элемента (`astAlarm` = массив структур). Имена заданы контрактом |
| `I_AlarmSink.OnAlarmEvent`, `FB_TestSink.OnAlarmEvent` (`stEvent`); `FB_DeviceBase.CheckAlarmCfg`, `RunAlarms` (`astCfg`); `FB_TestDevice` (`stCfg`, `CheckConfig.stCfgIn`, `ProbeAlarmCfg.astCfgIn`), `FB_Runtime_Test.CallDevice` (`stCfgDev`) | STL007 «константа … нужен UPPER_SNAKE_CASE» | Линтер принимает `VAR_IN_OUT CONSTANT` за секцию констант; это параметр «только для чтения» (контракт, разделы 0, 6, 9.3) |

Исключения в `tools/check/st_lint.toml` не используются: тест шаблона `test_toml_matches_defaults`
требует, чтобы файл совпадал с умолчаниями `st_lint.py`. Командам семейств: так же помечать
`stCfg`/`stCfgIn` (`VAR_IN_OUT CONSTANT`) и массивы `a<префикс>` из контракта.

## iec_checker 0.4: находки

| Правило | Где | Находка | Решение / обоснование |
|---|---|---|---|
| PLCOPEN-CP3 | `src/*`, `tests/*` | «Variable … shall be initialized before being used» | Обосновано (общая запись). Переменная без явного начального значения получает значение по умолчанию своего типа (МЭК 61131-3, как в CODESYS). Вариант сборки `iec-checker` удаляет неконстантные начальные значения (`:= E_DeviceMode.Manual`, `:= LTIME()`), отсюда часть находок; находки на копиях переменных в методах, вынесенных в функции, — артефакты сборки |
| UnusedVariable | `src/*`, `tests/*`: имена с префиксами `st`, `fb`, `itf` | «Found unused local variable» | Ложное срабатывание (общая запись): обращение к полям структуры, вызов экземпляра ФБ и его методов, аргумент `SIZEOF` iec_checker 0.4 использованием не считает. Префикс объединения `u` в общую запись не включён: в сообщении имя в верхнем регистре, `UBITS` не отличить от `UINEXT`; `UBITS` (`U_RealBits`) — отдельная запись |
| UnusedVariable | `FB_Delay`: `tOnDelay`, `tOffDelay` | то же | Ложное: входы используются только как аргументы `SEL(xIn, tOffDelay, tOnDelay)` |
| UnusedVariable | `F_LTimeToSec`: `ltIn` | то же | Ложное: вход — аргумент вложенного преобразования `ULINT_TO_LREAL(LTIME_TO_ULINT(ltIn))` |
| UnusedVariable | `FB_FakeTime`: `ltNow`; `FB_StartsWindow`: `altStart`, `uiNext`, `uiUsed`; `FB_TestSink`: `EVENTS_MAX`, `astEvent`, `uiNext`, `uiCount` | то же | Артефакт понижения: переменные используют только методы, которые сборка выносит в отдельные функции; тел у ФБ нет |
| UnusedVariable | `Util_StartsWindow_RingCapacity_MatchesConst`: `ltOne` | то же | Ложное: переменная — аргумент `SIZEOF` |
| PLCOPEN-CP9 | `FB_LimitMonitor` | «Code is too complex (19 McCabe complexity)» | Обосновано. Классическая цикломатическая сложность тела — 5 (4 точки ветвления: условие выключения из двух частей, выбор источника времени, верхняя или нижняя уставка); iec_checker 0.4 считает завышенно (в шаблоне: одна конструкция `IF … ELSE … END_IF` прибавляет 5). Делить короткую линейную логику на методы ради метрики — хуже для чтения |
| PLCOPEN-CP9 | `tests/*` | то же, 16…40 | Обосновано: методы-тесты — последовательности вызовов и проверок без ветвлений |
| PLCOPEN-CP9 | `FB_Alarm` | «Code is too complex (26…94 McCabe; 31…68 statements)» | Обосновано. Классическая сложность: тело 8, `UpdateShelve` 8, `UpdateState` 18 — таблица переходов ISA-18.2 (4 базовых и 3 наложенных состояния) одной цепочкой `IF/ELSIF`, строка в строку с таблицей 10.2 контракта; дробить её — хуже для проверки по контракту |
| PLCOPEN-CP9 | `FB_DeviceBase` | «Code is too complex (39…70 McCabe; 46…77 statements)» | Обосновано. Классическая сложность методов: `RunAlarms` 14, `ProcessMode` 11, `FinishCycle` 11; каждый метод — один шаг цикла по контракту (9.3, 10.5) |
| PLCOPEN-L17 | `src/*`, `tests/*` | «Each IF instruction should have an ELSE clause» | Обосновано (общие записи). Правило стиля PLCopen; пустую ветвь `ELSE` iec_checker 0.4 не разбирает (ParserError), заглушка `x := x;` хуже для чтения. Где `ELSE` нет, состояние в этом вызове сознательно не меняется. Код этапа 1 написан без таких `IF` (через `SEL`), с этапа 2 правило обосновано для всех |
| UnusedVariable | `FB_Alarm`: входы `xSuppress`, `xOutOfService`, `udiId`, `rValue`, выходы `ltLastChange`, `udiSeq`, переменные `tShelveReq`, `tShelveDur`, `eShelveEnd` | «Found unused local variable» | Артефакт понижения: их используют методы `Transit`, `UpdateShelve`, `UpdateState`, `Shelve`, вынесенные сборкой в функции |
| UnusedVariable | `FB_DeviceBase`: все переменные `VAR` (27); `OnModeChanged`: `eOld`, `eNew` | то же | Тело базы и хук пустые по контракту (9.1, 9.3): переменные используют защищённые методы и тела наследников |
| UnusedVariable | тесты: `FB_TestDevice` (константы, журнал хука), `FB_TestDeviceExt` (`uiExtHookCalls`), `FB_Runtime_Test` (состояние многоциклового теста), `SetSlotCfg.uiSlot`, объединение `uBad` | то же | Артефакт понижения (используют методы) или ложное срабатывание: индекс массива и поля объединения iec_checker использованием не считает |

## iec_checker 0.4: чего не разбирает разборщик и как это обойдено

Ошибку разбора (ParserError) обосновать нельзя — её исправляют в коде или в понижении
`iec-checker`. Понижение — часть шаблона (`tools/st_flavors.py`), его здесь не правят, поэтому для
основы выбраны формы, которые разбирают все инструменты. Каждая проверена на бинарнике v0.4
отдельным файлом.

| Конструкция CODESYS | Ошибка разбора | Обход в основе | Как вернуть исходную форму |
|---|---|---|---|
| оператор `LTIME()` в теле | да (`TIME()` тоже) | `FB_SystemTime.Now`: `LTIME()` в инициализаторе локальной переменной метода — понижение удаляет неконстантные инициализаторы; локальные переменные метода инициализируются при каждом вызове, тест `Time_SystemTime_IsMonotonic` проверяет рост (F-08) | понижение `LTIME()` → вызов функции-заглушки |
| константа в границе массива `ARRAY[0..GVL_Const.N - 1]` в секции `VAR` (в `STRUCT` понижение уже убирает массив) | да, и без `GVL_Const.` | `FB_StartsWindow.altStart : ARRAY[0..29]` + тест ёмкости `Util_StartsWindow_RingCapacity_MatchesConst` (F-07) | понижение: подставить значения констант GVL, как для меток `CASE` |
| поле элемента массива `a[i].x` | да, и у полей структуры (`stCfg.a[i].x`) | в тестах — копия элемента (`stSlot := stCfg.astAlarm[i];`) | понижение во временную переменную |
| длительность с пропуском единицы: `LTIME#1H500MS`, `T#1H2S` | да (`LTIME#1H0M0S500MS` и `T#49D17H2M47S295MS` — нет) | в тестах — разности (`fbTime.Now() - ltMark`) или литералы без пропусков | понижение: дописать нулевые единицы |
| `PROGRAM` без операторов | да (`FUNCTION_BLOCK` без операторов — нет) | в `PRG_Main` — чтение системного времени для ручной проверки R1 (F-02) | — |
| свойство, переменная или метод с именем — ключевым словом iec_checker: `Priority`, `Interval`, `Single`, `Retain`, `Constant`, `On`, `Program`, `Task`, `Resource`, `Configuration`, `With`, `Read_Write`, `Read_Only`, `Ref`, `Null`, `Method`, `Interface`, `Implements`, `Extends`, `Override`, `Final`, `Abstract`, `Public`, `Private`, `Protected`, `Internal` | да: понижение объявляет для аксессора свойства переменную с его именем (`Priority : E_AlarmPriority;`), и не разбирается весь файл | свойство `I_Alarm.Priority` названо `AlarmPriority` — отклонение от контракта (F-17); как член через точку (`itf.Priority`) имя разбирается | понижение: переименовывать такие идентификаторы (например, суффикс `_`) — тогда вернуть `Priority` |
| вызов элемента массива ФБ `afbAlarm[i](...)` | да | `FB_DeviceBase.CallAlarmSlot` со слотом в `VAR_IN_OUT` (F-19); в тестах — помощник `CallDevice` | понижение: вызов через временную ссылку |
| поле элемента массива ФБ `afbAlarm[i].xActive` в `src/` | да | сводка тревог — через `I_Alarm` слота (`itfAlarm := afbAlarm[i]; itfAlarm.Active`) | как для `a[i].x` выше |
| типизированный литерал `WORD#1`, `UINT#3` (`T#…`, `LTIME#…` разбираются) | да | `wBit := 1; wBit := SHL(wBit, 1)` (F-19) | понижение: убрать префикс типа у целых литералов |
| константа в границе массива в параметре метода (`VAR_IN_OUT CONSTANT astCfg : ARRAY[0..GVL_Const.DEV_ALARMS_MAX - 1]`) | да | граница числом `[0..7]` и тест `Device_AlarmSlotArrays_MatchDevAlarmsMax` (F-18) | как для `VAR` выше |

Командам семейств: в базе эти конструкции уже обойдены (F-18, F-19). В своём коде — не объявлять
массивы с константой в границе в секциях переменных, не вызывать `a[i](...)`, не читать `a[i].x`
(сначала копия или интерфейс), не писать `WORD#…`/`UINT#…`, не называть члены и переменные
ключевыми словами iec_checker (таблица выше). Перед сдачей — `run_iec_checker.py --tests`.

## RuSTy (`plc --check`)

RuSTy 1.0.6 проверяет синтаксис и типы варианта сборки `rusty` (`src/` и `tests/`); компоновки нет.
Пространство имён `coUnit.` убирается, объявления coUnit — из прокладок шаблона.

| Находка | Где | Решение / обоснование |
|---|---|---|
| error E033 «Unresolved constant `ltSys`: Cannot resolve constant: CallStatement» | `FB_SystemTime.Now` | Известная, не исправляется: RuSTy требует константный инициализатор, а `LTIME()` в инициализаторе — обход для iec_checker (обязательная проверка CI и pytest). Одна форма для обоих инструментов невозможна: iec_checker не разбирает `LTIME()` в теле, RuSTy — в инициализаторе. Задание RuSTy в CI необязательное; исключить файл нельзя — на `FB_SystemTime` ссылаются `FB_Delay`, `FB_LimitMonitor` и тесты |
| исключены (`tools/check/rusty_exclude.txt`): `FB_TestSink.st`, `FB_Common_Test.st`, `GVL_TestsFoundation.st` | — | RuSTy не поддерживает `VAR_IN_OUT CONSTANT` в методах: E034 в объявлении `OnAlarmEvent` и E036 «Cannot assign to CONSTANT» в вызове. Сигнатура задана контрактом. `GVL_TestsFoundation` объявляет экземпляр исключённого набора. Типы `FB_Common_Test` проверяет компилятор CODESYS |
| error E036 «Cannot assign to CONSTANT 'I_AlarmSink.OnAlarmEvent.stEvent'» | `FB_Alarm.Transit` | Известная, не исправляется: вызов приёмника с `VAR_IN_OUT CONSTANT` (контракт, раздел 6). Файл не исключён: остальной текст `FB_Alarm` RuSTy проверяет |
| error E034 «This variable block does not support the CONSTANT modifier» | `FB_DeviceBase.CheckAlarmCfg`, `RunAlarms` | Известные: параметры `VAR_IN_OUT CONSTANT astCfg` (контракт 9.3). Файл не исключён по той же причине и ещё потому, что тест шаблона `test_integration_sample_passes` читает `rusty_exclude.txt` репозитория и для своей фикстуры, где есть `FB_DeviceBase.st` (ниже) |
| исключены (этап 2): `FB_TestDevice.st`, `FB_TestDeviceExt.st`, `FB_TestDeviceNoSuper.st`, `FB_Alarm_Test.st`, `FB_DeviceBase_Test.st`, `FB_Runtime_Test.st`, `GVL_TestsAlarm.st` | — | `stCfg` устройства — `VAR_IN_OUT CONSTANT` (контракт, раздел 0): объявление даёт E034, каждый вызов — E036/E031; `FB_Alarm_Test` ссылается на исключённый `FB_TestSink` (E052). Логику проверяют тесты в CODESYS |
| warning E067 «Implicit downcast from 'DINT' to 'UINT'» | `FB_StartsWindow.Register`: `MIN(uiUsed + 1, STARTS_WINDOW_MAX)` | В RuSTy `UINT + 1` — `DINT`; в CODESYS предупреждения нет, значение не больше 30 |
| warning E067 «… 'ULINT' to 'UDINT'», E049 «Illegal access to private member» | тест `Util_StartsWindow_RingCapacity_MatchesConst` | `SIZEOF` в RuSTy — `ULINT`; тест намеренно читает внутреннюю переменную ФБ (проверка раскладки) |
| warning E091 «Value evaluated at run-time, use an enum variant» | `F_Ne107Worst` (`MAX(eA, eB)`) | Строгое перечисление из `MAX` — разрешённая в CODESYS конструкция (зонд P13 контракта) |

Командам семейств: вызов устройства с `stCfg` (`VAR_IN_OUT CONSTANT`) даёт E036 в каждом вызове,
объявление `stCfg`/`stCfgIn` — E034. До понижения `VAR_IN_OUT CONSTANT` → `VAR_IN_OUT` в варианте
сборки `rusty` (правка шаблона) такие файлы исключаются с причиной — но **не** файлы с именами,
которые есть в фикстуре шаблона `tools/tests/fixtures/sample` (`FB_DeviceBase.st`, `FB_Motor.st`,
`F_Clamp.st`, `PRG_Main.st`, …): тест шаблона `test_integration_sample_passes` запускает RuSTy на
фикстуре с файлом исключений репозитория, и исключённый `FB_Motor.st` уронит `pytest` (ошибка
шаблона: тесту нужен свой файл исключений). Для `FB_Motor` — оставить файл в проверке и записать
известные ошибки сюда, как для `FB_DeviceBase`.

## Ограничения разборщика, которые понижение уже обходит

Методы и свойства внутри `FUNCTION_BLOCK`, `IMPLEMENTS`/`EXTENDS`, прагмы, `VAR_GLOBAL` вне
конфигурации, массивы в `STRUCT`, базовый тип перечисления, неконстантные начальные значения,
строки с кириллицей и пробелами — подробно в [LAYOUT.md](LAYOUT.md#собранный-текст-buildassembled)
и `tools/README.md`.
