// Дымовая проверка FB_SystemTime (оператор LTIME()): 20 000 вызовов подряд — время не убывает,
// растёт (значит, берётся заново в каждом вызове) и больше нуля. Реального ожидания нет.
// Проверка R1 контракта; ручная проверка со сменой времени ОС — docs/MANUAL_STEPS.md.
METHOD PRIVATE SystemTimeIsMonotonic
VAR
    fbSys      : FB_SystemTime;   // ФБ под тестом
    itfTime    : I_TimeSource;    // через интерфейс, как в ФБ библиотеки
    ltFirst    : LTIME;           // время первого вызова
    ltPrev     : LTIME;           // время предыдущего вызова
    ltNow      : LTIME;           // время этого вызова
    xMonotonic : BOOL := TRUE;    // ни разу не убывало
    iStep      : INT;             // шаг цикла
END_VAR
