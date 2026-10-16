// Шкала 2..12: 20 мА — конец шкалы 12,0 (100 %). источник: tools/reference/ai_reference.py, сценарий scale «20 мА,
// шкала 2..12».
METHOD PRIVATE Scale20mAReturnsRangeHi
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
