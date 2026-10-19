# Стиль ST библиотеки

Правила кода — [CONTRIBUTING.md](../CONTRIBUTING.md): раскладка, именование, инженерные правила. Здесь
они расширены практикой этой библиотеки и показаны парами «так — не так»; примеры «так» взяты из
`src/` и `tests/`. Механические правила проверяют `tools/check/st_lint.py --strict` (STLxxx),
`tools/check/run_iec_checker.py --tests` и компилятор CODESYS (`cds.py build --tests`, `check --tests`);
остальное — ревью. Нормативный API — [API.md](API.md).

## 1. Файлы и заголовок POU

- Один объект CODESYS — один файл или папка раскладки ([LAYOUT.md](LAYOUT.md)), UTF-8 без BOM, LF,
  строка не длиннее 120 символов, без табуляции и хвостовых пробелов (STL002, STL003, STL009).
- В начале каждого POU — назначение, автор, версия, документ (STL001). Назначение — что делает и в каких
  режимах, а не пересказ имени.

**Так** (`src/POUs/Util/FB_StartsWindow/FB_StartsWindow.decl.st`):

```st
// Назначение: пуски за скользящий час (лимит пусков двигателя). Кольцо отметок LTIME,
//             упорядоченных по времени: самая старая — в начале, самая новая — в конце.
//             Отметки старше окна и «из будущего» (время назад) удаляются. Окно не
//             энергонезависимо: после перезапуска ПЛК оно пустое (A-03).
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/fb/FB_StartsWindow.md
FUNCTION_BLOCK FB_StartsWindow
```

**Не так:**

```st
// FB_StartsWindow
FUNCTION_BLOCK FB_StartsWindow
```

## 2. Имена

| Что | Правило | Так | Не так |
|---|---|---|---|
| POU, типы | `FB_`, `F_`, `PRG_`, `ST_`, `E_`, `U_`, `I_`, `GVL_` | `FB_LimitMonitor`, `E_AiSignalState`, `I_TimeSource` | `LimitMonitor`, `SignalState` |
| методы, свойства | PascalCase без префиксов и `_` | `CheckConfig`, `ReadyToStart` | `check_config`, `xReadyToStart` |
| переменные | префикс типа, затем заглавная буква | `xFbRun`, `uiCmdSeq`, `ltPrevCall`, `itfTimeAct`, `fbSysTime` | `fbRun : BOOL`, `seq`, `t1` |
| массивы | `a` + префикс типа элемента | `afbAlarm : ARRAY[…] OF FB_Alarm`, `astLimit`, `axAlmCond`, `aitfDev` | `alarms`, `aAlarmFb` |
| физические величины | единицы в имени | `rValue_eu`, `rSpeedRef_pct`, `rRampUp_pctps`, `udiOpTime_s`, `rOut_mA` | `rValue`, `rSpeed`, `rRamp` |
| константы | `VAR_GLOBAL CONSTANT` в `GVL_Const`, UPPER_SNAKE_CASE, блок своего устройства | `GVL_Const.MOT_WRN_STARTS_LIMIT`, `GVL_Const.AI_ALARM_COUNT` | `cMotWarnStarts`, `16#0008` в теле |
| параметры только для чтения | `VAR_IN_OUT CONSTANT` — префикс по типу, это не константа | `stCfg`, `stCfgIn`, `astCfg` | `ST_CFG` |

Ключевые слова МЭК 61131-3, которые CODESYS допускает как идентификаторы (`PRIORITY`, `INTERVAL`,
`SINGLE`, `TASK`, `ON`, `REF`, `NULL`…), именами членов и переменных не делаем: такой API непереносим
(F-17 в [ASSUMPTIONS.md](ASSUMPTIONS.md)).

**Так** (`src/Interfaces/I_Alarm/AlarmPriority.prop.decl.st`):

```st
PROPERTY AlarmPriority : E_AlarmPriority
```

**Не так:**

```st
PROPERTY Priority : E_AlarmPriority      // PRIORITY — параметр объявления TASK в МЭК 61131-3
```

## 3. Константы вместо «магических чисел»

