// 3,61 мА — защитная полоса NE 43 между отказом (<= 3,6) и измерением (>= 3,8 мА): исправный датчик NE 43 так не
// выдаёт, это ток отказа с погрешностью канала или насыщение (AI-13). Значение не экстраполируется ниже насыщения
// 3,8 мА: -0,125 м на шкале 0..10 м (-0,0125 · 10). Пока выход за диапазон не подтверждён (1,9 с) — xValid; через
// tFailDelay = 2 с — xValid = FALSE (ПИД и автоматика по неопределённому значению не управляют), NE 107
// OutOfSpecification, wFault = 0, UNDER_RANGE; уставка LL остаётся (значение не выше насыщения). Норма 12 мА —
// xValid снова через tFailDelay. источник: tools/reference/ai_reference.py, сценарий scale «3,61 мА, шкала 0..10
// (насыщение NE 43)».
METHOD PRIVATE GuardBandLowInvalidAfterDelay
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
END_VAR
