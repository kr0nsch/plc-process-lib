# FB_FakeTime — подменяемое время для тестов

`FB_FakeTime IMPLEMENTS I_TimeSource`: время меняется только вызовами методов, поэтому тесты
таймингов детерминированы и не ждут реального времени. Лежит в библиотеке, а не в `tests/`: им
пользуются тесты проектов-потребителей (02 — сценарии АВР и чередования, 10 — ПАЗ-демо).

Исходник: `src/POUs/Time/FB_FakeTime/`. Контракт: раздел 7.3.

| Метод | Сигнатура | Действие |
|---|---|---|
| `Now` | `Now : LTIME` | текущее подменное время |
| `SetNow` | `SetNow(ltValue : LTIME)` | установить время; назад — можно, ФБ библиотеки это переживают |
| `Advance` | `Advance(tStep : TIME)` | продвинуть на шаг `TIME` |
| `AdvanceL` | `AdvanceL(ltStep : LTIME)` | продвинуть на шаг `LTIME`: меньше 1 мс и больше 49 сут |

Старт — `LTIME#1H`, а не 0: так ловится код, который считает «0 = не инициализировано».

## Пример (тест)

```st
fbTime : PL.FB_FakeTime;   // VAR метода-теста
...
fbP101(itfTime := fbTime, xAutoRun := TRUE, stCmd := stCmd, stCfg := stCfg, stRetain := stRetain);
FOR iStep := 1 TO 50 DO
    fbTime.Advance(tStep := T#100MS);
    fbP101(itfTime := fbTime, xAutoRun := TRUE, stCmd := stCmd, stCfg := stCfg, stRetain := stRetain);
END_FOR
```

Правила тестов со временем — [TESTING.md](../TESTING.md), раздел «Время».

## Тесты (`FB_Time_Test`)

`Time_FakeTime_StartsAtOneHour`, `Time_FakeTime_Advance_AddsStep`, `Time_FakeTime_SetNow_SetsValue`,
`Time_FakeTime_AdvanceL_SubMsAndLongSteps`, `Time_FakeTime_ViaInterface_ReturnsSameTime`.
