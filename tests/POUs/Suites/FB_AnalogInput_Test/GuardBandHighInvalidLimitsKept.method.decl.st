// 20,9 мА — верхняя защитная полоса NE 43 (между 20,5 и 21 мА, AI-13): значение — насыщение 20,5 мА, 10,3125 м на
// шкале 0..10 м (1,03125 · 10), без экстраполяции; через tFailDelay — xValid = FALSE, OVER_RANGE, уставка HH (9,5 м)
// остаётся: процесс выше верхнего предела измерения. источник: tools/reference/ai_reference.py, сценарий scale
// «20,9 мА, шкала 0..10 (насыщение NE 43)».
METHOD PRIVATE GuardBandHighInvalidLimitsKept
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
END_VAR
