// FB_StartsWindow: пуски в 1:00, 1:20, 1:40 — в окне последнего часа их 3, 2, 1, 0 по мере
// старения. Источник: tools/reference/common.py, сценарий starts_window.
METHOD PRIVATE StartsWindowCountsOnlyLastHour
VAR
    fbWin : FB_StartsWindow; // ФБ под тестом
END_VAR
