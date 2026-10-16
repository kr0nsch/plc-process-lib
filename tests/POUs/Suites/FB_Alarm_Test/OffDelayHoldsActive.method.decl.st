// Задержка снятия 2 с: после ухода условия тревога остаётся ActiveUnack до 1,9 с и переходит в
// RtnUnack ровно в 2,0 с.
METHOD PRIVATE OffDelayHoldsActive
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // tOffDelay = 2 с
    iStep  : INT;            // шаг цикла
END_VAR
