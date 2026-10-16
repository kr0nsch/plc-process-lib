// R1 контракта внутри цикла: 20 000 чтений LTIME() подряд — время не убывает, меняется хотя бы
// раз, наименьший ненулевой шаг (разрешение источника) не больше 1 мкс.
METHOD PRIVATE LTimeResolutionAtMost1us
VAR
    fbSys      : FB_SystemTime;     // источник под тестом
    itfTime    : I_TimeSource;      // через интерфейс, как в ФБ библиотеки
    ltPrev     : LTIME;             // предыдущее чтение
    ltNow      : LTIME;             // текущее чтение
    ltMinStep  : LTIME := LTIME#1S; // наименьший ненулевой шаг
    uiChanges  : UINT;              // сколько раз время изменилось
    xMonotonic : BOOL := TRUE;      // не убывало
    iStep      : INT;               // шаг цикла
END_VAR
