// Срок shelve больше tShelveMax (2 ч при максимуме 1 ч) обрезается до максимума; меньший срок
// (30 мин) берётся как есть.
METHOD PRIVATE ShelveDurationAboveMaxClippedToMax
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // tShelveMax = 1 ч
    xRet   : BOOL;           // ответ Shelve
END_VAR
