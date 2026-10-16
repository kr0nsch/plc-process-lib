// Задержка отключения 3 с: выход держится до t0 + 2,9 с (идёт отсчёт) и снимается ровно в t0 + 3,0 с.
METHOD PRIVATE OffDelayHoldsOutputForDelay
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
    iStep   : INT;           // шаг цикла
END_VAR
