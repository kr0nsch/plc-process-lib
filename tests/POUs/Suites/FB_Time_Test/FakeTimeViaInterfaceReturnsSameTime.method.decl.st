// Через I_TimeSource FB_FakeTime отдаёт то же время, что и напрямую (так его получают ФБ библиотеки).
METHOD PRIVATE FakeTimeViaInterfaceReturnsSameTime
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    itfTime : I_TimeSource;  // источник через интерфейс
END_VAR
