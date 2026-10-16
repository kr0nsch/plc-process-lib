// «Время назад» во время shelve (SetNow на 2 ч раньше): остаток не растёт сверх срока (1 ч), shelve
// заканчивается через 1 ч от нового времени.
METHOD PRIVATE TimeBackwardsShelveRemainNotExtended
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
END_VAR
