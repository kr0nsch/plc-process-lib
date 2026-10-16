// Ёмкость кольца altStart равна GVL_Const.STARTS_WINDOW_MAX: индексы кольца считаются по константе,
// тест ловит расхождение, если границу массива запишут числом.
// Тест обращается к внутренней переменной ФБ намеренно: это проверка раскладки, а не API.
METHOD PRIVATE StartsWindowRingCapacityMatchesConst
VAR
    fbWin : FB_StartsWindow; // ФБ под тестом
    ltOne : LTIME;           // один элемент кольца
END_VAR
