# FB_ControlValve — регулирующий клапан с позиционером

Назначение: выдача задания положения на позиционер регулирующего клапана (AO 4–20 мА) — с пределами,
ограничением скорости (рампа в %/с, не зависящая от цикла), плотным закрытием и инверсией выхода;
надзор за положением по ОС (рассогласование — предупреждение или отказ), отказ ОС и позиционера;
положение безопасности по блокировке и отказу — мимо рампы. Ставится за ПИД-регулятором (выход ПИД —
`rPosSpAuto_pct`, слежение ПИД — по `xAutoActive`). ОС здесь нужна для надзора: позиционер держит
положение сам, поэтому отказ ОС — повод для обслуживания, а не для останова.
Запорная арматура «открыто/закрыто» — [FB_Valve](FB_Valve.md).

Наследует [FB_DeviceBase](FB_DeviceBase.md): режимы, конфигурация (LKG), NE 107, квитирование и
тревоги — по общим правилам базы.

Исходник: `src/POUs/Devices/FB_ControlValve/`. Контракт: раздел 16 [API.md](../API.md). Тип в
`stCommon.eDevType`: `E_DeviceType.ControlValve`. Используется слотов тревог: 4
(`GVL_Const.CV_ALARM_COUNT`).

## Входы и выходы

| Имя | Направление | Тип | Единицы | Описание |
|---|---|---|---|---|
| `itfTime` | вход | `I_TimeSource` | — | источник времени (база); 0 — системное время, в тестах `FB_FakeTime` |
| `rPosSpAuto_pct` | вход | `REAL` | % хода | задание от автоматики (выход ПИД); действует в Auto |
| `rPosFb_pct` | вход | `REAL` | % хода | ОС положения (обычно `fbZT.rValue_pct`) |
| `xPosFbValid` | вход | `BOOL` | — | ОС достоверна (обычно `fbZT.xValid`); NaN в `rPosFb_pct` — недостоверна и при TRUE |
| `xLocal` | вход | `BOOL` | — | позиционер в местном/ручном режиме (байпас, маховик) |
| `wInterlock` | вход | `WORD` | биты | блокировки: бит = 1 — в `rSafePos_pct` (под маской `wInterlockMask`) |
| `xPositionerFault` | вход | `BOOL` | — | авария позиционера (DI) или отказ канала AO (диагностика модуля) |
| `stCmd` | `VAR_IN_OUT` | `ST_ControlValveCmd` | — | команды HMI/SCADA (`GVL_Hmi.st<TAG>Cmd`) |
| `stRetain` | `VAR_IN_OUT` | `ST_DeviceRetain` | — | режим, OOS (`GVL_Persist.st<TAG>Retain`) |
| `stCfg` | `VAR_IN_OUT CONSTANT` | `ST_ControlValveCfg` | — | параметры (`GVL_Persist.st<TAG>Cfg`) |
| `rOut_pct` | выход | `REAL` | % хода | задание положения (до инверсии) |
| `rOut_mA` | выход | `REAL` | мА | на AO с учётом инверсии: `4 + 16·x/100`, x = `rOut_pct` или `100 − rOut_pct` |
| `xAutoActive` | выход | `BOOL` | — | клапан следует `rPosSpAuto_pct`: Auto, нет отказа и блокировки, корректная Cfg. ПИД: `xTrack := NOT xAutoActive` |
| `stSts` | выход | `ST_ControlValveSts` | — | состояние для HMI/SCADA (раскладка — ниже) |

