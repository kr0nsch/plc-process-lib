# FB_DigitalInput — дискретный вход

Назначение: дискретный сигнал процесса — поплавок, реле давления, концевик, «напряжение на вводе»,
сигнал аварии от внешнего устройства. ФБ инвертирует нормально замкнутый контакт, подавляет дребезг
задержками включения и отключения (`FB_Delay`), выдаёт значение по `eFailValue` при отказе канала
(обрыв или КЗ NAMUR-датчика, отказ модуля, ошибка обмена), позволяет оператору подменить значение и
формирует тревогу по состоянию сигнала. Наследует [FB_DeviceBase](FB_DeviceBase.md): режимы,
конфигурация (LKG), NE 107, квитирование и тревоги — по общим правилам базы.

Исходник: `src/POUs/Devices/FB_DigitalInput/`. Контракт: раздел 12 [API.md](../API.md). Тип в
`stCommon.eDevType`: `E_DeviceType.DigitalInput`. Используется слотов тревог: 2
(`GVL_Const.DI_ALARM_COUNT`).

## Входы и выходы

| Имя | Направление | Тип | Единицы | Описание |
|---|---|---|---|---|
| `xIn` | вход | `BOOL` | — | сигнал канала (модуль DI, бит Modbus) |
| `xChannelFault` | вход | `BOOL` | — | TRUE — обрыв/КЗ (NAMUR-датчик, модуль), ошибка обмена; действует сразу, без своей задержки |
| `itfTime` | вход (база) | `I_TimeSource` | — | источник времени; 0 — системное время. В тестах — `FB_FakeTime` |
| `stCmd` | `VAR_IN_OUT` | `ST_DigitalInputCmd` | — | команды HMI/SCADA (`GVL_Hmi.st<TAG>Cmd`) |
| `stCfg` | `VAR_IN_OUT CONSTANT` | `ST_DigitalInputCfg` | — | параметры (`GVL_Persist.st<TAG>Cfg`) |
| `xValue` | выход | `BOOL` | — | значение для логики |
| `xValid` | выход | `BOOL` | — | нет отказа канала (или подмена), Cfg была корректна, не OutOfService |
| `stSts` | выход | `ST_DigitalInputSts` | — | состояние для HMI/SCADA (значение и сырой сигнал — биты `wStatus`) |

