// Norm01 (0–10 В и т. п.): NE 43 не применяется — rIn = -0,03 даёт экстраполяцию -3 % без отказа и выхода за диапазон
// даже при tFailDelay = 0; 1,5 — 150. источник: tools/reference/ai_reference.py, сценарии scale «Norm01 -0,03» и
// «Norm01 0,7».
METHOD PRIVATE Norm01NoNe43Check
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