В теле нет десятичных литералов, кроме 0, 1, 2 (STL008); маски — из `GVL_Const`, границы массивов —
через константы.

**Так** (`FB_DigitalInput`, первый вызов; объявление `FB_DeviceBase`):

```st
IF xFirstCall THEN
    uiAlarmCount := GVL_Const.DI_ALARM_COUNT;
    eDevType := E_DeviceType.DigitalInput;
END_IF
…
afbAlarm : ARRAY[0..GVL_Const.DEV_ALARMS_MAX - 1] OF FB_Alarm;   // слоты тревог
```

**Не так:**

```st
uiAlarmCount := 2;
afbAlarm : ARRAY[0..7] OF FB_Alarm;
```

Бит слова — маска из `GVL_Const` или сдвиг типизированного литерала:

```st
wErr := wErr OR GVL_Const.AI_CFG_RANGE;            // так
wBit := SHL(WORD#16#0001, uiSlot);                 // так: бит слота в масках
wErr := wErr OR 16#0002;                           // не так: что за бит?
```

## 4. Время

Время — только через `FB_Delay` и источник `I_TimeSource` (вход `itfTime`, в тестах — `FB_FakeTime`).
`TON`/`TOF`/`TP` и счёт циклов в библиотеке запрещены (контракт 0.3, STL011).

**Так** (`FB_DigitalInput`, подмена ограничена по времени):

```st
fbSubst(xIn := (eMode = E_DeviceMode.Manual) AND (stCfgLkg.tSubstMax > T#0S), tOnDelay := stCfgLkg.tSubstMax,
        itfTime := itfTimeAct);
```

**Не так:**

```st
iSubstCycles := iSubstCycles + 1;                  // 20 мс × N — время зависит от цикла задачи
IF iSubstCycles > 1500 THEN …
tonSubst(IN := xManual, PT := T#30S);              // TON не подменить в тесте
```

`LTIME` без знака: разность — только после проверки «время назад» (L7 контракта), иначе вместо
отрицательного числа будет огромное.

**Так** (`FB_DeviceBase.BeginCycle`):

```st
IF NOT xFirstCall AND ltNow >= ltPrevCall THEN
    ltDt := ltNow - ltPrevCall;
ELSE
    ltDt := LTIME#0S;
END_IF
```

**Не так:**

```st
ltDt := ltNow - ltPrevCall;                        // после SetNow назад — ≈ 584 года
```

Длительность в условии — неравенством: `tCommLoss <= T#0S`, а не `tCommLoss = T#0S` (PLCOPEN-CP28; для
`TIME` без знака — то же самое).

## 5. REAL: NaN, бесконечности, сравнения

Значения извне (вход AI, Modbus, задание ПИД, Cfg из SCADA) могут быть NaN или ±Inf. Проверки
записываются так, чтобы **NaN давал ошибку**: любое сравнение с NaN ложно.

**Так** (`FB_AnalogInput.CheckConfig`):

```st
IF NOT (F_IsFinite(rIn := stLim.rHyst_eu) AND stLim.rHyst_eu >= 0.0 AND stLim.rHyst_eu < rSpan) THEN
    wErr := wErr OR GVL_Const.AI_CFG_HYST;
END_IF
```

**Не так:**

```st
IF stLim.rHyst_eu < 0.0 OR stLim.rHyst_eu >= rSpan THEN   // NaN проходит обе проверки
    wErr := wErr OR GVL_Const.AI_CFG_HYST;
END_IF
```

REAL не сравниваем на равенство (PLCOPEN-CP8): «дошло до цели» — «ни меньше, ни больше» (так записано
условие «рампа завершена» в `FB_MotorVfd`, VFD-05).

```st
xRampDone := NOT (rSpeedRef_pct < rVfdTargetLim_pct OR rSpeedRef_pct > rVfdTargetLim_pct);   // так
xRampDone := rSpeedRef_pct = rVfdTargetLim_pct;                                             // не так
```

Неконечное значение не должно уйти на механизм и в интегратор: цель NaN — удержание прежней и
предупреждение (`F_RateLimit`, `FB_MotorVfd`, `FB_ControlValve`, `FB_PID`).

