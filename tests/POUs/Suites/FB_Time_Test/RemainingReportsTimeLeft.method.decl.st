// tRemaining: полная задержка сразу после фронта, остаток по ходу отсчёта, T#0S без отсчёта;
// то же для задержки отключения.
METHOD PRIVATE RemainingReportsTimeLeft
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
END_VAR
