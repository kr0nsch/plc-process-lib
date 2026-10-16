// Отсечка 5 % после корня: 0,2 % перепада (корень 4,47 %) — 0 и бит AI_STS_LOW_CUT; 1 % перепада (корень 10 %) —
// 9,999995 без бита. Без корня отсечка тоже действует: 2,5 % при отсечке 3 % — 0. источник:
// tools/reference/ai_reference.py, сценарии scale «корень: 4,032 мА», «корень: 4,16 мА», «без корня: 4,4 мА».
METHOD PRIVATE LowCutBelowCutReturnsZero
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
