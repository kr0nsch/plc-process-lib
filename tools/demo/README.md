# Демонстрационный прогон

Небольшое приложение CODESYS на **установленной** библиотеке `plc-process-lib, 1.0.0.0 (plc-portfolio)`:
три сценария идут в CODESYS Control Win V3 в реальном времени (задача 10 мс), пишут журналы в массивы
`GVL_DemoLog`, а скрипт читает их из онлайн-приложения и выгружает в CSV. По этим CSV построены графики
раздела «Демонстрация» [README](../../README.md). В библиотеку и в тесты демо не входит.

| Сценарий | ФБ библиотеки | Что показывает |
|---|---|---|
| A, `FB_DemoLevelLoop` | `FB_AnalogInput` → `FB_PID` → `FB_MotorVfd` | контур уровня по примеру 17.3 контракта: пуск насоса без рывка (слежение ПИД), ступень задания с насыщением выхода и обратным расчётом, ступень притока |
| B, `FB_DemoNe43` | `FB_AnalogInput` | ток 0 → 24 мА: мгновенная классификация NE 43, подтверждение 2 с, статус NE 107, `xValid`, удержание и насыщение значения |
| C, `FB_DemoAlarm` | `FB_AnalogInput` (слот тревоги H) | ISA-18.2: Normal → ActiveUnack → ActiveAck → Normal, возврат без квитирования (RtnUnack), shelve на 15 с и повторное оповещение |

Объект в сценарии A — модель ёмкости на ST (баланс объёма, подача насоса пропорциональна скорости, ПЧ с
рампой 25 %/с); ёмкость, насос и настройки регулятора вымышленные. Ток в сценариях B и C задаётся
профилем. Всё остальное — код библиотеки 1.0.0.0, вызванный так же, как в приложении: команды, Cfg и
Retain через структуры, устройства берут системное время сами.

## Запуск

Нужны Windows, CODESYS 3.5.17.30, Python 3.11+ и установленная библиотека 1.0.0.0
(`python tools/codesys/cds.py library --compiled --install`).

```bat
python tools\demo\run_demo.py                 :: импорт, сборка, прогон ~2,5 мин, CSV в docs\media\data\
python tools\demo\plot_demo.py                :: графики docs\media\chart-*-dark.png и -light.png
```

`run_demo.py` берёт общие блокировки и рантайм `cds.py` (если рантайм занят тестами другого репозитория —
ждёт) и собирает проект из `tools/demo/src/` по `tools/demo/config.json`; проект и журналы CODESYS — в
`tools/demo/build/` (вне git). Шаг прогона — `demo_capture.py` (IronPython 2.7): вход в рантайм и загрузка
приложения теми же функциями, что у `cds.py test`, затем старт, ожидание `GVL_DemoLog.xAllDone` и чтение
журналов. `plot_demo.py` данные не пересчитывает и не сглаживает; оформление — общий медиакит портфолио
(`charts.py`, путь — `--kit` или `MEDIA_KIT`), в репозиторий он не входит.

## Данные

| Файл | Содержимое |
|---|---|
| [`demo-level-loop.csv`](../../docs/media/data/demo-level-loop.csv) | A, каждые 0,2 с: уровень модели, PV, действующее задание, выход ПИД и его P и I, задание и скорость ПЧ, приток и отбор, `E_MotorState`, `wStatus` ПИД |
| [`demo-ne43.csv`](../../docs/media/data/demo-ne43.csv) | B, каждые 0,1 с: ток, `rValue_eu`, `xValid`, `eSignal`, `eNe107`, `wStatus`, `wAlmActive` |
| [`demo-alarm.csv`](../../docs/media/data/demo-alarm.csv) | C, каждые 0,2 с: уровень, флаг `xH`, `E_AlarmState` слота H, `wAlmUnack`, `wAlmShelved` |
| [`demo-events.csv`](../../docs/media/data/demo-events.csv) | события сценариев: A — 1 пуск насоса, 2 ступень задания, 3 ступень притока; C — 1 квитирование, 2 shelve |
| [`demo-run.json`](../../docs/media/data/demo-run.json) | условия прогона: версия CODESYS, устройство, библиотека, время, коммит |

Перечисления записаны целыми значениями `E_*` библиотеки (`src/DUTs/`), слова состояния — числами (биты —
`GVL_Const`, разделы ФБ в [docs/fb/](../../docs/fb/)).
