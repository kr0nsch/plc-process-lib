// «Время назад» (SetNow на 11,5 с раньше) во время отсчёта: выход не меняется, остаток — полная
// задержка (разность LTIME без переполнения), выход ровно через 2 с от нового времени.
METHOD PRIVATE TimeGoesBackwardsRestartsTiming
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
    iStep   : INT;           // шаг цикла
END_VAR
