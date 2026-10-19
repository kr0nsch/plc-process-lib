# Как использовать plc-process-lib в своём проекте

Руководство для программиста приложения CODESYS 3.5: как поставить библиотеку, объявить и вызвать
устройства, подключить журнал тревог и связать устройства с HMI/SCADA. Точная семантика каждого поля —
контракт [API.md](API.md); входы, выходы, параметры, карты битов и регистров каждого ФБ — [docs/fb/](fb/).

1. [Установка](#1-установка)
2. [Что объявляет приложение](#2-что-объявляет-приложение)
3. [Правила вызова](#3-правила-вызова)
4. [Пример: контур уровня AI → ПИД → ПЧ](#4-пример-контур-уровня-ai--пид--пч)
5. [Задвижка и другие устройства](#5-задвижка-и-другие-устройства)
6. [Журнал тревог](#6-журнал-тревог)
7. [Связь с HMI/SCADA](#7-связь-с-hmiscada)
8. [Энергонезависимые данные](#8-энергонезависимые-данные)
9. [Частые ошибки](#9-частые-ошибки)
10. [Проект на шаблоне plc-repo-template](#10-проект-на-шаблоне-plc-repo-template)

## 1. Установка

### Из релиза

| Файл релиза [v1.0.0](https://github.com/kr0nsch/plc-process-lib/releases/tag/v1.0.0) | Размер | Что внутри |
|---|---|---|
| `plc-process-lib.compiled-library` | 249 КБ | скомпилированная библиотека без исходного текста — для приложений |
| `plc-process-lib.library` | 641 КБ | библиотека с исходным текстом: ФБ можно открыть в IDE и пройти отладчиком |

1. Скачать один из файлов со страницы релиза.
2. В CODESYS: «Инструменты → Репозиторий библиотек → Установить…» (Tools → Library Repository →
   Install) и выбрать файл. В репозитории появится `plc-process-lib, 1.0.0.0 (plc-portfolio)`.
3. В проекте приложения: «Менеджер библиотек → Добавить библиотеку» (Library Manager → Add Library),
   поиск `plc-process-lib`. Пространство имён — `PL`: `PL.FB_Motor`, `PL.ST_MotorCfg`,
   `PL.GVL_Const.MOT_STS_RUNNING`.

Библиотека зависит только от Standard. Проверена на CODESYS 3.5.17.30 (V3.5 SP17 Patch 3) с CODESYS
Control Win V3 (32 бит); другие версии CODESYS и ПЛК, в том числе ОВЕН ПЛК210, не проверялись.

### Собрать из исходников

Нужны Windows, CODESYS 3.5.17.30 и Python 3.11+:

```bat
python tools\codesys\cds.py library --compiled --install
```

Команда запускает CODESYS без окна, собирает `build\plc-process-lib.library` и `.compiled-library` из
`src/` (без `tests/` и служебной `PRG_Main`), проверяет все объекты пула и ставит библиотеку в репозиторий
`System`. Шаги в IDE без скрипта — [MANUAL_STEPS.md, раздел 7](MANUAL_STEPS.md#7-библиотека-library-compiled-library-установка-в-репозиторий-библиотек).

## 2. Что объявляет приложение

В библиотеке только ФБ, типы и константы: ни одной глобальной переменной с данными устройств и ни одной
`RETAIN`/`PERSISTENT`. Переменные, через которые устройство работает в проекте, объявляет приложение:

| Что | Тип | Где объявить | Кто пишет | Кто читает |
|---|---|---|---|---|
| экземпляр `fb<TAG>` | `PL.FB_<Dev>` | GVL приложения (`GVL_Devices`) или программа | — | логика станции; HMI читает `fb<TAG>.stSts` |
| команды `st<TAG>Cmd` | `PL.ST_<Dev>Cmd` | `GVL_Hmi` | HMI/SCADA; ФБ сбрасывает импульсы и пишет слежение | ФБ |
| параметры `st<TAG>Cfg` | `PL.ST_<Dev>Cfg` | `GVL_Persist` — объект Persistent Variables | начальные значения — в объявлении, дальше наладчик с HMI | ФБ (только чтение) |
| энергонезависимые данные `st<TAG>Retain` | `PL.ST_DeviceRetain` | `GVL_Persist` | только ФБ: режим, вывод из работы, наработка, число операций | ФБ, SCADA |
| состояние `stSts` | `PL.ST_<Dev>Sts` | выход экземпляра | ФБ | HMI/SCADA |

- `stRetain` есть у двигателей, арматуры и ПИД. У `FB_AnalogInput` и `FB_DigitalInput` его нет: после
  старта ПЛК они всегда в режиме «Измерение».
- Значения `ST_<Dev>Cfg` по умолчанию проходят проверку конфигурации (тест `Device_DefaultCfg_PassesCheck`):
  в инициализаторе достаточно задать поля, которые отличаются от умолчаний.
- Имена `GVL_Hmi`, `GVL_Persist`, `GVL_Devices`, `GVL_IO` — соглашение контракта (раздел 1), а не
  требование библиотеки. В проектах портфолио эти списки будет генерировать из перечня сигналов
  `iolistgen` (готовится); без генератора их пишут вручную, как в примере ниже.

## 3. Правила вызова

1. **Один экземпляр — один вызов за цикл, из одной задачи.** Методы `Reset()`, `AckAll()`,
   `RequestMode()` только ставят запрос; выполнит его ближайший вызов тела в той же задаче.
2. **В каждом вызове передаются все `VAR_IN_OUT`**: `stCmd`, `stCfg` и, если есть, `stRetain`. Без них
   компилятор 3.5.17 выдаёт ошибку C0039, даже если выше в том же POU они передавались.
3. **В `stCfg` передаётся переменная, а не литерал структуры** (`VAR_IN_OUT CONSTANT`, иначе C0032).
   Переменная из `VAR_GLOBAL CONSTANT` подходит.
4. **Входы автоматики — до вызова, выходы — после.** `xAutoRun`, `wInterlock`, `rSpeedSpAuto_pct` и т. п.
   присваиваются заранее или передаются в вызове; вход, не переданный в вызове, сохраняет последнее
   значение. `xQRun`, `xQOpen`, `rOut_mA` читаются после вызова.
5. **Публичны только `VAR_INPUT`, `VAR_OUTPUT`, методы и свойства.** К переменным секции `VAR`
   (`eState`, `stCfgLkg` и др.) приложение не обращается: компилятор это пропустит, но в API они не входят.
6. **Время передавать не нужно.** Без входа `itfTime` устройство берёт монотонное время `LTIME()`:
   задержки, фильтры и счётчики наработки считаются по времени, а не по числу циклов.

Полный список правил с номерами ошибок компилятора — [API.md, раздел 1](API.md#1-шаблон-вызова-и-потоки-данных).

## 4. Пример: контур уровня AI → ПИД → ПЧ

Уровнемер 4–20 мА (0–5 м) → ПИД уровня → насос с ПЧ: уровень выше задания — насос быстрее. Та же цепочка
работает в демо-приложении ([`FB_DemoLevelLoop`](../tools/demo/src/POUs/FB_DemoLevelLoop/FB_DemoLevelLoop.impl.st)),
которое прогонялось на установленной библиотеке 1.0.0.0 в CODESYS Control Win V3 — по его журналу построен
график «Контур уровня» в [README](../README.md#как-это-выглядит), — и в тесте `LevelLoop_AiPidVfd_TracksBumplessNoWindup`.
Ниже она записана так, как её пишут в приложении: команды в `GVL_Hmi`, параметры в Persistent Variables,
сигналы — из слоя ввода-вывода. Вызовы и их порядок те же, что в демо и тесте; объявления следуют
разделам 1 и 18.3 контракта. Отдельным проектом этот фрагмент в CODESYS не собирался.

**Команды HMI** — обычный список глобальных переменных:

```st
// GVL_Hmi
VAR_GLOBAL
    stLT101Cmd  : PL.ST_AnalogInputCmd;
    stLIC101Cmd : PL.ST_PidCmd;
    stP101Cmd   : PL.ST_MotorCmd;
END_VAR
```

**Параметры и энергонезависимые данные** — объект Persistent Variables («Application → Добавить объект →
Persistent Variables»; скриптом в 3.5.17 не создаётся, [MANUAL_STEPS.md, раздел 10](MANUAL_STEPS.md#10-моточасы-и-пуски-двигателей-persistent-variables-приложения)):

```st
// GVL_Persist
VAR_GLOBAL PERSISTENT RETAIN
    stLT101Cfg     : PL.ST_AnalogInputCfg := (rRangeHi_eu := 5.0, tFilter := T#2S, udiAlarmIdBase := 10);
    stLIC101Cfg    : PL.ST_PidCfg := (eAction := PL.E_PidAction.Direct, rKp := 12.0, rTi_s := 80.0,
                                      rPvMax_eu := 5.0, rSpMax_eu := 5.0, xUseOutAct := TRUE,
                                      udiAlarmIdBase := 20);
    stLIC101Retain : PL.ST_DeviceRetain;   // режим ПИД
    stP101Cfg      : PL.ST_MotorCfg := (stVfd := (rSpeedMin_pct := 20.0), udiAlarmIdBase := 30);
    stP101Retain   : PL.ST_DeviceRetain;   // режим, моточасы, пуски насоса
END_VAR
```

**Экземпляры:**

```st
// GVL_Devices
VAR_GLOBAL
    fbLT101  : PL.FB_AnalogInput;   // уровнемер
    fbLIC101 : PL.FB_PID;           // регулятор уровня
    fbP101   : PL.FB_MotorVfd;      // насос с ПЧ
END_VAR
```

**Вызов** — программа в задаче с циклом, например, 10 мс. `GVL_IO` — ваш слой ввода-вывода (каналы модулей
или переменные драйвера Modbus), имена в нём условные; `FB_Journal` — журнал тревог из [раздела 6](#6-журнал-тревог).

```st
PROGRAM PRG_Devices
VAR
    fbJournal   : FB_Journal;   // журнал тревог приложения
    xPumpDemand : BOOL;         // запрос работы насоса от логики станции
    xLeadAuto   : BOOL;         // насос в Auto и работает: ПИД не следит
    rLeadRef    : REAL;         // задание ПЧ прошлого цикла, %
END_VAR

PL.GVL_Lib.itfAlarmSink := fbJournal;      // каждый цикл, до вызова устройств

// уровнемер
GVL_Devices.fbLT101(rIn := GVL_IO.rLT101_mA, xChannelFault := GVL_IO.xAI1_ModuleFault,
                    stCmd := GVL_Hmi.stLT101Cmd, stCfg := GVL_Persist.stLT101Cfg);

// ПИД: пока насос не в Auto-работе, регулятор следит за заданием ПЧ — пуск и смена режима без рывка
xLeadAuto := GVL_Devices.fbP101.SpeedAutoActive;
rLeadRef  := GVL_Devices.fbP101.SpeedRef;
GVL_Devices.fbLIC101(rPv_eu := GVL_Devices.fbLT101.rValue_eu, xPvValid := GVL_Devices.fbLT101.xValid,
                     xTrack := NOT xLeadAuto, rTrack_pct := rLeadRef, rOutAct_pct := rLeadRef,
                     stCmd := GVL_Hmi.stLIC101Cmd, stCfg := GVL_Persist.stLIC101Cfg,
                     stRetain := GVL_Persist.stLIC101Retain);

// насос: запрос и задание — до вызова, сигналы ПЧ — в вызове, выходы — после
GVL_Devices.fbP101.xAutoRun         := xPumpDemand;
GVL_Devices.fbP101.rSpeedSpAuto_pct := GVL_Devices.fbLIC101.rOut_pct;
GVL_Devices.fbP101(xPowerOk := GVL_IO.xPowerOk, xCommOk := GVL_IO.xP101_CommOk,
                   xVfdRunning := GVL_IO.xP101_VfdRun, xVfdReady := GVL_IO.xP101_VfdReady,
                   xVfdFault := GVL_IO.xP101_VfdFault, rSpeedAct_pct := GVL_IO.rP101_SpeedAct_pct,
                   stCmd := GVL_Hmi.stP101Cmd, stCfg := GVL_Persist.stP101Cfg,
                   stRetain := GVL_Persist.stP101Retain);
GVL_IO.xP101_QRun         := GVL_Devices.fbP101.xQRun;           // команда «работа» на ПЧ
GVL_IO.rP101_SpeedRef_pct := GVL_Devices.fbP101.rSpeedRef_pct;   // задание на ПЧ, %
```

Что происходит после загрузки:

- уровнемер сразу в режиме «Измерение»; при 12 мА `fbLT101.rValue_eu` = 2,5 м, `stSts.stCommon.eNe107` =
  `Good`. Обрыв линии (ток ≤ 3,6 мА) подтверждается через `tFailDelay` (2 с): `xValid` = FALSE, статус
  `Failure`, значение удерживается;
- ПИД и насос после первой загрузки — в Manual (умолчание `ST_DeviceRetain`). Оператор переводит их в Auto
  командой `stCommon.xSetAuto`, режим запоминается в `stRetain` и переживает перезагрузку;
- в Auto насос пускается по `xPumpDemand`, ПИД снимает слежение без скачка задания ПЧ.

Ведущий насос, который меняется при чередовании, подключается через интерфейс `PL.I_MotorVfd` —
[FB_PID.md, «Пример вызова»](fb/FB_PID.md#пример-вызова).

## 5. Задвижка и другие устройства

**Задвижка с электроприводом** (`FB_Valve`; параметры в `GVL_Persist`, например
`stXV101Cfg : PL.ST_ValveCfg := (tTravel := T#90S, udiAlarmIdBase := 40);`):

```st
GVL_Devices.fbXV101.xAutoOpen    := xPumpRunning;              // запрос автоматики: TRUE — открыть, FALSE — закрыть
GVL_Devices.fbXV101.wInterlock.0 := GVL_Devices.fbLT101.xLL;   // блокировка: вести в eSafePos (по умолчанию — закрыть);
                                                               // уставка LL включается в stLT101Cfg.astLimit
GVL_Devices.fbXV101(xZso := GVL_IO.xXV101_Zso, xZsc := GVL_IO.xXV101_Zsc, xExtFault := GVL_IO.xXV101_Fault,
                    xLocal := GVL_IO.xXV101_Local, xPowerOk := GVL_IO.xPowerOk,
                    stCmd := GVL_Hmi.stXV101Cmd, stCfg := GVL_Persist.stXV101Cfg,
                    stRetain := GVL_Persist.stXV101Retain);
GVL_IO.xXV101_QOpen  := GVL_Devices.fbXV101.xQOpen;
GVL_IO.xXV101_QClose := GVL_Devices.fbXV101.xQClose;
```

Остальные устройства подключаются так же. Готовые фрагменты — в разделах «Пример вызова» документов ФБ:

| Устройство | Пример | На что обратить внимание |
|---|---|---|
| `FB_Motor` — прямой пуск, УПП | [FB_Motor.md](fb/FB_Motor.md#пример-вызова) | по умолчанию ОС «в работе» обязательна (`xFbUsed = TRUE`): без `xFbRun` через `tFbStart` (5 с) — отказ FailToStart |
| `FB_MotorVfd` — насос, вентилятор с ПЧ | [FB_MotorVfd.md](fb/FB_MotorVfd.md#пример-вызова) | ОС по умолчанию — из слова состояния ПЧ (`xVfdRunning`); адаптер Modbus конкретного ПЧ — код приложения |
| `FB_DigitalInput` — поплавок, реле давления | [FB_DigitalInput.md](fb/FB_DigitalInput.md#пример-вызова) | инверсия, задержки и значение при отказе канала задаются в Cfg |
| `FB_ControlValve` — регулирующий клапан | [FB_ControlValve.md](fb/FB_ControlValve.md#пример-вызова) | ОС положения — от `FB_AnalogInput`; ПИД следит за клапаном, пока тот не исполняет его задание |
| `FB_PID` с ведущим насосом | [FB_PID.md](fb/FB_PID.md#пример-вызова) | слежение и обратный расчёт по фактическому заданию ПЧ |
| `FB_Alarm` отдельно от устройств | [FB_Alarm.md](fb/FB_Alarm.md#пример) | станционные тревоги («нет резерва насосов»), номера — от 100 000 |

## 6. Журнал тревог

В каждом устройстве до восьми тревог ISA-18.2 (`FB_Alarm`). Каждый переход состояния тревоги отправляется
событием `PL.ST_AlarmEvent` в приёмник `PL.GVL_Lib.itfAlarmSink`. Журнала в библиотеке нет — приёмник пишет
приложение:

- ФБ приложения реализует интерфейс `PL.I_AlarmSink` с одним методом `OnAlarmEvent`;
- `PL.GVL_Lib.itfAlarmSink := fbJournal;` присваивается **каждый цикл** до вызова устройств: так ссылка
  остаётся верной после онлайн-изменения;
- без приёмника (`itfAlarmSink = 0`) события не отправляются, но состояние тревог по-прежнему видно в
  `stSts` устройств (`wAlmActive`, `wAlmUnack`, `wAlmShelved`, `ePrioUnack`).

Минимальный приёмник — кольцо событий. Заготовка повторяет тестовый приёмник библиотеки
[`FB_TestSink`](../tests/POUs/Helpers/FB_TestSink/OnAlarmEvent.method.impl.st); как ФБ приложения с префиксом
`PL.` в CODESYS не собиралась:

```st
FUNCTION_BLOCK FB_Journal IMPLEMENTS PL.I_AlarmSink
VAR CONSTANT
    EVENTS_MAX : UINT := 100;                                  // ёмкость кольца
END_VAR
VAR
    astEvent : ARRAY[0..EVENTS_MAX - 1] OF PL.ST_AlarmEvent;   // кольцо событий
    uiNext   : UINT;                                           // индекс следующей записи
END_VAR

// метод — отдельный объект ФБ (Добавить объект → Метод)
METHOD OnAlarmEvent : BOOL
VAR_IN_OUT CONSTANT
    stEvent : PL.ST_AlarmEvent;
END_VAR
astEvent[uiNext] := stEvent;            // здесь же — астрономическое время (SysTimeRtc) и запись в архив
uiNext := (uiNext + 1) MOD EVENTS_MAX;
OnAlarmEvent := TRUE;                   // FALSE — журнал переполнен; FB_Alarm событие не повторяет
```

| Поле `ST_AlarmEvent` | Смысл |
|---|---|
| `udiId` | номер тревоги на объекте: `stCfg.udiAlarmIdBase` + номер слота |
| `ePriority` | приоритет из `stCfg.astAlarm[слот]` |
| `eOldState`, `eNewState` | состояние ISA-18.2 до и после перехода (`E_AlarmState`) |
| `eReason` | причина перехода (`E_AlarmEventReason`), в том числе `Disabled` — тревога выключена приоритетом None |
| `ltTime` | монотонная отметка времени; астрономическое время ставит приёмник |
| `rValue` | значение процесса в момент события (конечное: NaN и ±Inf заменяются на 0.0) |

## 7. Связь с HMI/SCADA

### 7.1 Куда привязывать

- **Команды** HMI/SCADA пишет в `GVL_Hmi.st<TAG>Cmd`. Путь `fb<TAG>.stCmd` снаружи недоступен:
  это `VAR_IN_OUT`, обращение даёт ошибку C0178.
- **Состояние** читается из `fb<TAG>.stSts` (`VAR_OUTPUT`). WebVisu обращается к переменным напрямую; для
  OPC UA `GVL_Hmi` и экземпляры устройств добавляются в символьную конфигурацию приложения.
- WebVisu и SCADA равноправны: «место управления» (пульт или диспетчерская) в v1.0 не реализовано.

### 7.2 Поля команд

| Вид | Поля | Как работает |
|---|---|---|
| импульс | `stCommon`: `xSetAuto`, `xSetManual`, `xSetOos`, `xReset`, `xAck`; двигатель: `xStart`, `xStop`, `xResetMaint`; задвижка: `xOpen`, `xClose`, `xStop`, `xResetMaint` | HMI пишет TRUE, ближайший вызов ФБ выполняет команду и сам сбрасывает бит в FALSE. HMI бит не сбрасывает |
| маска | `stCommon`: `wAckReq`, `wShelveReq`, `wUnshelveReq` | бит i относится к слоту тревоги i; ФБ обнуляет слово после обработки |
| значение | `rSpeedSp_pct` (ПЧ), `rPosSpMan_pct` (клапан), `rSp_eu` и `rManualOut_pct` (ПИД), `rSubstValue_eu` (AI), `xSubstValue` (DI) | ФБ не сбрасывает. Пока значением управляет не оператор (Auto, Local, вывод из работы, слежение), ФБ каждый цикл пишет в поле текущее значение: поле ввода на HMI показывает актуальное значение, переход в Manual проходит без рывка |

Порядок обработки в одном вызове: `xReset` → `xAck` → режим (OutOfService > Manual > Auto) → команды
устройства (`xStop` важнее `xStart`; у арматуры `xClose` > `xOpen` > `xStop`) → маски тревог.
`xReset` сбрасывает зафиксированные отказы и квитирует все тревоги; `xAck` только квитирует.

### 7.3 Ответ на команду

Каждая обработанная команда записывает результат в `stSts.stCommon.eCmdResult` и увеличивает
`stSts.stCommon.uiCmdSeq` на 1 (UINT, по кругу). HMI запоминает `uiCmdSeq`, пишет импульс, ждёт изменения
`uiCmdSeq` и показывает `eCmdResult`. Если команд в вызове несколько, `uiCmdSeq` растёт на их число, а
`eCmdResult` — результат последней.

| `E_CmdResult` | Значение | Когда |
|---|---|---|
| `None` | 0 | команд ещё не было |
| `Accepted` | 1 | команда принята |
| `RejectedMode` | 2 | недопустимо в текущем режиме: пуск в Auto, команды в Local или OutOfService |
| `RejectedInterlock` | 3 | действует защитная блокировка |
| `RejectedPermit` | 4 | нет разрешения, в том числе ПЧ не готов |
| `RejectedInhibit` | 5 | пауза после останова, лимит пусков, нет напряжения |
| `RejectedFault` | 6 | есть отказ; Reset при неснятой причине; PV негодна (ПИД) |
| `RejectedState` | 7 | недопустимо в текущем состоянии: вывод из работы при работающем механизме |
| `RejectedNotSupported` | 8 | не поддерживается типом: стоп соленоида, Local у AI |
| `RejectedCfg` | 9 | нет корректной конфигурации |
| `SubstExpired` | 10 | AI/DI: подмена снята по `tSubstMax` (событие, а не ответ на команду) |

### 7.4 Состояние: общий заголовок и карта регистров

Каждая `ST_<Dev>Sts` начинается общим заголовком `stCommon : ST_DeviceSts` — 14 полей по 16 бит, 28 байт,
14 регистров Modbus. Один фейсплейт SCADA для заголовка подходит ко всем типам устройств; поле `eDevType`
говорит, какой тип лежит по адресу.

| Регистр | Поле | Содержимое |
|---|---|---|
| 0 | `wStatus` | биты 0–7 — по типу устройства, 8–15 — общие (таблица ниже) |
| 1 | `wFault` | причины отказа (карта по типу) |
| 2 | `wWarning` | предупреждения (карта по типу) |
| 3 | `wCfgErr` | непройденные проверки конфигурации (карта по типу) |
| 4 | `eMode` | режим: Auto = 1, Manual = 2, Local = 3, OutOfService = 4 |
| 5 | `eNe107` | статус NAMUR NE 107: Good = 0, M = 1, S = 2, C = 3, F = 4 |
| 6 | `eCmdResult` | результат последней команды (7.3) |
| 7 | `uiCmdSeq` | счётчик обработанных команд |
| 8 | `wAlmActive` | бит i — условие тревоги слота i активно |
| 9 | `wAlmUnack` | бит i — тревога слота i не квитирована |
| 10 | `wAlmShelved` | бит i — слот отложен оператором (shelve) |
| 11 | `ePrioUnack` | наивысший приоритет среди неквитированных |
| 12 | `eDevType` | AnalogInput = 1, DigitalInput = 2, Motor = 3, MotorVfd = 4, Valve = 5, ControlValve = 6, Pid = 7 |
| 13 | `wAlmSuppressed` | бит i — слот подавлен логикой (suppressed by design) |

Старший байт `wStatus` одинаков у всех устройств; маски — в `PL.GVL_Const`:

| Бит | Константа | 1 означает |
|---|---|---|
| 8 | `DEV_STS_MODE_AUTO` | режим Auto (AI/DI — измерение) |
| 9 | `DEV_STS_MODE_MANUAL` | режим Manual (AI/DI — подмена) |
| 10 | `DEV_STS_MODE_LOCAL` | режим Local |
| 11 | `DEV_STS_MODE_OOS` | выведено из работы |
| 12 | `DEV_STS_CFG_ERROR` | конфигурация не прошла проверку или корректной ещё не было |
| 13 | `DEV_STS_FAILURE` | `eNe107 = Failure` |
| 14 | `DEV_STS_WARNING` | есть предупреждение или `eNe107` = S, M |
| 15 | `DEV_STS_ALARM_UNACK` | есть неквитированные тревоги |

За заголовком идут поля типа. Структуры состоят только из 16- и 32-битных полей без скрытого выравнивания,
поэтому регистр `n` блока — это байты `2n…2n+1` структуры. Размеры сверяет тест
`Common_SizeOfSts_MatchesRegisterMap`:

| Структура | Байт | Регистров | Поля и биты младшего байта |
|---|---|---|---|
| `ST_AnalogInputSts` | 44 | 22 | [FB_AnalogInput.md](fb/FB_AnalogInput.md#раскладка-st_analoginputsts-карта-регистров) |
| `ST_DigitalInputSts` | 30 | 15 | [FB_DigitalInput.md](fb/FB_DigitalInput.md#раскладка-st_digitalinputsts-карта-регистров) |
| `ST_MotorSts` (и `FB_MotorVfd`) | 68 | 34 | [FB_Motor.md](fb/FB_Motor.md#раскладка-st_motorsts-карта-регистров), биты ПЧ — [FB_MotorVfd.md](fb/FB_MotorVfd.md#карта-битов-пч) |
| `ST_ValveSts` | 52 | 26 | [FB_Valve.md](fb/FB_Valve.md#раскладка-st_valvests-карта-регистров) |
| `ST_ControlValveSts` | 52 | 26 | [FB_ControlValve.md](fb/FB_ControlValve.md#раскладка-st_controlvalvests-карта-регистров) |
| `ST_PidSts` | 64 | 32 | [FB_PID.md](fb/FB_PID.md#раскладка-st_pidsts-карта-регистров) |

### 7.5 Modbus: ПЛК — slave для SCADA

- **Состояние.** Блок устройства — `stSts` целиком, первым идёт заголовок. Как копировать `stSts` в образ
  регистров slave и в каком порядке слов передавать 32-битные поля (`REAL`, `UDINT`), решает приложение и
  записывает в карту обмена: библиотека этого не задаёт, с конфигуратором Modbus Slave 3.5.17 это не
  проверялось ([API.md, «Осталось открытым»](API.md#осталось-открытым), O5).
- **Команды — только через адаптер.** Holding-регистр, записанный мастером, ПЛК сбросить не может: если
  отобразить `ST_<Dev>Cmd` на регистры напрямую, импульс выполнялся бы каждый цикл (к тому же в Cmd есть
  `BOOL`, и её раскладка — не карта регистров). Адаптер приложения превращает бит слова команд в импульс
  `stCmd` по фронту, один раз. Значения (`rSpeedSp_pct` и др.) переносите тоже по изменению регистра, а не
  каждый цикл, иначе мастер затрёт слежение ФБ.

Набросок адаптера для приложения (в библиотеку и тесты не входит, в CODESYS не собирался):

```st
// wP101CmdWord — holding-регистр от мастера: бит 0 — пуск, бит 1 — стоп, бит 2 — сброс (раскладка — ваша карта обмена)
fbP101Start(CLK := wP101CmdWord.0);     // fbP101Start, fbP101Stop, fbP101Reset : R_TRIG (библиотека Standard)
fbP101Stop(CLK := wP101CmdWord.1);
fbP101Reset(CLK := wP101CmdWord.2);
IF fbP101Start.Q THEN GVL_Hmi.stP101Cmd.xStart := TRUE; END_IF
IF fbP101Stop.Q THEN GVL_Hmi.stP101Cmd.xStop := TRUE; END_IF
IF fbP101Reset.Q THEN GVL_Hmi.stP101Cmd.stCommon.xReset := TRUE; END_IF
// дальше в том же цикле — вызов GVL_Devices.fbP101(...): он выполнит команды и сбросит импульсы
```

### 7.6 Тексты тревог

В ПЛК тревога — только числа: `udiId = udiAlarmIdBase + слот`, код — ASCII `<TAG>.<SUFFIX>` (`P101.FTS`,
`LT101.HH`). Русских строк в библиотеке нет: в CODESYS 3.5.17 `STRING` — Windows-1252, кириллица в нём не
представима. Тексты для HMI и SCADA — в [`docs/alarm_templates.csv`](alarm_templates.csv): UTF-8,
разделитель `;`, столбцы `type;slot;suffix;text_ru;operator_action;cause;consequence`, 28 строк — по
строке на каждый используемый слот. Состав файла сверяет `tools/project_checks/test_alarm_templates.py`.

| Тип | Слоты 0…7 (суффиксы) |
|---|---|
| AnalogInput | `HH`, `H`, `L`, `LL`, `FAIL`, `OOR` |
| DigitalInput | `ALM`, `FAIL` |
| Motor / MotorVfd | `FTS`, `FBL`, `FTP`, `UCR`, `EXT`, `ILK`; у MotorVfd ещё `COM`, `SPD` |
| Valve | `FTO`, `FTC`, `BLS`, `PLS`, `TRQ`, `EXT`, `ILK` |
| ControlValve | `DEV`, `FBF`, `POS`, `ILK` |
| PID | `PVF` |

Причины блокировок и разрешений мнемосхема берёт из активных битов `stSts.wInterlock` / `wPermitMissing` и
первопричины `uiFirstOut` ([API.md, раздел 19](API.md#19-тексты-тревог-и-причин)).

## 8. Энергонезависимые данные

- `st<TAG>Cfg` и `st<TAG>Retain` лежат в объекте **Persistent Variables** приложения — по переменной на
  устройство. Тогда уставки, режимы, моточасы и пуски переживают пропадание питания, «Сброс холодный» и
  загрузку программы. Объект создаётся вручную: [MANUAL_STEPS.md, раздел 10](MANUAL_STEPS.md#10-моточасы-и-пуски-двигателей-persistent-variables-приложения).
- Новое устройство — новые переменные **в конец** списка. Команду «Reorder List and Clear Gaps» не
  выполнять: она сбрасывает все persistent-данные.
- Изменённый инициализатор в объявлении не попадёт в контроллер после загрузки: сохранённые значения
  важнее начальных. Применить уставки проекта — отдельной командой приложения (контракт, 18.3, правило 2).
- Типы `ST_<Dev>Cfg` и `ST_DeviceRetain` заморожены в пределах версий 1.x: обновление библиотеки внутри 1.x
  persistent-данные не сбрасывает. Изменение этих типов — только в 2.0, с переносом значений рецептом.
- Поведение persistent-данных на Control Win V3 и ПЛК210 тестами не проверялось — пройдите шаги 3–5
  раздела 10 MANUAL_STEPS вручную.

## 9. Частые ошибки

| Симптом | Причина | Что сделать |
|---|---|---|
| ошибка C0039 в вызове устройства | переданы не все `VAR_IN_OUT` | передавать `stCmd`, `stCfg`, `stRetain` в каждом вызове |
| ошибка C0032 | в `stCfg` передан литерал структуры | объявить переменную Cfg и передать её |
| ошибка C0178 у `fbP101.stCmd.xStart` в HMI | `VAR_IN_OUT` снаружи недоступен | привязать HMI к `GVL_Hmi.stP101Cmd` |
| предупреждение C0244 «Приложение не содержит VAR_PERSISTENT-списка» | `VAR_GLOBAL PERSISTENT RETAIN` объявлен в обычной GVL | создать объект Persistent Variables (раздел 8) |
| команда по Modbus выполняется каждый цикл | Cmd отображена на holding-регистры напрямую | адаптер по фронту (7.5) |
| устройство в CheckFunction, пуск отклоняется с `RejectedCfg` | конфигурация не проходит проверку | расшифровать `wCfgErr` по карте битов в `docs/fb/FB_<Dev>.md` |
| двигатель уходит в отказ FailToStart через 5 с после пуска | ОС «в работе» не подключена, а `xFbUsed = TRUE` по умолчанию | подключить `xFbRun` или задать `xFbUsed := FALSE` в Cfg |
| моточасы обнуляются после загрузки программы | `stRetain` не в Persistent Variables | раздел 8 |
| после онлайн-изменения в журнал не приходят события | `itfAlarmSink` присвоен один раз при старте | присваивать каждый цикл (раздел 6) |
| двигатели и ПИД после первой загрузки в Manual | так задано умолчание `ST_DeviceRetain.eRemoteMode` | перевести в Auto командой `xSetAuto` (режим запомнится) или задать `(eRemoteMode := PL.E_DeviceMode.Auto)` в инициализаторе Retain |

## 10. Проект на шаблоне plc-repo-template

Если ваш репозиторий собран на шаблоне [plc-repo-template](https://github.com/kr0nsch/plc-repo-template)
(сборка `tools/codesys/cds.py` из текстов ST), библиотеку подключает запись в `tools/codesys/config.json` и
ссылка на неё в `library.libraries` или `modes.<режим>.libraries`. Так подключена библиотека в
[sis-interlock-demo](https://github.com/kr0nsch/sis-interlock-demo):

```json
"libraries": {
  "plc-process-lib": {
    "namespace": "PL",
    "title": "plc-process-lib",
    "company": "plc-portfolio",
    "version": "1.0.0.0",
    "build_from_repo": {"env": "PL_REPO", "default": "../plc-process-lib"}
  }
}
```

Если этой версии нет в репозитории библиотек, `cds.py` сам соберёт и поставит её командой `library
--install` в соседнем репозитории (`build_from_repo`: переменная `PL_REPO` или `../plc-process-lib`).
`"version": "*"` берёт наибольшую из установленных версий — для разработки в соседних репозиториях; в проектах для объекта версию закрепляют. Подробно —
[tools/README.md](../tools/README.md#библиотеки-library-и-deps).
