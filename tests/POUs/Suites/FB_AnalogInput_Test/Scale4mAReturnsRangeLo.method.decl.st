// Шкала 2..12: 4 мА — начало шкалы 2,0 (0 %), сигнал в норме, значение пригодно, NE 107 Good. источник:
// tools/reference/ai_reference.py, сценарий scale «4 мА, шкала 2..12».
METHOD PRIVATE Scale4mAReturnsRangeLo
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
