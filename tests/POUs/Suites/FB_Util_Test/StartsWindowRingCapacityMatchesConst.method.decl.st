// Ёмкость кольца altStart равна GVL_Const.STARTS_WINDOW_MAX. Граница массива записана числом
// (iec_checker 0.4 не разбирает константы в границах), тест ловит расхождение с константой.
// Тест обращается к внутренней переменной ФБ намеренно: это проверка раскладки, а не API.
METHOD PRIVATE StartsWindowRingCapacityMatchesConst
VAR
    fbWin : FB_StartsWindow; // ФБ под тестом
    ltOne : LTIME;           // один элемент кольца
END_VAR
