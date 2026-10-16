// Raw (целое из Modbus): отсчёты 2000..10000 — шкала 0..16 бар; 6000 — 8,0; 1000 — экстраполяция -2,0; NE 43 не
// применяется, Cfg корректна. источник: tools/reference/ai_reference.py, сценарии scale «Raw 6000» и «Raw 1000».
METHOD PRIVATE RawInputScalesCounts
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
