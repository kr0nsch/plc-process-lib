// Задержка включения 2 с, шаг 100 мс: выход включается ровно на 20-м шаге (t0 + 2,0 с), не на 19-м.
METHOD PRIVATE OnDelayOutputExactlyAtDelay
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
    iStep   : INT;           // шаг цикла
END_VAR
