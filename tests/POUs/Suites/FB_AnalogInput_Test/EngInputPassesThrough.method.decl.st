// Eng (значение уже в инж. ед., Modbus REAL): шкала -50..150, 123,4 — 123,4 (86,7 %); NE 43 не применяется (0 — норма).
// источник: tools/reference/ai_reference.py, сценарий scale «Eng 123,4, шкала -50..150».
METHOD PRIVATE EngInputPassesThrough
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
