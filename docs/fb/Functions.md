# Функции библиотеки

Функции без состояния (`src/POUs/Util/`). Контракт: раздел 8.1. Из приложения — с префиксом `PL.`.

| Функция | Объявление | Поведение |
|---|---|---|
| `F_LTimeToSec` | `F_LTimeToSec(ltIn : LTIME) : LREAL` | `ULINT_TO_LREAL(LTIME_TO_ULINT(ltIn)) / NS_PER_S`. LTIME без знака: разность отметок вызывающий считает только при `a >= b` |
| `F_TimeToSec` | `F_TimeToSec(tIn : TIME) : LREAL` | `TIME_TO_LREAL(tIn) / MS_PER_S` (32-битное число мс в LREAL — точно) |
| `F_IsFinite` | `F_IsFinite(rIn : REAL) : BOOL` | `FALSE` для NaN и ±Inf (все биты экспоненты = 1, проверка по битам через `U_RealBits` и `REAL_EXP_MASK`) и для `ABS(rIn) > REAL_SANE_MAX` (1e30: мусор, например перепутан порядок слов Modbus) |
| `F_Ne107Worst` | `F_Ne107Worst(eA, eB : E_Ne107Status) : E_Ne107Status` | `MAX(eA, eB)`: значения NE 107 упорядочены по тяжести Good < M < S < C < F |
| `F_RateLimit` | `F_RateLimit(rCurrent, rTarget, rRateUp_ups, rRateDown_ups : REAL; lrDt_s : LREAL) : REAL` | шаг ограничителя скорости: рост не быстрее `rRateUp_ups`, спад — `rRateDown_ups` ед./с; скорость <= 0 — без ограничения; `lrDt_s <= 0` или цель не конечна — `rCurrent` |
| `F_RateLimitLr` | `F_RateLimitLr(lrCurrent : LREAL; rTarget, rRateUp_ups, rRateDown_ups : REAL; lrDt_s : LREAL) : LREAL` | то же, но текущее значение и результат — LREAL: состояние рампы не округляется до REAL на каждом шаге (CV-14, VFD-13) |

## Подробности

- **`F_IsFinite`** не сравнивает `r = r` (результат такой проверки NaN зависит от оптимизатора).
  Граница `REAL_SANE_MAX` включительно: `F_IsFinite(1.0E30) = TRUE`. Денормализованные числа и `-0.0`
  конечны.
- **`F_RateLimit`** считает шаг в LREAL. Если до цели меньше шага, результат — ровно цель, без
  перелёта. Текущее значение NaN заменяется целью (ограничитель «оживает» после мусора). «Up» —
  рост значения, а не направление движения механизма.
- **`F_RateLimitLr`** — для рамп с состоянием в экземпляре (`FB_ControlValve`, `FB_MotorVfd`). В REAL приращение
  медленной рампы при коротком цикле теряется: 0,003 %/с при цикле 1 мс рядом с 70 % — 3·10⁻⁶ % за шаг, меньше
  половины шага REAL (7,6·10⁻⁶ %), и рампа стоит; 0,005 %/с — идёт в полтора раза быстрее заданной. Состояние в
  LREAL эти приращения сохраняет; цель и скорости остаются REAL (входы и Cfg устройств).
- **`F_TimeToSec`**: контракт описывает `UDINT_TO_LREAL(TIME_TO_UDINT(tIn))`; реализация —
  `TIME_TO_LREAL(tIn)` с тем же результатом (F-06 в [ASSUMPTIONS.md](../ASSUMPTIONS.md)).

## Пример

```st
lrDt_s := PL.F_LTimeToSec(ltIn := ltDt);
rSpeedRef_pct := PL.F_RateLimit(rCurrent := rSpeedRef_pct, rTarget := rTarget_pct,
                                rRateUp_ups := 10.0, rRateDown_ups := 5.0, lrDt_s := lrDt_s);
IF NOT PL.F_IsFinite(rIn := rFromModbus) THEN
    xInvalid := TRUE;
END_IF
```

## Тесты

`FB_Time_Test`: `Time_LTimeToSec_OneSecond_ReturnsOne`, `Time_LTimeToSec_NanosecondAndDays_Exact`,
`Time_TimeToSec_1500ms_Returns1p5`, `Time_TimeToSec_MaxTime_NoOverflow`.
`FB_Util_Test`: `Util_IsFinite_NaN_ReturnsFalse`, `Util_IsFinite_Inf_ReturnsFalse`,
`Util_IsFinite_Normal_ReturnsTrue`, `Util_IsFinite_AboveSaneMax_ReturnsFalse`,
`Util_Ne107Worst_ReturnsMostSevere`, `Util_RateLimit_UpAndDownRatesSeparate`,
`Util_RateLimit_ZeroRate_Jumps`, `Util_RateLimit_ZeroDt_NoChange`,
`Util_RateLimit_NonFiniteTarget_HoldsCurrent`, `Util_RateLimit_SmallStep_ReachesTargetExactly`,
`Util_RateLimitLr_SmallStep_NotLost`, `Util_RateLimitLr_NonFiniteTargetOrZeroDt_HoldsCurrent`.
Эталоны — `tools/reference/common.py`, сценарии `rate_limit` и `ltime_to_sec`.