`stRetain` у дискретного входа нет: после перезапуска ПЛК — «Измерение» (A-06). Общие методы и
свойства — в [FB_DeviceBase](FB_DeviceBase.md#публичные-методы-и-свойства-i_device-i_alarmsource).
Своих публичных методов и свойств нет. Защищённые методы: `CheckConfig(stCfgIn) : WORD` (шаг 2),
`SelectValue(xSubst)` (выбор значения, шаг 6), `SubstRemainSec() : UINT` (остаток подмены); значение
подмены `SelectValue` получает параметром — `VAR_IN_OUT` методы не трогают (R2).

## Команды (`ST_DigitalInputCmd`)

| Поле | Вид | Действие | Результат (`eCmdResult`) |
|---|---|---|---|
| `stCommon.xSetAuto` | импульс | «Измерение» (выход из подмены и из OutOfService) | `Accepted` |
| `stCommon.xSetManual` | импульс | «Подмена» | `Accepted` |
| `stCommon.xSetOos` | импульс | вывести из работы (разрешено всегда) | `Accepted` |
| `stCommon.xReset` | импульс | фиксируемых отказов нет: квитирование всех тревог | `Accepted` (всегда) |
| `stCommon.xAck`, маски тревог | импульс / маска | тревоги слотов | [FB_DeviceBase](FB_DeviceBase.md#тревоги-в-слотах) |
| `xSubstValue` | значение | значение подмены. Пока режим не Manual, ФБ каждый вызов пишет сюда `xValue` (слежение) | — |

Подмена снимается сама через `tSubstMax`: результат `SubstExpired`, режим Auto.

## Параметры (`ST_DigitalInputCfg`)

| Поле | Тип | По умолчанию | Описание | Проверка (`wCfgErr`) |
|---|---|---|---|---|
| `xInvert` | `BOOL` | FALSE | инверсия до задержек (НЗ-контакт: обрыв цепи = срабатывание) | — |
| `tOnDelay` | `TIME` | `T#0S` | задержка включения (фронт сигнала после инверсии) | — |
| `tOffDelay` | `TIME` | `T#0S` | задержка отключения | — |
| `eFailValue` | `E_DiFailValue` | `HoldLast` | значение при отказе канала: последнее, FALSE или TRUE (защитные сигналы) | бит 0, если вне перечисления |
| `xAlarmOnTrue` | `BOOL` | TRUE | тревога State при `xValue = TRUE` (FALSE — при `xValue = FALSE`) | — |
| `tSubstMax` | `TIME` | `T#8H` | максимальная длительность подмены; `T#0S` — без ограничения | — |
| `udiAlarmIdBase` | `UDINT` | 0 | номер первой тревоги устройства | — |
| `astAlarm[0..7]` | `ST_AlarmCfg` | State — None, Failure — Medium | приоритеты, задержки, shelve по слотам | бит 1, если приоритет вне перечисления |

Значения по умолчанию проходят `CheckConfig` (тест `DigitalInput_DefaultCfg_FirstCallValueWithoutDelay`).
Тревога State по умолчанию выключена: генератор включает её, если сигнал тревожный.

## Режимы

| Режим | Значение | Контроль канала | Тревоги | NE 107 режима |
|---|---|---|---|---|
| Auto («Измерение») | после инверсии и задержек; при отказе канала — по `eFailValue` | да | да | — |
| Manual («Подмена») | `stCmd.xSubstValue` сразу, задержки обходятся; не дольше `tSubstMax` | да: отказ канала виден (Failure) | да | CheckFunction |
| OutOfService | удерживается, `xValid = FALSE` | нет | оба слота OutOfService | CheckFunction |

`xLocalSupported = FALSE`, `xOosAllowed = TRUE`. Хук `OnModeChanged` не переопределён: безударность
подмены даёт слежение `stCmd.xSubstValue`.

## Состояния

Задержки (`FB_Delay` по сигналу после инверсии) и отказ канала:

```mermaid
stateDiagram-v2
    [*] --> Off : первый вызов, сигнал FALSE
    [*] --> On : первый вызов, сигнал TRUE (без задержки)
    Off --> TimingOn : сигнал TRUE
    TimingOn --> Off : сигнал FALSE раньше tOnDelay
    TimingOn --> On : прошло tOnDelay
    On --> TimingOff : сигнал FALSE
    TimingOff --> On : сигнал TRUE раньше tOffDelay
    TimingOff --> Off : прошло tOffDelay
    Off --> ChannelFault : xChannelFault
    On --> ChannelFault : xChannelFault
    ChannelFault --> On : канал исправен, задержки — от возврата
    ChannelFault --> Off : канал исправен, задержки — от возврата
```

При отказе канала задержки стоят на значении до отказа (оно же — значение `HoldLast`) и после
возврата канала отсчитываются заново от этого значения. Биты `DI_STS_TIMING_ON`/`OFF` — пока канал
исправен.

## Безопасное состояние

| Ситуация | Выходы и значения |
|---|---|
| Корректной Cfg ещё не было | `xValue = FALSE`, `xValid = FALSE`, NE 107 CheckFunction |
| Отказ канала (Auto) | по `eFailValue`: `HoldLast` — значение до отказа, `ForceFalse` — FALSE, `ForceTrue` — TRUE; `xValid = FALSE`, NE 107 Failure |
| OutOfService | значение удерживается, `xValid = FALSE` |
| Local | — (режима нет) |

Для защитных сигналов (поплавок «сухой ход») правило монтажа — НЗ-контакт (обрыв цепи = срабатывание)
и `eFailValue = ForceTrue`: отказ канала остановит насос так же, как сработавший датчик. `xInvert`
позволяет логике работать в «прямых» терминах.

## Отказы и тревоги

Отказ канала не фиксируется: снимается сам, когда `xChannelFault` пропал; тревога остаётся `RtnUnack`
до квитирования.

| Слот (`E_DiAlarm`) | Условие | Подавление | Значение события | Приоритет по умолч. | Суффикс |
|---|---|---|---|---|---|
| 0 `State` | `xValue = xAlarmOnTrue` | `xChannelFault` (отказ показывает слот 1; без дублирования по ISA-18.2) | `xValue` как 0.0 / 1.0 | None | `ALM` |
| 1 `Failure` | `xChannelFault` | — | `xValue` как 0.0 / 1.0 | Medium | `FAIL` |

## Статус и готовность

- `eDevStatus`: Failure при отказе канала (кроме OutOfService); иначе Good. База добавляет
  CheckFunction за Manual, OutOfService и Cfg.
- `xAvailableDev = xValid`.

## Карта битов

| Бит | `wStatus` (младший байт) | `wFault` | `wCfgErr` |
|---|---|---|---|
| 0 | `DI_STS_VALUE` — `xValue` | `DI_FLT_CHANNEL` — отказ канала (не в OutOfService) | `DI_CFG_FAIL_VALUE` — `eFailValue` вне перечисления |
| 1 | `DI_STS_RAW` — сигнал после инверсии, до задержек | — | `DI_CFG_ALARM` — приоритет тревоги вне перечисления |
| 2 | `DI_STS_TIMING_ON` — идёт задержка включения | — | — |
| 3 | `DI_STS_TIMING_OFF` — идёт задержка отключения | — | — |
| 4 | `DI_STS_CHANNEL_FAULT` — `xChannelFault` (во всех режимах) | — | — |
| 5 | `DI_STS_ALARM_COND` — условие слота State | — | — |

Биты `wWarning` не используются (0). Биты 6–7 `wStatus` — 0. Старший байт `wStatus` — общий
([FB_DeviceBase](FB_DeviceBase.md#карта-битов)).

## Раскладка `ST_DigitalInputSts` (карта регистров)

| Смещение, байт | Регистр | Поле | Тип | Описание |
|---|---|---|---|---|
| 0…27 | 0…13 | `stCommon` | `ST_DeviceSts` | общий заголовок; значение — бит 0 `wStatus` |
| 28 | 14 | `uiSubstRemain_s` | `UINT` | до снятия подмены, с (вверх); 0 — подмены нет или срок не ограничен |

Размер — 30 байт (тест `Common_SizeOfSts_MatchesRegisterMap`).

## Пример вызова

```st
// PRG_Devices (генерирует iolistgen): сигналы перечня и все VAR_IN_OUT в каждом вызове
GVL_Devices.fbLSL102(
    xIn           := GVL_IO.xLSL102,             // поплавок «сухой ход», НЗ-контакт
    xChannelFault := GVL_IO.xDI1_ModuleFault,
    stCmd         := GVL_Hmi.stLSL102Cmd,
    stCfg         := GVL_Persist.stLSL102Cfg);   // xInvert := TRUE, eFailValue := ForceTrue
// логика станции: TRUE — уровень ниже поплавка (или отказ канала)
xDryRun := GVL_Devices.fbLSL102.xValue;
```

## Допущения и отклонения

Решения реализации, которые контракт не задаёт. Интегратор переносит их в
[ASSUMPTIONS.md](../ASSUMPTIONS.md).

| № | Суть | Обоснование |
|---|---|---|
| DI-1 | В первом вызове задержки предустанавливаются на текущий сигнал (`FB_Delay.Preset`): после старта ПЛК значение сразу равно входу, без `tOnDelay` | Как фильтр AI, который начинает с текущего значения. Иначе вход, включённый при старте, `tOnDelay` выглядел бы выключенным — ложная тревога у сигналов с `xAlarmOnTrue = FALSE`. Тест `DigitalInput_DefaultCfg_FirstCallValueWithoutDelay` |
| DI-2 | При отказе канала задержки стоят на значении до отказа и отсчитываются заново после возврата канала; биты отсчёта — только пока канал исправен | Сигнал при отказе канала недостоверен: дребезг «мусора» не должен попасть в значение. Тест `DigitalInput_ChannelFault_HoldLast` |
| DI-3 | Отказ канала в OutOfService не даёт Failure и `DI_FLT_CHANNEL` (контроля нет, таблица 2.2); бит `DI_STS_CHANNEL_FAULT` показывает диагностику во всех режимах | Как AI-3 у аналогового входа: OutOfService — «в ремонте» |
| DI-4 | Отказ канала без корректной Cfg — Failure | Диагностика канала от Cfg не зависит (в отличие от NE 43 аналогового входа) |
| DI-5 | Защищённые методы сверх 22.4: `SelectValue`, `SubstRemainSec` | Тело — нормативные шаги 9.4, выбор значения — отдельным методом (как у AI) |
| DI-6 | Снятие подмены по `tSubstMax` — в шаге 5, до выбора значения; `uiSubstRemain_s` — вверх, 0 при `tSubstMax = T#0S` | Как AI-7 |
| DI-7 | Значение события обоих слотов — `xValue` как 0.0 / 1.0 | Контракт задаёт `arAlmValue` только для AI |
| DI-8 | Слежение `stCmd.xSubstValue := xValue` — во всех режимах, кроме Manual | Правило 2.1 контракта (12.3 называет только Auto) |

## Статанализ

| Инструмент | Итог (16.10.2026) |
|---|---|
| CODESYS 3.5.17.30, `cds.py build --tests`, `cds.py check --tests` | 0 ошибок, 0 предупреждений |
| `st_lint --strict` | 0 ошибок; `lint:allow STL007` — `stCfg`, `CheckConfig.stCfgIn` (`VAR_IN_OUT CONSTANT`, F-13) |
| iec_checker 0.4 (`run_iec_checker.py --tests`) | ошибок разбора нет; PLCOPEN-CP9 обоснован в `tools/check/iec_checker_allow.toml` (классическая сложность: тело 10, `SelectValue` 7, `CheckConfig` 3); в тестах — объединения `uEnum`, `uPrio` и индекс помощника `SetAlarmPriority` |
| RuSTy 1.0.6 | `FB_DigitalInput.st`, `FB_DigitalInput_Test.st` исключены: `VAR_IN_OUT CONSTANT` (E034, E036) |

## Тесты (`FB_DigitalInput_Test`)

Из списка контракта (9, ★ 5 — все): ★ `DigitalInput_OnDelay_FiltersBounce` ·
★ `DigitalInput_OffDelay_HoldsValue` · ★ `DigitalInput_Invert_InvertsBeforeDelay` ·
★ `DigitalInput_Substitution_OverridesValueBypassesDelay` · ★ `DigitalInput_ChannelFault_ForceTrue` ·
`DigitalInput_ChannelFault_HoldLast` · `DigitalInput_AlarmOnFalse_ActivatesWhenValueFalse` ·
`DigitalInput_OutOfService_AlarmsOutOfService` · `DigitalInput_SubstitutionTimeout_ReturnsToAuto`.

Сверх контракта (4): `DigitalInput_DefaultCfg_FirstCallValueWithoutDelay` (умолчания Cfg, тип, слоты,
DI-1), `DigitalInput_InvalidCfgAtStartup_ValueFalseCheckFunction` (безопасное значение без Cfg, биты
`wCfgErr`), `DigitalInput_ResetCmd_AcceptedAndAcksAlarms`, `DigitalInput_ChannelFault_ForceFalse`.

Проверено в CODESYS (Control Win V3, 16.10.2026, `cds.py test`): 13 из 13.

Мутационная проверка (16.10.2026, вместе с мутациями аналогового входа, затем откат): без
предустановки задержек в первом вызове — упал `DigitalInput_DefaultCfg_FirstCallValueWithoutDelay`;
тревога State не подавляется при отказе канала — `DigitalInput_ChannelFault_ForceTrue`.
