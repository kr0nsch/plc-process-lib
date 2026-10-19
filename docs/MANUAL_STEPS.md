# Ручные шаги

Шаги, которые выполняет человек в консоли Windows и в IDE CODESYS. Всё, что можно выполнить без
CODESYS (тесты Python, линтер, статанализ), описано в [README](../README.md#проверки-без-codesys)
и выполняется в CI. Как подключить библиотеку к своему проекту — [USAGE.md](USAGE.md).

Команды разделов 3–7 проверены прогоном на CODESYS V3.5 SP17 Patch 3 (3.5.17.30, 32-битная сборка
ОВЕН) и CODESYS Control Win V3 в пользовательском процессе (16.10.2026). Что не проверено — отмечено
явно. Подробности об инструменте — [tools/README.md](../tools/README.md#codesyscdspy--codesys-из-консоли).

## 1. Установка CODESYS 3.5.17.30

1. Скачать CODESYS V3.5 SP17 Patch 3 (3.5.17.30) с сайта ОВЕН (раздел ПО для ПЛК2xx) и установить
   с компонентами CODESYS Control Win V3 и Gateway. Сборка ОВЕН 32-битная и ставится в
   `C:\Program Files (x86)\CODESYS 3.5.17.30\` — этот путь `cds.py` находит сам.
2. Для рабочего ПЛК — пакет таргет-файлов ОВЕН ПЛК210: «Инструменты → Установщик пакетов»
   (Tools → Package Manager). Версию таргет-файла сверить с прошивкой ПЛК. Для тестов он не нужен:
   тестовый проект собирается под CODESYS Control Win V3.
3. Имя профиля — по файлу в каталоге профилей (для 3.5.17.30 — `CODESYS V3.5 SP17 Patch 3`):

   ```bat
   dir "C:\Program Files (x86)\CODESYS 3.5.17.30\CODESYS\Profiles"
   ```

   `CODESYS.exe --help` и запуск без `--profile` открывают окно IDE (диалог выбора профиля), а не
   выводят справку в консоль — для проверки их не используйте.
4. Нужен Python 3.11+ (`python --version`), сторонние пакеты для `cds.py` не нужны.

## 2. coUnit (CfUnit) 1.2.0.0

В версии 1.2.0.0 CfUnit называется co♻e / coUnit, пространство имён в коде — `coUnit`
(см. [ASSUMPTIONS.md](ASSUMPTIONS.md), C6). Лицензия MIT.

1. Скачать `counit.library` из SVN проекта counit на CODESYS Forge (`tags/v1.2.0.0/`) обычным
   `GET` (браузером: запрос `HEAD` даёт 401).
2. Установить одним из способов:
   - в IDE: «Инструменты → Репозиторий библиотек → Установить» (Tools → Library Repository → Install);
   - или автоматически: задать путь к файлу в `COUNIT_LIBRARY` (раздел 3) — первый
     `cds.py import --tests`, не найдя coUnit 1.2.0.0 в репозиториях, установит её в репозиторий
     `System` (`librarymanager.install_library`). _Ветка установки на этой машине не выполнялась:
     библиотека уже была установлена; поиск по пространству имён и версии — проверен._
3. Параметры библиотеки менять не нужно: с параметрами по умолчанию тестовое приложение под
   Control Win собирается без ошибок (проверено, C7). Для ПЛК210 с меньшей памятью — сверить при
   переносе тестов на контроллер.

## 3. Переменные окружения

Абсолютных путей пользователя в репозитории нет: `cds.py` берёт их из переменных окружения, а без
них — из значений по умолчанию в `tools/codesys/config.json`. Обычно достаточно двух:

| Переменная | Значение | По умолчанию |
|---|---|---|
| `CODESYS_EXE` | полный путь к `CODESYS.exe` | `%ProgramFiles(x86)%\CODESYS 3.5.17.30\CODESYS\Common\CODESYS.exe`, затем `%ProgramFiles%\...` |
| `CODESYS_PROFILE` | имя профиля | `CODESYS V3.5 SP17 Patch 3` |
| `COUNIT_LIBRARY` | путь к `counit.library` (только если coUnit ещё не установлена) | — |
| `CODESYS_RUNTIME_CREDENTIALS` | файл с логином и паролем тестового пользователя рантайма | `%USERPROFILE%\.local\plc-tools\cds-runtime\credentials.json` |

Остальные (устройство, пути рантайма, таймауты, блокировка) — в
[tools/README.md](../tools/README.md#переменные-окружения). Задать для пользователя:

```bat
setx CODESYS_EXE "C:\Program Files (x86)\CODESYS 3.5.17.30\CODESYS\Common\CODESYS.exe"
setx CODESYS_PROFILE "CODESYS V3.5 SP17 Patch 3"
```

`setx` не меняет окружение уже открытых консолей; `cds.py` дочитывает переменные пользователя из
реестра (`HKCU\Environment`), поэтому перезапуск консоли не обязателен.

## 4. Рантайм CODESYS Control Win V3 без прав администратора

Служба Windows «CODESYS Control Win V3» требует прав администратора — её не используем. Тесты идут
в пользовательском процессе `CODESYSControlService.exe`, которым управляет `cds.py`. Команды
одинаково работают в cmd, PowerShell и Git Bash (из корня репозитория):

| Команда | Что делает |
|---|---|
| `python tools/codesys/cds.py runtime init` | один раз: каталог, `boot.cfg`, копия `CODESYSControl.cfg`, `credentials.json` |
| `python tools/codesys/cds.py runtime start` | скрытый запуск, ждёт порт 11740 |
| `python tools/codesys/cds.py runtime status` | PID, сколько работает, остаток демо-режима; код 1 — рантайм не запущен |
| `python tools/codesys/cds.py runtime restart` | остановить свой процесс и запустить заново |
| `python tools/codesys/cds.py runtime stop` | остановить свой процесс (службу Windows не трогает) |

- `runtime init` создаёт `%USERPROFILE%\.local\plc-tools\cds-runtime\`: `boot.cfg`, `work\` с
  копией штатного `CODESYSControl.cfg` (из `C:\ProgramData\CODESYS\CODESYSControlWinV3\<id>\`, файл
  только читается) и `credentials.json` с пользователем `cdsci` и случайным паролем. Пароль не
  печатается; файл лежит вне репозитория — не копируйте и не коммитьте его.
- Без лицензии рантайм работает 2 часа с момента запуска. `cds.py test` сам перезапускает его, если
  он работает дольше 100 минут (`CODESYS_RUNTIME_MAX_AGE_MIN`). Запуск и остановка — только своего
  процесса (с `-d <boot.cfg>`); если порт 11740 занят службой или чужим экземпляром, `cds.py`
  использует его, но не перезапускает.
- Состояние рантайма (пользователи, загруженные приложения, сертификаты, PlcLogic) из-за
  виртуализации UAC лежит не в `work\`, а в
  `%LOCALAPPDATA%\VirtualStore\Program Files (x86)\CODESYS 3.5.17.30\GatewayPLC\`; туда же
  попадает XML-отчёт coUnit (`%LOCALAPPDATA%\VirtualStore\coUnit_xunit_testresults.xml`).
  Чтобы «обнулить» рантайм (забыть пользователей и приложения), остановите его и удалите этот
  каталог вручную — это необратимо.

**Первый вход и создание пользователя.** Управление пользователями рантайма остаётся включённым
(отключать его не нужно). На свежем рантайме без пользователей `cds.py test` сам создаёт первого
пользователя из `credentials.json` (`set_credentials_for_initial_user` и подключение), если обычный
вход не удался. _Эта ветка реализована по API, но на этой машине не выполнялась: пользователь
`cdsci` уже был создан._ Если автоматически не получится — вручную в IDE: открыть тестовый проект
(раздел 6), «Устройство → Настройки соединения» (Communication Settings), выбрать шлюз `Gateway-1`
(localhost:1217) и устройство, войти — IDE предложит создать пользователя; ввести логин и пароль
из `credentials.json`.

## 5. Импорт, сборка, тесты

Все команды — из корня репозитория (cmd, PowerShell или Git Bash). Каждая запускает CODESYS без
окна (`--noUI`), длится 10–20 секунд и пишет журналы в `build/`.

| Команда | Что делает |
|---|---|
| `python tools/codesys/cds.py import` | `src/` → `build/<имя>.project` (MainTask 20 мс → `PRG_Main`) |
| `python tools/codesys/cds.py import --tests` | `src/` и `tests/` → `build/<имя>-tests.project` (TestTask 10 мс → `PRG_Tests`, coUnit) |
| `python tools/codesys/cds.py build` | импорт и полная сборка: `build/build.log`, `build/build.json` |
| `python tools/codesys/cds.py build --tests` | то же для тестового проекта |
| `python tools/codesys/cds.py test` | импорт с тестами, сборка, прогон в рантайме |
| `python tools/codesys/cds.py roundtrip` | импорт в чистый проект → экспорт → сравнение с `src/` и `tests/` |
| `python tools/codesys/cds.py report` | итоги последнего `test` → `docs/TEST_REPORT.md` |

Что смотреть:

- `import` печатает, что создано, обновлено, удалено и перемещено. Повторный импорт без правок —
  «создано 0, обновлено 0, удалено 0». Ошибки раскладки (коды LAY) — отказ без изменений проекта.
- `build`: ошибки и предупреждения компилятора с файлом и строкой раскладки, например
  `src/POUs/Util/F_RateLimit/F_RateLimit.impl.st:6: Error C0046 Идентификатор 'rLimitX' не задан`. Сообщения
  IDE — на русском. Если в IDE видны ошибки, которых нет в выводе, — скопируйте их в
  [BUILD_ERRORS.md](BUILD_ERRORS.md). Перед открытием проекта `cds.py` удаляет кэш предкомпиляции
  `build/<имя>_project.precompilecache`: с ним CODESYS 3.5.17.30 после замены объявления ФБ с
  методами собирал старый текст (сломанное объявление — «0 ошибок», исправленное — старая ошибка).
- `test` перед прогоном удаляет `build/test-results.json` и `build/junit.xml` прошлого запуска:
  при ошибке сборки или входа в рантайм старые зелёные результаты не остаются.
- `test`: итог по наборам и тестам; упавшие — с сообщением coUnit. Результаты — в
  `build/test-results.json` и `build/junit.xml`, журнал — `build/test.log`.
- `roundtrip`: «экспорт совпадает с src/ и tests/ побайтно» и «повторный импорт … — 0 изменений».
  Любой дифф — ошибка скриптов (issue).

Коды выхода: 0 — успех; 1 — ошибки раскладки или сборки, упавшие тесты, дифф roundtrip;
2 — аргументы или `config.json`; 3 — окружение (нет CODESYS, рантайма, файла); 4 — таймаут;
5 — блокировка занята. Рантайм один на машину: команды, которые с ним работают, ждут друг друга
(блокировка `%LOCALAPPDATA%\plc-tools\codesys-runtime.lock`).

## 6. Работа в IDE и экспорт перед коммитом

1. Собрать проект: `python tools\codesys\cds.py import` (или `import --tests` для проекта с тестами).
2. Открыть его в IDE: «Файл → Открыть проект» → `build\<имя>.project` (`build\<имя>-tests.project`),
   либо из консоли cmd (из PowerShell — эту же строку через `cmd /c '<строка>'`: PowerShell и Git
   Bash переставляют кавычки в `--profile="..."`, и CODESYS не находит профиль; `cmd /c` проверен
   с `--noUI --runscript`). `%CODESYS_EXE%` виден в консолях, открытых после `setx`:

   ```bat
   "%CODESYS_EXE%" --profile="CODESYS V3.5 SP17 Patch 3" --project="%CD%\build\plc-process-lib.project"
   ```

   Вход в рантайм из IDE: «Онлайн → Логин» с пользователем из `credentials.json`. _Открытие из
   консоли с `--project` здесь не проверялось (ключ описан в справке CODESYS по командной строке)._
3. Править, сохранить проект, **закрыть IDE**. Пока проект открыт в IDE, `import`, `build`, `test`
   и `export` сразу отказываются: «проект … открыт в другом экземпляре CODESYS (пользователь, компьютер,
   PID)», код выхода 3 (проверено). Файл блокировки `<проект>.~u`, оставшийся после сбоя CODESYS
   или его остановки по таймауту, `cds.py` удаляет сам, если процесса с этим PID больше нет.
4. Выгрузить правки в тексты и проверить дифф:

   ```bat
   python tools/codesys/cds.py export
   python tools/codesys/cds.py export --tests
   git diff --stat
   ```

   `export` выгружает `build/<имя>.project` в `src/`; `export --tests` — `build/<имя>-tests.project`
   в `src/` и `tests/`.

Защита от потери правок:

- `import` отказывается перезаписывать проект, сохранённый в IDE после последнего
  `import`/`export`, — сначала `export` (или `--force`, если правки не нужны);
- `export` в репозиторий отказывается, если `src/` (`tests/`) изменились после последнего
  `import`/`export` этого проекта: экспорт удаляет файлы, которых нет в проекте. Сравнить можно
  выгрузкой в отдельный каталог: `cds.py export --to build\cmp`; перезапись — `--force`.

Не входит в раскладку (только в IDE, при экспорте не сохраняется — описывайте здесь и в docs):

- [ ] дерево устройств ПЛК210 и конфигурация модулей ввода-вывода; конфигураторы обмена (Modbus, OPC UA);
- [ ] визуализации, графические языки (FBD/LD/SFC/CFC), действия (`ACTION`) — `export` предупреждает о них;
- [ ] **Persistent Variables** (`*.pvl.st`): в SP17 скриптом не создаются. Создайте объект вручную
  («Application → Добавить объект → Persistent Variables» с именем как у файла), затем
  `cds.py import` обновит его текст из файла, а `export` выгрузит обратно.

Задачи и ссылки на библиотеки не правьте в IDE: их создаёт `import` по `tools/codesys/config.json`
(лишние задачи удаляются).

## 7. Библиотека: `.library`, `.compiled-library`, установка в репозиторий библиотек

`.library`, `.compiled-library` и `.project` в git не хранятся — собираются из `src/` и прикладываются к
релизу GitHub (раздел 12). Project Information библиотеки — раздел `library` в
`tools/codesys/config.json`: название `plc-process-lib`, компания `plc-portfolio`, версия
(`library.version`, на одну сборку — `CDS_LIBRARY_VERSION`), пространство имён по умолчанию `PL`, автор,
описание. В библиотеку входят все объекты `src/`, кроме служебной программы `PRG_Main` (F-02);
`tests/` не входят.

| Команда | Что делает |
|---|---|
| `python tools\codesys\cds.py library` | `build\plc-process-lib.library` и «Проверить все объекты пула»: ошибки — с файлом и строкой раскладки, код 1 (библиотека сохраняется для разбора в IDE, но не ставится) |
| `python tools\codesys\cds.py library --compiled` | ещё `build\plc-process-lib.compiled-library` — скомпилированная, без исходного текста |
| `python tools\codesys\cds.py library --compiled --install` | установка в репозиторий библиотек `System` (`C:\ProgramData\CODESYS\Managed Libraries`, права администратора не нужны): `plc-process-lib, <версия> (plc-portfolio)`; с `--compiled` ставится скомпилированная, та же версия заменяется |
| `python tools\codesys\cds.py library --uninstall` | удалить из репозитория версию `library.version` (`--all-versions` — все) |

Проверка пула выполнена при интеграции (19.10.2026: 78 объектов, 0 ошибок; раздел «Последний прогон» в
[STATIC_ANALYSIS.md](STATIC_ANALYSIS.md)). _Установка `--install` из рабочей копии интеграции не
выполнялась: репозиторий библиотек общий для машины, и версию, поставленную из другой рабочей копии,
установка заменила бы (`cds.py` об этом предупреждает). Ставьте библиотеку из основной рабочей копии или
с другой версией (`CDS_LIBRARY_VERSION=0.1.1.0`)._

Вручную в IDE (без `cds.py`):

1. Установить готовый файл: «Инструменты → Репозиторий библиотек → Установить…» (Tools → Library
   Repository → Install) → `plc-process-lib.library` или `.compiled-library`.
2. Проверить: в проекте приложения «Library Manager → Добавить библиотеку» → поиск `plc-process-lib`;
   после добавления объекты видны как `PL.FB_Motor`, `PL.ST_MotorCfg`, `PL.GVL_Const.…`.
3. Собрать библиотеку из проекта: открыть проект, «Проект → Информация о проекте» (компания, название,
   версия, пространство имён по умолчанию `PL`), убрать `PRG_Main` и конфигурацию задач, «Сборка →
   Проверить все объекты пула», затем «Файл → Сохранить проект как скомпилированную библиотеку»
   (`.compiled-library`) или «Сохранить проект как…» с типом «Библиотека» (`.library`). _Названия
   пунктов меню — сверить с русской IDE 3.5.17.30; этот путь не выполнялся, `cds.py library` делает
   то же скриптом (проверено)._

Потребитель (репозиторий на шаблоне) подключает библиотеку описанием в `libraries` своего
`config.json` с `build_from_repo` — тогда недостающую версию `cds.py` соберёт и поставит сам
([USAGE.md, раздел 10](USAGE.md#10-проект-на-шаблоне-plc-repo-template)).

## 8. Зеркало на GitVerse или GitFlic

1. Создать пустой репозиторий на GitVerse или GitFlic (без README и лицензии).
2. Добавить его как второй remote и отправить все ветки и теги:

   ```bash
   git remote add mirror <url-зеркала>
   git push mirror --all
   git push mirror --tags
   ```

3. После каждого релиза повторять `git push mirror --all` и `git push mirror --tags`.

## 9. Ручная проверка: монотонность `LTIME()` (R1 контракта)

`FB_SystemTime` берёт время оператора `LTIME()`. Тесты `Time_SystemTime_IsMonotonic`,
`Runtime_LTime_ResolutionAtMost1us` и `Runtime_LTime_MonotonicAcrossTaskCycles` проверяют на Control
Win V3, что время не убывает внутри цикла, строго растёт от цикла к циклу задачи и меняется шагом
100 нс (числа — [TEST_REPORT.md](TEST_REPORT.md)), но не проверяют поведение при смене системного
времени ОС — это ручной шаг. _Не выполнялось: смена времени Windows требует прав администратора._

1. `python tools\codesys\cds.py import`, открыть `build\plc-process-lib.project` в IDE (раздел 6),
   «Онлайн → Логин», загрузить и запустить приложение.
2. Добавить в окно наблюдения `PRG_Main.ltUptime` (время от старта рантайма, обновляется каждые 20 мс).
3. Перевести системное время Windows на час назад, затем на час вперёд («Параметры → Время и язык»,
   нужны права администратора).
4. Ожидается: `ltUptime` растёт без скачков в обе стороны. Если значение прыгает вместе с часами ОС,
   записать в [BUILD_ERRORS.md](BUILD_ERRORS.md) и заменить реализацию `FB_SystemTime.Now`
   (кандидат — `SysTimeCore.SysTimeGetNs`, контракт 7.1).
5. То же на ПЛК210 (R16): разрешение `LTIME()` — по разнице соседних значений `ltUptime`.

## 10. Моточасы и пуски двигателей: Persistent Variables приложения

В библиотеке нет `RETAIN`/`PERSISTENT`-переменных (контракт 18.1): наработку, число пусков, режим и признак
вывода из работы `FB_Motor`/`FB_MotorVfd` хранят в структуре `stRetain : ST_DeviceRetain`, которую передаёт
приложение. Чтобы моточасы пережили пропадание питания, «Сброс холодный» и загрузку программы, переменная
должна лежать в объекте **Persistent Variables** приложения — по переменной на двигатель. _Поведение
persistent-данных на Control Win V3 и ПЛК210 тестами не проверялось (R6, R14, R15 контракта) — пройти
шаги 3–5 вручную._

1. В проекте приложения: «Application → Добавить объект → Persistent Variables», имя `GVL_Persist`
   (скриптом в SP17 не создаётся, D9 в [ASSUMPTIONS.md](ASSUMPTIONS.md)). Текст — из `src/GVLs/GVL_Persist.pvl.st`
   приложения (его генерирует `iolistgen`):

   ```st
   VAR_GLOBAL PERSISTENT RETAIN
       uiLayoutVersion : UINT := 1;
       stP101Cfg       : PL.ST_MotorCfg := (uiMaxStartsPerHour := 6, tMinStop := T#30S, udiAlarmIdBase := 20);
       stP101Retain    : PL.ST_DeviceRetain;   // режим, OOS, моточасы, пуски
   END_VAR
   ```

   Переменные — по возрастанию номера устройства, новое устройство — в конец списка; «Reorder List and Clear
   Gaps» не выполнять (теряются все данные, 18.3 контракта).
2. Вызов двигателя передаёт обе переменные в каждом вызове (`stCfg := GVL_Persist.stP101Cfg,
   stRetain := GVL_Persist.stP101Retain`, [FB_Motor.md](fb/FB_Motor.md#пример-вызова)). HMI показывает наработку из
   `stSts.rRunTime_h`, `udiStarts`; счётчики «с последнего ТО» обнуляет команда `stCmd.xResetMaint`.
3. Проверка на Control Win V3: запустить двигатель на несколько минут, записать `stP101Retain.udiOpTime_s` и
   `udiOpCount`; выполнить по очереди «Сброс тёплый», «Сброс холодный», остановку и запуск рантайма
   (`cds.py runtime restart`), загрузку изменённой программы. После каждого шага значения должны сохраниться
   (с точностью до 1 с — доля секунды в persistent не пишется).
4. Добавить второе устройство (`stP102Cfg`, `stP102Retain` в конец списка) и загрузить программу: значения
   `stP101Retain` должны сохраниться (R15).
5. Замена ПЛК или двигатель после ремонта: записать известные наработку и число пусков методом
   `fbP101.PresetCounters(udiRunTime_s := …, udiStarts := …)` из логики приложения (команда наладчика);
   значения применит ближайший вызов ФБ. Изменение типов `ST_MotorCfg`, `ST_VfdCfg`, `ST_DeviceRetain`
   (мажорная версия библиотеки) переинициализирует переменные целиком — до загрузки сохранить значения
   рецептом («Save Current Values to Recipe»), после — восстановить (правило 6 раздела 18.3 контракта).

## 11. Прогон тестов в CODESYS Control Win из IDE

`cds.py test` делает это без окна (раздел 5, проверено). Вручную — чтобы посмотреть упавший тест в
отладчике:

1. `python tools\codesys\cds.py import --tests` → `build\plc-process-lib-tests.project` (TestTask 10 мс →
   `PRG_Tests`, coUnit 1.2.0.0); `python tools\codesys\cds.py runtime start` — рантайм (раздел 4).
2. Открыть тестовый проект в IDE (раздел 6), «Онлайн → Логин» с пользователем из `credentials.json`,
   согласиться на загрузку, «Отладка → Старт».
3. В окне наблюдения: `coUnit.GVL_coUnit.coUnitRunner.AllTestSuitesFinished` (TRUE в первом цикле —
   все тесты одноцикловые, кроме `Runtime_LTime_MonotonicAcrossTaskCycles`: 50 циклов),
   `coUnit.GVL_coUnit.coUnitRunner.TestResults.TestSuiteResults.NumberOfFailedTestCases` — 0,
   `….NumberOfTestCases` — 453. Имя и сообщение упавшего теста —
   `….TestSuiteResults[i].TestCaseResults[j].TestName` / `FailureMessage` (индексы с 1).
4. «Онлайн → Выход», закрыть IDE (иначе `cds.py` откажется открывать проект), при необходимости
   `cds.py runtime stop`. Без лицензии рантайм работает 2 часа.

_Шаги 2–3 в IDE не выполнялись: те же значения читает `cds.py test` (`read_value`, проверено)._

## 12. Публикация релиза v1.0.0

1. Проверки на чистой рабочей копии `main` (после слияния `integrate`), все — зелёные:

   ```bat
   python tools\codesys\cds.py build --tests
   python tools\codesys\cds.py check --tests
   python tools\codesys\cds.py test
   python tools\codesys\cds.py roundtrip
   python tools\codesys\cds.py library --compiled
   python tools\check\st_lint.py --strict
   python tools\check\run_iec_checker.py --tests
   python tools\check\run_rusty.py
   python -m ruff check . && python -m ruff format --check . && python -m mypy && python -m pytest
   ```

2. Версия: в `tools/codesys/config.json` — `library.version` → `"1.0.0.0"`, `library.released` → `true`
   (I-09 в [ASSUMPTIONS.md](ASSUMPTIONS.md)); в `CHANGELOG.md` раздел `[Unreleased]` → `[1.0.0] - <дата>`;
   контракт [API.md](API.md) уже 1.0.0. _Выполнено на ветке `integrate` (19.10.2026): версия 1.0.0.0,
   `released = true`, раздел `[1.0.0] - 2026-10-16`; библиотека собрана и поставлена в репозиторий `System`
   (шаг 6)._ Автор в README, LICENSE, заголовках POU и Project Information библиотеки — `kr0nsch`
   (логин GitHub); компания библиотеки остаётся `plc-portfolio` (I-14 в [ASSUMPTIONS.md](ASSUMPTIONS.md)).
3. Артефакты: `python tools\codesys\cds.py library --compiled --released` (`.library`,
   `.compiled-library`), `python tools\codesys\cds.py build` (`build\plc-process-lib.project`),
   `python tools\codesys\cds.py test` и `python tools\codesys\cds.py report` — итоги в
   [TEST_REPORT.md](TEST_REPORT.md).
4. Коммит `chore(release): v1.0.0`, аннотированный тег `git tag -a v1.0.0 -m "plc-process-lib 1.0.0"`,
   `git push` и `git push --tags` — выполняет человек.
5. GitHub → Releases → «Draft a new release» по тегу `v1.0.0`: текст — раздел 1.0.0 из `CHANGELOG.md`;
   файлы — `plc-process-lib.library`, `plc-process-lib.compiled-library`, `plc-process-lib.project`
   (по желанию `.projectarchive` и тестовый проект). Отметить, что проверено только на CODESYS Control
   Win V3, не на ПЛК210.
6. Поставить релизную версию в репозиторий библиотек машины разработки:
   `python tools\codesys\cds.py library --compiled --install --released`. Потребители закрепляют
   `"version": "1.0.0.0"` в `libraries.plc-process-lib` своего `config.json`.
7. Зеркало — раздел 8.

## 13. Наладка: правила v1.0 по открытым вопросам

Решения интеграции по открытым вопросам семейств ([ASSUMPTIONS.md](ASSUMPTIONS.md#открытые-вопросы-семейств-решения-интеграции)),
которые выполняет наладчик:

- **Защитные уставки AI** («сухой ход», аварийный уровень; AI-Q5): `xLimitsOnFail := TRUE`,
  `eFailValue := Substitute`, `rFailValue_eu` — по безопасную сторону уставки; либо фиксация блокировки
  в логике станции. Иначе после возврата сигнала защита открыта на `astLimit[i].tOnDelay`.
- **Задержка LL** (AI-Q6): `astLimit[LL].tOnDelay` не меньше времени установления входного фильтра модуля
  AI (паспорт модуля) или `tFilter`.
- **Смена шкалы AI** (`eInput`, диапазоны, `xSqrt`; AI-Q7) — в OutOfService: фильтр начнётся заново.
- **Разрешающие DI**, которые должны подтвердиться после перезапуска ПЛК (DI-Q1), — своя задержка в логике
  станции: предустановка DI-1 пропускает `tOnDelay` один раз.
- **Регулирующий клапан «открыт при отказе» с ограничением скорости** (CV-12): проверить, что делает модуль
  AO при перезапуске ПЛК; после старта рампа идёт от 0 %.
- **Задание оператора ПИД** (P-Q1) не энергонезависимо: хранить его в Persistent Variables приложения или
  задавать логикой через `xSpExt`.
- **NaN на ПЛК210** (F-10): прогнать набор `FB_Util_Test` на контроллере — сравнения с NaN не должны давать
  исключений.
- **Параметры вне Cfg** (Cfg заморожена в 1.x, A-13) сверить с паспортами оборудования объекта:
  `GVL_Const.VLV_UNSEAT_BYPASS` = 2 с — окно страгивания клина задвижки (VLV-21, паспорт привода: время
  шунтирования моментного выключателя); `CV_TIGHT_HYST_PCT` = 1 % — гистерезис плотного закрытия (CV-13,
  паспорт позиционера); `VFD_POWER_UP_DELAY` = 10 с — время готовности ПЧ к обмену после подачи питания (VFD-12,
  паспорт ПЧ: время загрузки и инициализации интерфейса). Другие значения — только новой версией библиотеки
  (правка `GVL_Const`), поля Cfg — кандидаты 2.0.
- **Задвижка с электроприводом и блокировкой** (VLV-20): при отказе концевиков блокировка ведёт задвижку в
  положение безопасности по времени хода `tTravel` — `tTravel` должно быть не меньше полного хода по паспорту
  привода с запасом, а моментный выключатель (если он заведён в ПЛК) — настроен: при отказе концевиков ход
  заканчивается муфтой или по времени.
