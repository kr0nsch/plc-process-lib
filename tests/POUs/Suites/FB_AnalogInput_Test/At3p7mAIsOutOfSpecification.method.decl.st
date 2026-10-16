// 3,7 мА (между 3,6 и 3,8): UnderRange, OutOfSpecification, значение считается (экстраполяция -1,875 %) и пригодно, бит
// AI_WRN_UNDER_RANGE, тревога OutOfRange. источник: tools/reference/ai_reference.py, сценарий scale «3,7 мА, шкала
// 0..100».
METHOD PRIVATE At3p7mAIsOutOfSpecification
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
END_VAR
