// 20,7 мА (между 20,5 и 21,0): OverRange, OutOfSpecification, значение — насыщение NE 43 20,5 мА (103,125 %), без
// экстраполяции; выход за диапазон подтверждён — xValid = FALSE (AI-13), бит AI_WRN_OVER_RANGE.
// источник: tools/reference/ai_reference.py, сценарий scale «20,7 мА, шкала 0..100 (насыщение NE 43)».
METHOD PRIVATE At20p7mAIsOutOfSpecification
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
