// Norm420: rIn 0..1 = 4..20 мА. 0,5 даёт то же, что 12 мА на соседнем экземпляре (7,0 на шкале 2..12); NE 43 — по
// пересчёту I = 4 + 16·rIn: -0,05 (3,2 мА) — FailLow, 1,0625 (21 мА) — FailHigh. источник:
// tools/reference/ai_reference.py, сценарий scale «Norm420 0,5, шкала 2..12».
METHOD PRIVATE Norm420ScalesLikeMilliamps
VAR
    fbTime  : FB_FakeTime;         // подменное время
    fbAi    : FB_AnalogInput;      // ФБ под тестом
    fbMa    : FB_AnalogInput;      // тот же вход в мА
    stCmd   : ST_AnalogInputCmd;   // команды
    stCmdMa : ST_AnalogInputCmd;   // команды экземпляра в мА
    stCfg   : ST_AnalogInputCfg;   // конфигурация
    stCfgMa : ST_AnalogInputCfg;   // конфигурация экземпляра в мА
END_VAR
