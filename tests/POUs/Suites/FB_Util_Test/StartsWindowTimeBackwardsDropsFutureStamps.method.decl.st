// Время назад: отметки «из будущего» удаляются и в Count, и в Register; окно остаётся упорядоченным.
METHOD PRIVATE StartsWindowTimeBackwardsDropsFutureStamps
VAR
    fbWin : FB_StartsWindow; // ФБ под тестом
END_VAR