Общие для всех устройств методы и свойства (`Reset`, `AckAll`, `RequestMode`, `GetAlarm`, `Mode`,
`Status`, `Fault`, `Available`, `AlarmCount`) — в
[FB_DeviceBase](FB_DeviceBase.md#публичные-методы-и-свойства-i_device-i_alarmsource). Своих публичных
методов и свойств нет.

## Команды (`ST_ControlValveCmd`)

| Поле | Вид | Действие | Результат (`eCmdResult`) |
|---|---|---|---|
| `stCommon` | общий заголовок | режимы, Reset, квитирование, маски тревог | [FB_DeviceBase](FB_DeviceBase.md#режимы) |
| `rPosSpMan_pct` | значение | задание положения в Manual, %. Пока выходом управляет не оператор (Auto, Local, OOS, блокировка, отказ, нет корректной Cfg), ФБ пишет сюда текущий `rOut_pct` — переход в Manual без рывка | — |

Reset (`stCommon.xReset`, `Reset()`) — `Accepted`: снимает зафиксированный отказ рассогласования и
первопричину блокировки.

## Параметры (`ST_ControlValveCfg`)

| Поле | Тип | По умолчанию | Описание | Проверка (`wCfgErr`) |
|---|---|---|---|---|
| `rOutMin_pct` | `REAL` | 0.0 | нижний предел задания, % | бит 0 `CV_CFG_LIMITS` — `< 0`, не конечен или `>= rOutMax_pct` |
| `rOutMax_pct` | `REAL` | 100.0 | верхний предел задания, % | бит 0 — `> 100` или не конечен |
| `rRateUp_pctps` | `REAL` | 0.0 | скорость роста выхода, %/с; 0 — без ограничения | бит 1 `CV_CFG_RATE` — `< 0` или не конечна |
| `rRateDown_pctps` | `REAL` | 0.0 | скорость спада, %/с; 0 — без ограничения | бит 1 |
| `rTightShut_pct` | `REAL` | 0.0 | порог плотного закрытия: выход ниже — 0 %; 0 — выключено | бит 4 `CV_CFG_TIGHT_SHUT` — `< 0`, не конечен или `>= rOutMax_pct` |
| `xOutInvert` | `BOOL` | FALSE | TRUE: 100 % хода = 4 мА | — |
| `rSafePos_pct` | `REAL` | 0.0 | положение по блокировке и отказу (не путать с механическим при потере воздуха) | бит 2 `CV_CFG_SAFE_POS` — вне 0…100 или не конечно |
| `eFaultAction` | `E_CvFaultAction` | `Hold` | реакция на отказ: `Hold` — удержание, `SafePos` — `rSafePos_pct` без рампы | бит 5 `CV_CFG_FAULT_ACTION` — вне перечисления |
| `xFbUsed` | `BOOL` | FALSE | ОС положения подключена | — |
| `rDevMax_pct` | `REAL` | 5.0 | допуск рассогласования, % | бит 3 `CV_CFG_DEVIATION` — при `xFbUsed`: `<= 0` или не конечен |
| `tDev` | `TIME` | `T#30S` | задержка рассогласования | бит 3 — при `xFbUsed`: `T#0S` |
| `xDevIsFault` | `BOOL` | FALSE | TRUE — рассогласование фиксируемый отказ; FALSE — предупреждение | — |
| `wInterlockMask` | `WORD` | 16#FFFF | какие биты `wInterlock` действуют | — |
| `udiAlarmIdBase` | `UDINT` | 0 | номер первой тревоги устройства (`dev_no · 10`) | — |
| `astAlarm` | `ARRAY[0..7] OF ST_AlarmCfg` | см. «Отказы и тревоги» | приоритеты, задержки, shelve по слотам | бит 6 `CV_CFG_ALARM` — приоритет вне перечисления |

Значения по умолчанию проходят `CheckConfig` (тест `ControlValve_DefaultCfg_PassesCheck`; общий тест
всех типов `Device_DefaultCfg_PassesCheck` пишет основа).

## Выбор выхода и режимы

По старшинству (таблица 16.3 контракта; шаг `SelectOutput`):

| № | Условие | `rOut_pct` | Рампа | Бит |
|---|---|---|---|---|
| 1 | корректной Cfg ещё не было | `LIMIT(0, rSafePos_pct, 100)` **поданной** Cfg; NaN — 0 | нет | `CV_STS_SAFE_POS` |
| 2 | OutOfService | удерживается | — | — |
| 3 | Local | = `LIMIT(0, rPosFb_pct, 100)` при `xFbUsed` и достоверной ОС, иначе удерживается | нет | — |
| 4 | блокировка (Auto/Manual) | `rSafePos_pct` — мимо `rOutMin/Max` | нет: безопасность важнее плавности | `CV_STS_SAFE_POS`, `CV_STS_INTERLOCKED` |
| 5 | отказ и `eFaultAction = SafePos` | `rSafePos_pct` | нет | `CV_STS_SAFE_POS` |
| 5а | отказ и `eFaultAction = Hold` | удерживается | — | — |
| 6 | Auto | `LIMIT(rOutMin, rPosSpAuto_pct, rOutMax)` через рампу; задание не число — удержание и `CV_WRN_SP_INVALID` | да | `CV_STS_RAMPING`, `LIMITED_MIN/MAX` |
| 7 | Manual | `LIMIT(rOutMin, stCmd.rPosSpMan_pct, rOutMax)` через рампу (не число — так же) | да | то же |

- После выбора: `rTightShut_pct > 0` и положение ниже порога → `rOut_pct := 0` (`CV_STS_TIGHT_SHUT`).
  Плотное закрытие действует на выход, а не на состояние рампы: рампа от 0 проходит порог и не
  «залипает» (тест `ControlValve_TightShut_BelowThresholdGivesZero`).
- Рампа — `F_RateLimit` по фактическому шагу времени `ltDt`: результат не зависит от цикла задачи
  (тест `ControlValve_Ramp_IndependentOfCycleTime`). В первом вызове (шаг 0) при неограниченной скорости
  в нужную сторону выход сразу равен заданию. После старта ПЛК рампа начинается от 0 % (CV-12).
- При переключениях рампа начинается с текущего выхода: `OnModeChanged` предустанавливает её
  `rOut_pct`; после блокировки и отказа с `SafePos` рампа идёт от положения безопасности.
- `xLocalSupported = TRUE`, `xOosAllowed = TRUE` (клапан не «движется» как механизм). Вход в
  OutOfService снимает фиксацию рассогласования и первопричину.

## Безопасное состояние

| Ситуация | Выход |
|---|---|
| Корректной Cfg ещё не было | `LIMIT(0, rSafePos_pct, 100)` поданной Cfg (NaN — 0), ток — с её `xOutInvert` (тест `ControlValve_InvalidCfg_StartupSafePosition`) |
| Отказ | `eFaultAction`: `SafePos` — `rSafePos_pct` без рампы; `Hold` — удержание |
| OutOfService | удержание (A-09) |
| Local | следит за ОС в пределах хода 0…100 % (ток не выходит из 4…20 мА) |

## Отказы и тревоги

| Слот (`E_CvAlarm`) | Условие | Подавление | Фиксация до Reset | Приоритет по умолч. | `wFault` / `wWarning` |
|---|---|---|---|---|---|
| 0 `Deviation` | \|выход − ОС\| > `rDevMax_pct` дольше `tDev`: `xFbUsed`, ОС достоверна, Auto/Manual, рампа не активна | — | при `xDevIsFault` — да | Low | `CV_FLT_DEVIATION` (при `xDevIsFault`) или `CV_WRN_DEVIATION` |
| 1 `FbFailure` | `xFbUsed` и ОС недостоверна (или не число) | — | нет | Low | `CV_WRN_FB_INVALID` |
| 2 `PositionerFault` | `xPositionerFault`, кроме OutOfService | — | нет | Medium | `CV_FLT_POSITIONER` |
| 3 `InterlockAct` | действует блокировка (Auto/Manual) | — | нет | None (выключена) | — |

- **Рассогласование** сравнивает выход прошлого вызова с ОС этого (ОС отражает уже поданное
  задание); в первом вызове не оценивается. Предупреждение снимается сразу, когда расхождение вернулось
  в допуск (тест `ControlValve_Deviation_WarningAfterDelay`); во время рампы не контролируется (тест
  `ControlValve_DeviationDuringRamp_Ignored`). Как отказ — фиксируется, реакция по `eFaultAction` (тест
  `ControlValve_DeviationAsFault_GoesSafePosition`).
- **Reset** снимает фиксацию рассогласования без условия и начинает отсчёт `tDev` заново: если клапан
  по-прежнему не следует, отказ вернётся через `tDev`.
- **`tDev` больше полного хода клапана.** Отсчёт рассогласования начинается, как только рампа дошла до
  задания; при скачке выхода (скорость не ограничена, положение безопасности по блокировке или
  отказу) — сразу. Клапан, которому на полный ход нужно больше `tDev`, при таком скачке получит ложное
  рассогласование, а при `xDevIsFault` — отказ.
- **Отказ ОС** — только предупреждение и NE 107 MaintenanceRequired, клапан управляется дальше (тест
  `ControlValve_FbInvalid_MaintenanceRequiredKeepsControl`).
- **Отказ позиционера** не фиксируется: ушёл — выход возвращается к заданию по рампе (тест
  `ControlValve_PositionerFault_SafePosAction`).
- `arAlmValue`: Deviation — `rOut_pct − rPosFb_pct`, FbFailure — `rPosFb_pct`, остальные — `rOut_pct`.

## Статус и готовность

- `eDevStatus`: Failure при `wFault <> 0`; иначе OutOfSpecification при предупреждении рассогласования;
  иначе MaintenanceRequired при отказе ОС; иначе Good.
- `xAvailableDev = (eMode = Auto) AND (wFault = 0) AND` нет действующих блокировок; `xAutoActive` —
  то же и корректная Cfg (бит `CV_STS_AVAILABLE`).

## Карта битов

| Бит | `wStatus` (младший байт) | `wFault` | `wWarning` | `wCfgErr` |
|---|---|---|---|---|
| 0 | `CV_STS_AT_SETPOINT` — ОС достоверна и \|выход − ОС\| ≤ `rDevMax_pct` | `CV_FLT_DEVIATION` (при `xDevIsFault`) | `CV_WRN_DEVIATION` | `CV_CFG_LIMITS` — `rOutMin_pct < 0`, `rOutMax_pct > 100`, `min >= max` или не конечны |
| 1 | `CV_STS_RAMPING` — рампа не дошла до задания (Auto/Manual) | `CV_FLT_POSITIONER` (нефикс.) | `CV_WRN_FB_INVALID` | `CV_CFG_RATE` — скорость < 0 или не конечна |
| 2 | `CV_STS_LIMITED_MIN` — задание ниже `rOutMin_pct` | — | `CV_WRN_SP_INVALID` — задание не число, выход удерживается | `CV_CFG_SAFE_POS` — `rSafePos_pct` вне 0…100 или не конечно |
| 3 | `CV_STS_LIMITED_MAX` — задание выше `rOutMax_pct` | — | — | `CV_CFG_DEVIATION` — `xFbUsed` и (`rDevMax_pct <= 0`, не конечен или `tDev = T#0S`) |
| 4 | `CV_STS_INTERLOCKED` — блокировка действует (Auto/Manual) | — | — | `CV_CFG_TIGHT_SHUT` — `rTightShut_pct < 0`, не конечен или `>= rOutMax_pct` |
| 5 | `CV_STS_TIGHT_SHUT` — плотное закрытие | — | — | `CV_CFG_FAULT_ACTION` — вне перечисления |
| 6 | `CV_STS_SAFE_POS` — выход принудительно в `rSafePos_pct` | — | — | `CV_CFG_ALARM` — приоритет тревоги вне перечисления |
| 7 | `CV_STS_AVAILABLE` — `xAutoActive` | — | — | — |

Старший байт `wStatus` — общий ([FB_DeviceBase](FB_DeviceBase.md#карта-битов)).

## Раскладка `ST_ControlValveSts` (карта регистров)

| Смещение, байт | Регистр | Поле | Тип | Описание |
|---|---|---|---|---|
| 0…27 | 0…13 | `stCommon` | `ST_DeviceSts` | общий заголовок |
| 28 | 14–15 | `rPosSp_pct` | `REAL` | задание после пределов, до рампы (в принудительных и удерживающих ветвях — их цель) |
| 32 | 16–17 | `rOut_pct` | `REAL` | выход, % |
| 36 | 18–19 | `rOut_mA` | `REAL` | выход, мА |
| 40 | 20–21 | `rPosFb_pct` | `REAL` | ОС положения (вход как есть) |
| 44 | 22–23 | `rDeviation_pct` | `REAL` | `rOut_pct − rPosFb_pct`; 0 без достоверной ОС |
| 48 | 24 | `wInterlock` | `WORD` | действующие блокировки (после маски) |
| 50 | 25 | `uiFirstOut` | `UINT` | первопричина блокировки; `NO_FIRST_OUT` (16#FFFF) — нет |

Размер — 52 байта, 26 регистров (тест основы `Common_SizeOfSts_MatchesRegisterMap`).

## Пример вызова

```st
// логика станции — ДО вызова: задание от ПИД и блокировки
GVL_Devices.fbFV201.rPosSpAuto_pct := GVL_Devices.fbFIC201.rOut_pct;
GVL_Devices.fbFV201.wInterlock.0   := GVL_Station.xEmergencyStop;
// PRG_Devices (генерирует iolistgen): сигналы перечня и все VAR_IN_OUT в каждом вызове
GVL_Devices.fbFV201(
    rPosFb_pct       := GVL_Devices.fbZT201.rValue_pct,
    xPosFbValid      := GVL_Devices.fbZT201.xValid,
    xLocal           := GVL_IO.xFV201_Local,
    xPositionerFault := GVL_IO.xFV201_PosFault,
    stCmd            := GVL_Hmi.stFV201Cmd,
    stCfg            := GVL_Persist.stFV201Cfg,
    stRetain         := GVL_Persist.stFV201Retain);
GVL_IO.rFV201_AO_mA := GVL_Devices.fbFV201.rOut_mA;
// ПИД следит за клапаном, пока тот не исполняет его задание
GVL_Devices.fbFIC201.xTrack := NOT GVL_Devices.fbFV201.xAutoActive;
```

## Реализация

Тело — нормативный порядок цикла (раздел 9.4): первый вызов → `BeginCycle` → LKG → Reset →
`ProcessMode` → первопричина, ОС, позиционер, рассогласование → `SelectOutput` (защищённый метод:
выбор выхода по таблице 16.3; значения `stCmd.rPosSpMan_pct` и `stCfg.rSafePos_pct` получает
параметрами, к `VAR_IN_OUT` не обращается — R2) → плотное закрытие, мА, слежение → тревоги →
состояние и `FinishCycle`. Задержка — `FB_Delay` (`fbDev`). Состояние рампы — `rRamp_pct` (до
плотного закрытия). Имена методов и переменных секции `VAR` для наследника зарезервированы (L2).

## Допущения и отклонения

Сводит в [ASSUMPTIONS.md](../ASSUMPTIONS.md) интегратор; номера здесь — внутренние.

| № | Суть | Почему |
|---|---|---|
| CV-1 | Без корректной Cfg положение безопасности и инверсия тока берутся из **поданной** `stCfg` (`LIMIT(0, rSafePos_pct, 100)`, NaN — 0), а не из умолчаний `stCfgLkg` (0 %) | Так записано в 2.6/16.3: «NaN → 0» имеет смысл только для непроверенного значения. Положение безопасности — главный параметр клапана: если Cfg неверна в другом поле (пределы), клапан «открыть при отказе» должен открыться, а не закрыться на умолчании. Отклонение от фразы 9.4 «безопасный выход по умолчаниям типа»; тело читает `stCfg` только в этой ветви, методы — нет (R2) |
| CV-2 | Плотное закрытие действует на выход; состояние рампы хранится до него (`rRamp_pct`) | Иначе рампа с ограничением скорости от 0 обнулялась бы каждый вызов и никогда не проходила порог |
| CV-3 | Шаг времени 0 (первый вызов, «время назад») и скорость в нужную сторону не ограничена — выход сразу равен заданию; при ограничении — рампа от текущего выхода | `F_RateLimit` при `dt <= 0` значение не меняет; без этого первый вызов без рампы держал бы 0 % |
| CV-4 | Рассогласование: выход прошлого вызова против ОС этого; «рампа не активна» — по прошлому вызову; в первом вызове не оценивается; предупреждение снимается сразу | ОС отражает уже поданное задание; в первом вызове выхода ещё не было |
| CV-5 | Reset снимает отказ рассогласования без условия и перезапускает отсчёт `tDev` | С `eFaultAction = Hold` и заклинившим клапаном расхождение остаётся всегда — условный сброс сделал бы отказ неснимаемым до вывода из работы |
| CV-6 | Задание Manual следит за выходом везде, где выходом управляет не оператор, — и в Manual при блокировке, отказе, без корректной Cfg; после снятия блокировки в Manual клапан остаётся в положении безопасности. Задание-NaN в Manual не переписывается (предупреждение видно) | Правило 2.1 «пока значением управляет не оператор, ФБ пишет текущее»; 16.3 говорит «везде, кроме Manual» — уточнено для принудительных ветвей. Поведение после блокировки — как у FB_Valve и двигателя |
| CV-7 | Отказ позиционера контролируется во всех режимах, кроме OutOfService; отказ ОС — во всех режимах | Таблица 2.2: в OOS контроля нет; в Local отказ позиционера — реальная неисправность, о которой нужно знать |
| CV-8 | `rDeviation_pct = 0` и бит `AT_SETPOINT = 0` без достоверной ОС; `rPosSp_pct` в принудительных и удерживающих ветвях — их цель | Контракт не уточняет |
| CV-9 | Первопричина — как у FB_Valve (переход 0 → не 0, кроме OOS; снимают Reset и вход в OOS) | Единообразие арматуры и двигателя (13.6) |
| CV-10 | Выбор выхода вынесен в защищённый метод `SelectOutput`, условия вызова — переменные `VAR` экземпляра | Классическая цикломатическая сложность тела была 27, после — 16 и 12 |
| CV-11 | Local: выход следует ОС в пределах хода — `LIMIT(0, rPosFb_pct, 100)` | Контракт 16.3: «= rPosFb_pct». Датчик положения закрытого клапана часто показывает чуть ниже нуля (-1…-2 %) и при этом достоверен; без ограничения ток выхода ушёл бы ниже 4 мА (3,76 мА при -1,5 %), а позиционеру с питанием от токовой петли нужен минимальный ток (по паспорту позиционера). Ход клапана за 0…100 % не выходит. Тест `ControlValve_LocalFeedbackOutOfRange_OutputClamped` |
| CV-12 | После старта ПЛК рампа (при ограничении скорости) начинается от 0 %, ОС для предустановки не используется. **Открытый вопрос интегратору** | Недостоверная или «застрявшая» ОС не должна сдвигать выход в первом вызове. Для клапана «открыт при отказе» с ограничением скорости это рывок к 0 % после рестарта, если модуль AO держал прошлый ток. Предустановка от ОС или от `rSafePos_pct` — решение за интегратором |

Связанные решения основы: A-01 (LKG), A-09 (OOS — удержание).

## Статанализ

- CODESYS 3.5.17.30: тестовая сборка — 0 ошибок, 0 предупреждений (C0371 нет); `cds.py check --tests` —
  0 ошибок.
- iec_checker 0.4 (`run_iec_checker.py --tests`): ошибок разбора нет. Обоснования в
  `tools/check/iec_checker_allow.toml`, раздел «Семейство арматуры»: PLCOPEN-CP9 (классическая
  сложность — тело 16, `SelectOutput` 12, `CheckConfig` 8) и UnusedVariable `rPosSpAuto_pct` —
  артефакт понижения (вход использует только `SelectOutput`).
- RuSTy 1.0.6: проверяются все файлы, ошибок нет: вариант сборки `rusty` понижает `VAR_IN_OUT CONSTANT` до `VAR_IN_OUT` (замена R13 шаблона), исключений нет.

## Тесты (`FB_ControlValve_Test`)

Прогон: CODESYS 3.5.17.30, Control Win V3, 16.10.2026, `cds.py test` — все тесты набора пройдены.
Числа — из `tools/reference/valve_reference.py` (сценарии `cv_manual_ramp`, `cv_tight_ramp`,
`cv_return_ramp`, `cv_bumpless`, `cv_positioner`, `cv_cycle_independence`, `cv_ma`, `cv_local_clamp`), их согласованность
проверяет `tools/project_checks/test_valve_reference.py`.

Из списка контракта (13, ★ 7 — все): ★ `ControlValve_ManualSetpoint_RateLimited` · ★
`ControlValve_OutputLimits_Clamp` · `ControlValve_Invert_20mAAtZero` ·
`ControlValve_TightShut_BelowThresholdGivesZero` · ★ `ControlValve_Deviation_WarningAfterDelay` ·
`ControlValve_DeviationDuringRamp_Ignored` · ★ `ControlValve_DeviationAsFault_GoesSafePosition` · ★
`ControlValve_Interlock_SafePosBypassesRamp` · `ControlValve_Local_TracksFeedback` · ★
`ControlValve_AutoToManual_Bumpless` · `ControlValve_FbInvalid_MaintenanceRequiredKeepsControl` ·
`ControlValve_PositionerFault_SafePosAction` · ★ `ControlValve_InvalidCfg_StartupSafePosition`

Сверх контракта (11): `ControlValve_OutOfService_HoldsOutput` · `ControlValve_AutoSpNaN_HoldsWithWarning` ·
`ControlValve_PositionerFault_HoldAction` · `ControlValve_OosEntry_ClearsLatchedDeviation` ·
`ControlValve_DefaultCfg_PassesCheck` · `ControlValve_CfgChecks_SetBits` ·
`ControlValve_InvalidCfgAtRuntime_KeepsLastValid` · `ControlValve_Ramp_IndependentOfCycleTime` ·
`ControlValve_LocalFeedbackOutOfRange_OutputClamped` ·
`ControlValve_DeviationFaultReset_StuckValveRetripsAfterTDev` · `ControlValve_InterlockInManual_StaysAtSafePosition`

Мутационная проверка (16.10.2026, по одной однострочной мутации на прогон `cds.py test`, затем откат).
Второй круг (после исправлений проверки, в копии рабочего дерева), четыре мутации: сразу пойман отказ
позиционера в OOS (`ControlValve_OutOfService_HoldsOutput`); выжили три, после добавленных тестов
пойманы все — задание Manual не следит при блокировке (`ControlValve_InterlockInManual_StaysAtSafePosition`),
предупреждение рассогласования и при `xDevIsFault`, Reset не перезапускает отсчёт `tDev` (оба —
`ControlValve_DeviationFaultReset_StuckValveRetripsAfterTDev`). Первый круг: все три мутации пойманы — положение безопасности по блокировке через рампу (три теста:
`ControlValve_Interlock_SafePosBypassesRamp`, `ControlValve_DeviationAsFault_GoesSafePosition`,
`ControlValve_PositionerFault_SafePosAction`), контроль рассогласования во время рампы
(`ControlValve_DeviationDuringRamp_Ignored`), плотное закрытие в состоянии рампы
(`ControlValve_TightShut_BelowThresholdGivesZero`).

Описания — в комментариях объявлений методов набора (`tests/POUs/Suites/FB_ControlValve_Test/`);
сводную таблицу в [TEST_REPORT.md](../TEST_REPORT.md) дополняет интегратор.
