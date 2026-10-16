// Провал входа 1,9 с при задержке отключения 3 с, затем 5 с с TRUE: выход не снимается ни разу.
METHOD PRIVATE OffDelayShortGapIgnored
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
    iStep   : INT;           // шаг цикла
    xEverOff : BOOL;         // выход снимался хотя бы раз
END_VAR
