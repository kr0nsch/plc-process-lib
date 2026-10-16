// Граница окна: отметка ровно часовой давности уже не считается (ltNow - t < STARTS_WINDOW).
METHOD PRIVATE StartsWindowExactlyOneHourOldNotCounted
VAR
    fbWin : FB_StartsWindow; // ФБ под тестом
END_VAR
