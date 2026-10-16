// TimeToFree: пуски 1:00, 1:10, 1:20; в 1:30 при лимите 3 — 30 мин, при лимите 2 — 40 мин,
// при лимите 4 и без лимита (0) — 0; в 2:00 при лимите 3 — 0.
// Источник: tools/reference/common.py, сценарий starts_window.
METHOD PRIVATE StartsWindowTimeToFreeReportsRemaining
VAR
    fbWin : FB_StartsWindow; // ФБ под тестом
END_VAR