## 6. Устройства: структуры, порядок тела, `VAR_IN_OUT`

- Обмен с HMI и SCADA — только через `ST_<Dev>Cmd` / `ST_<Dev>Sts` / `ST_<Dev>Cfg`; импульсные биты
  команд сбрасывает ФБ; там, где значением управляет не оператор, ФБ пишет в Cmd текущее (слежение).
- Тело устройства — шаги нормативного порядка 9.4 контракта, с номером шага в комментарии (образец —
  `FB_DigitalInput.impl.st`). Логика после шага 2 читает только `stCfgLkg`, не `stCfg`.
- Методы не обращаются к `VAR_IN_OUT` экземпляра (предупреждение C0371 считаем ошибкой, R2): структура —
  параметром метода.

**Так:**

```st
IF AcceptCfg(wErr := CheckConfig(stCfgIn := stCfg)) THEN
    stCfgLkg := stCfg;
END_IF
```

**Не так** (метод `CheckConfig` читает `stCfg` экземпляра сам):

```st
METHOD PROTECTED CheckConfig : WORD
IF stCfg.rRangeLo_eu >= stCfg.rRangeHi_eu THEN …      // C0371
```

- Хук `OnModeChanged` наследника первым вызывает `SUPER^.OnModeChanged(eOld := eOld, eNew := eNew)`.
- Наследник с телом базы (`FB_MotorVfd`) вызывает его со всеми `VAR_IN_OUT`:
  `SUPER^(stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);` — `SUPER^();` даёт C0039.
- Шаги длинного тела выносятся в защищённые методы (`SelectOutput`, `DriveToTarget`): каждый — один
  шаг, данные — параметрами. Это деталь реализации, не API ([API.md, 22.4](API.md#224-srcpous)).

## 7. Перечисления и ветвления

DUT — с `{attribute 'qualified_only'}`, перечисления — со `{attribute 'strict'}`; сравнение — с
квалифицированным значением.

```st
IF eMode = E_DeviceMode.OutOfService THEN          // так
IF eMode = 4 THEN                                  // не так: число вместо значения перечисления
```

`IF` без `ELSE` допустим, если в этом вызове состояние сознательно не меняется (PLCOPEN-L17 обоснован
в [STATIC_ANALYSIS.md](STATIC_ANALYSIS.md)); пустая ветвь `ELSE` и заглушка `x := x;` — нет. iec_checker 0.4
не разбирает `NOT` в начале позиционного аргумента: `SEL(xPvOk, M, 0)`, а не `SEL(NOT xPvOk, 0, M)`.

## 8. Комментарии и строки

- Идентификаторы — ASCII, по-английски; комментарии — по-русски: **почему**, а не пересказ кода.
- Литералы `STRING` — только ASCII (в 3.5.17 `STRING` — Windows-1252, STL010); кириллица — `WSTRING`.
  Текстов тревог в ПЛК нет (A-11).
- Ссылка на решение — номер записи: `// безударно (M-09)`, `// AI-12: фильтр после провала`.

```st
// 3. Reset: фиксируемых отказов нет (отказ канала снимается сам), результат команды — Accepted;
//    квитирование выполнит RunAlarms                                         ← так: почему
SetCmdResult(eResult := E_CmdResult.Accepted);   // вызвать SetCmdResult      ← не так: пересказ
```

## 9. Тесты

Подробно — [TESTING.md](TESTING.md). Коротко:

- имя теста `<Fb>_<Case>_<Expectation>`, метод — то же без первого сегмента и `_`:
  `coUnit.TEST('Device_DefaultCfg_PassesCheck')` в методе `DefaultCfgPassesCheck`;
- время — `FB_FakeTime`, шаг перед вызовом, ассерт после цикла; ожидаемое значение — не ноль, если
  можно; эталоны — `tools/reference/*.py`;
- при неконечных входах — сначала `F_IsFinite`, потом значение: `AssertEquals_REAL` проходит при
  `Actual = NaN`.

```st
AssertTrue(Condition := F_IsFinite(rIn := fbCv.rOut_pct), Message := 'output finite');               // так
AssertEquals_REAL(Expected := 35.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'held on NaN');
```
