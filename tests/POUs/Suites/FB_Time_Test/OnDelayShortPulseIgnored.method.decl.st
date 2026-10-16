// Импульс 1,5 с при задержке включения 2 с, затем 5 с покоя: выход не включается ни разу,
// ожидание отменяется.
METHOD PRIVATE OnDelayShortPulseIgnored
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
    iStep   : INT;           // шаг цикла
    xEverOn : BOOL;          // выход включался хотя бы раз
END_VAR
