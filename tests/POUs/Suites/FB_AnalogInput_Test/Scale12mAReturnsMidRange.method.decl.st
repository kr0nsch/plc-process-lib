// Шкала 2..12: 12 мА — середина шкалы 7,0 (50 %); сырое значение в stSts.rIn. источник:
// tools/reference/ai_reference.py, сценарий scale «12 мА, шкала 2..12».
METHOD PRIVATE Scale12mAReturnsMidRange
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
