// Кольцо на STARTS_WINDOW_MAX = 30: 31 пуск с шагом 1 мин (1:00…1:30) — остаются 30 последних;
// в 1:30 при лимите 30 окно освободится через 31 мин (самый старый оставшийся — 1:01).
// Источник: tools/reference/common.py, сценарий starts_window.
METHOD PRIVATE StartsWindowRingFullOverwritesOldest
VAR
    fbWin : FB_StartsWindow; // ФБ под тестом
    ltStart : LTIME := LTIME#1H;   // время очередного пуска
    iStep : INT;             // шаг цикла
END_VAR
