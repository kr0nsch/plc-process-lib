# Changelog

Все заметные изменения проекта записываются в этот файл.

Формат — [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/), версии — по
[Semantic Versioning](https://semver.org/lang/ru/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-10-16

Первый выпуск: библиотека `plc-process-lib, 1.0.0.0 (plc-portfolio)`, контракт API 1.0.0. Перед выпуском —
три независимых ревью (стандарты, ПО, потребители) и исправления по ним (19.10.2026, «Ревью перед выпуском»
ниже). Проверено на CODESYS 3.5.17.30 и CODESYS Control Win V3; на ПЛК210 не проверялось.

### Added

- Ревью перед выпуском:
  - функция `F_RateLimitLr` — ограничитель скорости с состоянием в LREAL (рампы регулирующего клапана и ПЧ);
  - `docs/alarm_templates.csv` — шаблоны текстов тревог всех типов (текст, действие оператора, причина,
    последствие), проверка состава `tools/project_checks/test_alarm_templates.py` (I-11);
  - проверки контракта: публичные секции и заголовки 14 ФБ `docs/API.md`, таблицы «Входы и выходы»
    `docs/fb` и таблица констант 5.1 сверяются с исходниками (I-12);
  - `docs/CONSUMERS.md` — изменения для генератора iolistgen (тип Pid, `persist_extra`, `wAlmSuppressed`,
    `Disabled`) и правила для КНС (I-13);
  - 33 новых теста (всего 453): аварийный ход задвижки при отказе контроля и страгивание с седла, защитные
    полосы NE 43, NE 107 в Local, событие выключения тревоги, раздельные маски shelve и подавления, подхват и
    предустановки ПЧ, устаревшая ОС ПЧ без питания и связи, медленные рампы при цикле 1 мс, конечные значения
    событий и Sts, контур AI → ПИД → ПЧ; тесты на выжившие мутации ревью (время назад в `tMinStop`,
    `tMinRun`, окне Reset; подмена без ограничения; `SpeedAutoActive`; `Available` ПИД при слежении; повтор
    OutOfService; контроль концевика без питания; первопричина клапана);
  - константы `GVL_Const`: `VLV_UNSEAT_BYPASS`, `CV_TIGHT_HYST_PCT`, `VFD_POWER_UP_DELAY` (параметры вне
    замороженной Cfg).

- Устройства (этап 3), каждое со своим набором тестов, документом `docs/fb/<ФБ>.md`, эталонами
  `tools/reference/` и мутационной проверкой тестов:
  - `FB_AnalogInput` — мА, 0–1, инж. ед. и отсчёты; корень с отсечкой, фильтр первого порядка (точная
    экспонента, не зависит от цикла), достоверность по NAMUR NE 43 с подтверждением, уставки HH/H/L/LL
    через `FB_LimitMonitor`, подмена с ограничением по времени; 51 тест, эталоны `ai_reference.py`;
  - `FB_DigitalInput` — задержки включения и отключения, инверсия, отказ канала (HoldLast, ForceFalse,
    ForceTrue), подмена; 18 тестов;
  - `FB_Motor` — режимы, пуск/стоп от HMI и автоматики, блокировки и разрешения с первопричиной, контроль
    ОС (FailToStart, FeedbackLost, FailToStop, UncommandedRun), внешняя авария, окно сброса, `tMinRun`,
    `tMinStop`, пуски в час, моточасы и пуски в `stRetain`, подхват после старта ПЛК, `I_Motor`;
    52 теста, эталоны `motor.py`;
  - `FB_MotorVfd EXTENDS FB_Motor` — задание 0–100 % с рампой, ОС по частоте, отказ связи с ПЧ,
    рассогласование скорости, `I_MotorVfd`; 27 тестов;
  - `FB_Valve` — привод и соленоиды (Eto/Etc): открыть, закрыть, стоп, концевики, время хода, «оба
    концевика», уход с концевика, муфта и закрытие по моменту, пауза реверса, положение «по времени»;
    41 тест, эталоны `valve_reference.py`;
  - `FB_ControlValve` — задание положения с пределами и скоростью, плотное закрытие, токовый выход с
    инверсией, рассогласование с ОС, отказ позиционера, положение безопасности; 24 теста;
  - `FB_PID` — идеальная форма, D по измерению с фильтром, обратный расчёт по своему или фактическому
    выходу, безударные переходы Manual/слежение → Auto, рампа задания, внешнее задание и слежение за PV,
    расчёт по реальному dt и `tSample`, отказ PV (Hold, SafeOut, ShedToManual); 53 теста, модель объекта
    `FB_FopdtModel` и эталоны `pid.py`.
- Интеграция (этап 4):
  - набор `FB_Integration_Test` (`GVL_TestsIntegration`) — тесты всех семи типов устройств вместе:
    `Device_DefaultCfg_PassesCheck`, `Device_DevType_ReportedInStsCommon`,
    `Device_AllTypes_AlarmCountThroughIDevice`; всего 420 тестов в 14 наборах, все зелёные в CODESYS
    Control Win V3;
  - `docs/STYLE_GUIDE.md` — стиль ST с примерами «так — не так»;
  - `docs/ASSUMPTIONS.md` — решения семейств (AI-, DI-, M-, VFD-, VLV-, CV-, P-), открытые вопросы с
    решениями интеграции, решения интеграции I-01…I-09;
  - `docs/MANUAL_STEPS.md` — библиотека (`.library`, `.compiled-library`, установка), прогон тестов в IDE,
    публикация релиза v1.0.0, правила наладки по открытым вопросам;
  - `docs/TESTING.md` — правило NaN для `AssertEquals_REAL`, межсемейные тесты.

- Основа библиотеки (этап 1, контракт API 1.0.0-rc2):
  - 50 DUT в `src/DUTs/<Семейство>/`: общие перечисления (`E_DeviceMode`, `E_DeviceType`,
    `E_Ne107Status`, `E_CmdResult`), общий заголовок `ST_DeviceCmd`/`ST_DeviceSts`, `ST_DeviceRetain`,
    `U_RealBits`, типы тревог и Cmd/Sts/Cfg, перечисления и индексы слотов всех семи устройств;
  - `GVL_Const` — константы таблицы 5.1, число слотов тревог по типам и 142 маски битов слов
    `wStatus`, `wFault`, `wWarning`, `wCfgErr` всех устройств; `GVL_Lib.itfAlarmSink`;
  - интерфейсы `I_TimeSource`, `I_Alarm`, `I_AlarmSource`, `I_AlarmSink`, `I_Device`, `I_Motor`,
    `I_MotorVfd` (без `__System.IQueryInterface`, свойства только Get);
  - время: `FB_SystemTime` (оператор `LTIME()`), `FB_FakeTime`, `FB_Delay` (переживает «время назад»);
  - утилиты: `F_LTimeToSec`, `F_TimeToSec`, `F_IsFinite`, `F_Ne107Worst`, `F_RateLimit`,
    `FB_StartsWindow`, `FB_LimitMonitor`.
- Тесты coUnit 1.2.0.0: наборы `FB_Time_Test` (24), `FB_Util_Test` (26), `FB_Common_Test` (11) —
  61 тест, все зелёные в CODESYS Control Win V3; помощник `FB_TestSink` (`I_AlarmSink`, кольцо на 32
  события). Наборы регистрируются экземплярами в `tests/GVLs/GVL_Tests<Семейство>.gvl.st` с атрибутом
  `linkalways`, `PRG_Tests` только вызывает `coUnit.RUN()`.
- `tools/reference/common.py` — эталоны тестов: размеры структур по правилам раскладки, сценарии
  `F_RateLimit`, перевода времени, окна пусков.
- `tools/project_checks/` — pytest: регистрация наборов и вызов каждого теста, имена тестов, константы,
  маски, перечисления и состав DUT против контракта, ссылки заголовков на документы.
- Документы: `docs/TESTING.md` (соглашения тестов для команд семейств), `docs/fb/` по ФБ основы,
  `docs/ARCHITECTURE.md` (состав, типы, карты битов), решения A-01…A-15 и F-01…F-16 в
  `docs/ASSUMPTIONS.md`, разбор статанализа, ручная проверка `LTIME()` в `docs/MANUAL_STEPS.md`.

- Основа библиотеки, этап 2:
  - `FB_Alarm` (`src/POUs/Alarm/`) — тревога ISA-18.2: Normal, ActiveUnack, ActiveAck, RtnUnack и
    наложенные OutOfService > SuppressedByDesign > Shelved; приоритет (None выключает), задержки
    появления и снятия через `FB_Delay`, shelve с таймаутом и повторным оповещением, подавление по
    условию, события в `PL.GVL_Lib.itfAlarmSink`, счётчик переходов `udiSeq`;
  - `FB_DeviceBase` (`src/POUs/Base/`) — абстрактная база устройств (`I_Device`): время цикла,
    автомат режимов с санитизацией retain, конфигурация с LKG, результат команд, восемь слотов
    `FB_Alarm` с масками квитирования и shelve, сводный NE 107, общий заголовок `stSts.stCommon`,
    виртуальный хук `OnModeChanged`.
- Тесты этапа 2: `FB_Alarm_Test` (34), `FB_DeviceBase_Test` (42) на тестовом устройстве
  `FB_TestDevice` и его наследниках, `FB_Runtime_Test` (8) — ответы на вопросы времени выполнения
  раздела 24.2 контракта (виртуальный вызов хука, `SUPER^` с `VAR_IN_OUT`, монотонность и разрешение
  `LTIME()`, частичный инициализатор массива, стек, цена копирования LKG). Всего 145 тестов, все
  зелёные в CODESYS Control Win V3.
- Документы: `docs/fb/FB_Alarm.md`, `docs/fb/FB_DeviceBase.md`, шаблон документа устройства
  `docs/fb/_TEMPLATE.md`; решения F-17…F-27 и раздел «Проверено во время выполнения» в
  `docs/ASSUMPTIONS.md`; ответы прогона в `docs/TEST_REPORT.md`; тестовое устройство и зонды в
  `docs/TESTING.md`.

- Ревью основы перед устройствами:
  - `docs/API.md` — публикуемая копия контракта API 1.0.0-rc2: ссылки на правила — `CONTRIBUTING.md`,
    список отступлений реализации (F-17 и др.), раздел «Проверено компиляцией и на рантайме» (зонды,
    ответы тестов на Control Win V3, справка CODESYS); `docs/DECISIONS.md` — рассмотренные варианты API
    и почему выбран этот;
  - `tools/project_checks/test_contract_doc.py` — pytest сверяет `docs/API.md` с исходниками: тексты
    50 DUT без комментариев, таблицу констант 5.1, 142 маски по картам битов, интерфейсы раздела 6;
  - тесты `Alarm_ShelveRequestThenOos_Rejected`, `Alarm_PriorityNone_CancelsShelve`,
    `Alarm_PriorityReenabled_OnDelayCountsFromEnabling`, `Alarm_AckWithoutEffect_NotKeptForLater`,
    `Device_MethodRequests_ProcessedOnce`, `Device_ShelveMaskOnOosEntry_RejectedState` — их не хватало
    по итогам мутационной проверки (F-29); всего 151 тест;
  - `docs/TESTING.md` — чек-лист устройства для команд семейств.

### Changed

- Ревью перед выпуском (контракт 1.0.0, «Изменения по ревью перед выпуском»):
  - `FB_AnalogInput`: ток в защитных полосах NE 43 (3,6…3,8 и 20,5…21 мА) — значение насыщения без
    экстраполяции, подтверждённый выход за диапазон — `xValid = FALSE`; уставки считаются (AI-13);
  - `FB_DeviceBase`: режим Local даёт NE 107 CheckFunction (F-30); `ST_DeviceSts.wReserve` →
    `wAlmSuppressed` (подавленные логикой), `wAlmShelved` — только отложенные оператором, раскладка та же
    (F-32);
  - `FB_Alarm`: приоритет None у тревоги не в Normal — событие `Disabled` (новое значение
    `E_AlarmEventReason`, F-31); значение процесса в событии всегда конечно (F-33);
  - `FB_Valve`: блокировка при одних отказах контроля ведёт задвижку в положение безопасности (VLV-20);
    муфта открытия при страгивании с седла не даёт TorqueTrip (VLV-21);
  - `FB_ControlValve`: плотное закрытие с гистерезисом (CV-13), рампа в LREAL (CV-14);
  - `FB_MotorVfd`/`FB_Motor`: задание при подхвате — от фактической скорости (VFD-09), предустановка пуска
    ждёт связи (VFD-10), без питания или после отказа связи двигатель с ОС по связи не считается работающим
    (VFD-11), без питания и `VFD_POWER_UP_DELAY` после его возврата связь не контролируется (VFD-12), рампа
    в LREAL (VFD-13);
  - `FB_PID`, `FB_ControlValve`, `FB_MotorVfd`: неконечные PV, ОС положения и скорость в Sts — 0.0 (F-33);
  - контракт 17.3/18.3: Cfg и Retain ПИД — тип устройства Pid генератора iolistgen, данные приложения —
    `persist_extra` (I-13).
- Версия библиотеки в `tools/codesys/config.json` — 1.0.0.0, `released = true` (I-09).
- Контракт `docs/API.md` — редакция **1.0.0**: отклонения от rc2 (раздел 0) — имя `AlarmPriority`
  (F-17), регистрация наборов (F-01), порядок результатов команд (F-28) и уточнения поведения семейств
  (AI-2, AI-12, DI-1, DI-2, M-09, M-10, M-18, M-20…M-23, VFD-01, VFD-02, VLV-05, VLV-09, VLV-15, VLV-19,
  CV-1, CV-11, P-02, P-15, P-16); нормативные разделы приведены к реализации; методы-шаги семейств
  описаны в 22.4 как деталь реализации.
- **Ломающее относительно контракта rc2:** свойство `I_Alarm.Priority` названо `AlarmPriority`
  (F-17). Решение закреплено: `PRIORITY` — ключевое слово МЭК 61131-3 (объявление задачи `TASK`).
- Инструменты синхронизированы с `plc-repo-template`: понижение iec-checker разбирает `TIME()`/`LTIME()`,
  константы в границах массивов, `a[i].x`, вызов элемента массива ФБ, ключевые слова; RuSTy понижает
  `VAR_IN_OUT CONSTANT`; `st_lint` понимает составные префиксы массивов и `VAR_IN_OUT CONSTANT`.
  Обходы сняты: границы массивов — константы (F-07, F-18), `FB_SystemTime.Now` — `LTIME()` в теле
  (F-08), `RunAlarms` вызывает слоты напрямую (F-19); RuSTy проверяет все 116 файлов без ошибок (F-24).
- Решения семейств перенесены из `docs/fb/*.md` в `docs/ASSUMPTIONS.md`; номера `FB_MotorVfd` и
  `FB_Valve` получили префиксы `VFD-` и `VLV-` (I-06). `README.md` — описание всей библиотеки.
- `tools/check/iec_checker_allow.toml` — обоснования этапа 2 (PLCOPEN-L17, CP9, ложные
  «неиспользуемые» переменные); `tools/check/rusty_exclude.txt` — исключения тестов этапа 2;
  `tools/project_checks/test_conventions.py` — допускает пять имён тестов контракта из двух сегментов.
- `PRG_Main` — служебная программа рабочей сборки (CODESYS 3.5.17 не собирает пустую конфигурацию
  задач), не часть API библиотеки.
- `tools/check/iec_checker_allow.toml`, `tools/check/rusty_exclude.txt` — обоснования и исключения
  библиотеки; `pyproject.toml` — каталоги `tools/reference`, `tools/project_checks`.
- Документы: ссылки на контракт и решения ведут в `docs/API.md` и `docs/DECISIONS.md`;
  `docs/fb/FB_DeviceBase.md` — подводные камни порядка тела (результат сброса и у устройств без
  фиксируемых отказов, состояние после `SUPER^(...)`, порядок результатов команд — F-28);
  `docs/fb/FB_Alarm.md` — квитирование без эффекта не запоминается.

### Fixed

- Ревью перед выпуском: подхваченный после перезапуска ПЛК ПЧ получал задание 0 % и рампу с нуля (VFD-09);
  пуск в короткий провал связи оставлял ПЧ ниже минимальной частоты (VFD-10); час без питания станции или с
  оборванным кабелем добавлялся к моточасам и обнулял учёт работы неверно (VFD-11); отключение питания станции
  давало отказ связи и тревогу у каждого ПЧ (VFD-12); медленная рампа клапана и ПЧ при цикле 1 мс стояла
  (CV-14, VFD-13); при неисправном концевике блокировка показывала INTERLOCKED, а задвижка стояла (VLV-20);
  каждое открытие клиновой задвижки, посаженной по моменту, давало TorqueTrip (VLV-21); плотное закрытие
  «стучало» клапаном у порога (CV-13); ток отказа NAMUR, прочитанный как 3,61 мА, был годным значением и
  уводил ПИД к пределу (AI-13); выключенная активная тревога оставалась «призраком» в журнале по событиям
  (F-31); NaN попадал в события тревог и Sts (F-33).
- Тесты с неконечными входами (`FB_Util_Test`, `FB_AnalogInput_Test`, `FB_MotorVfd_Test`,
  `FB_ControlValve_Test`, а также проверки Cfg с NaN у AI, регулирующего клапана и ПИД) проверяют
  конечность выходов `F_IsFinite`: `AssertEquals_REAL` coUnit проходит при `Actual = NaN` и ошибку не
  ловил.
- `FB_DeviceBase.RunAlarms`: маска shelve в вызове, в котором устройство уходит в OutOfService, давала
  результат `Accepted`, хотя слот запрос отклонял (в OutOfService shelve не принимается). Теперь в
  OutOfService shelve у слотов не запрашивается, результат маски — `RejectedState`.

### Removed

- Защищённый метод `FB_DeviceBase.CallAlarmSlot` (обход разборщика, не API), 48 подавлений
  `lint:allow STL007`, все исключения `tools/check/rusty_exclude.txt`.
- Пример шаблона: `FB_Example`, `F_Clamp`, `I_Resettable`, `ST_ExampleCmd`, `ST_ExampleSts`, старые
  `E_DeviceMode` и `GVL_Const`, наборы `FB_F_Clamp_Test`, `FB_Example_Test`.

## Шаблон plc-repo-template (основа репозитория)

### Added

- Раскладка исходников ST в `src/` и `tests/` и её формальный контракт `docs/LAYOUT.md`.
- Инструменты: `tools/assemble.py`, `tools/check/` (линтер `st_lint.py`, запуск iec_checker и RuSTy),
  скрипты CODESYS Scripting в `tools/codesys/`.
- `tools/codesys/cds.py` — импорт, сборка, тесты coUnit в CODESYS Control Win V3 (пользовательский
  процесс), экспорт, roundtrip, JUnit и отчёт из консоли; настройки — `tools/codesys/config.json`.
  Проверено в CODESYS 3.5.17.30.
- CI GitHub Actions: ruff, mypy, pytest, сборка ST, линтер (`--strict`), iec_checker v0.4 (закреплён
  по размеру и SHA-256); необязательно — iec_checker `nightly` (образ закреплён по дайджесту) и RuSTy.
- Документы: архитектура, ручные шаги, допущения, отчёты статанализа и тестов, шаблоны ТЗ
  (ГОСТ 34.602-2020) и ПМИ.
- `LICENSE` (MIT), `.gitignore`, `.gitattributes`, `.editorconfig`.

### Fixed

- Тесты coUnit: функции `TEST` и `TEST_FINISHED` вызываются с пространством имён (`coUnit.TEST(...)`) —
  без него сборка в CODESYS 3.5.17.30 давала ошибки C0046/C0035.
- `cds.py build`/`test`: перед открытием проекта удаляется кэш предкомпиляции CODESYS — с ним
  сломанное объявление ФБ с методами собиралось с «0 ошибок», а исправленное давало старую ошибку.
- `cds.py`: устаревший файл блокировки `<проект>.~u` (CODESYS остановлен по таймауту или упал)
  удаляется, проект, открытый в IDE, — понятный отказ с кодом 3 вместо трассировки.
- `cds.py import`: переименование только регистром (файл, метод, свойство, папка) доходит до проекта.
- `cds.py test`: старые `build/junit.xml` и `build/test-results.json` удаляются перед прогоном;
  неудачный вход в рантайм — одна строка с причиной и код 3 вместо трассировки; имя пользователя
  рантайма не пишется в журнал.
- `docs/MANUAL_STEPS.md`, `README.md`: команды без `& rem` — работают в cmd, PowerShell и Git Bash.
