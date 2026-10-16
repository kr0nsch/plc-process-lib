// Задержка появления 3 с: условие 2,9 с тревоги не даёт; устойчивое условие — ActiveUnack ровно
// через 3,0 с (на шаге 2,9 с ещё Normal).
METHOD PRIVATE OnDelayShortConditionNoAlarm
VAR
    fbTime  : FB_FakeTime;   // подменное время
    fbAlm   : FB_Alarm;      // ФБ под тестом
    stCfg   : ST_AlarmCfg;   // tOnDelay = 3 с
    xEver   : BOOL;          // тревога хоть раз ушла из Normal
    iStep   : INT;           // шаг цикла
END_VAR
