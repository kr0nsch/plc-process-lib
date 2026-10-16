# Changelog

Все заметные изменения проекта записываются в этот файл.

Формат — [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/), версии — по
[Semantic Versioning](https://semver.org/lang/ru/spec/v2.0.0.html).

## [Unreleased]

### Added

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

- **Ломающее относительно контракта rc2:** свойство `I_Alarm.Priority` названо `AlarmPriority` —
  `PRIORITY` является ключевым словом разборщика iec_checker 0.4 (F-17, ждёт решения).
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

- `FB_DeviceBase.RunAlarms`: маска shelve в вызове, в котором устройство уходит в OutOfService, давала
  результат `Accepted`, хотя слот запрос отклонял (в OutOfService shelve не принимается). Теперь в
  OutOfService shelve у слотов не запрашивается, результат маски — `RejectedState`.

### Removed

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
