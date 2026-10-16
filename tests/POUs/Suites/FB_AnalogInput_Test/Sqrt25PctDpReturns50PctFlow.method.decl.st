// Корень (расход по перепаду): 8 мА = 25 % перепада — 50 % расхода; 4 мА — 0, 20 мА — 100. источник:
// tools/reference/ai_reference.py, сценарий scale «корень: 8 мА (25 % перепада)».
METHOD PRIVATE Sqrt25PctDpReturns50PctFlow
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
