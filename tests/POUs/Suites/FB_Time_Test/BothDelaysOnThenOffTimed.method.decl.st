// Обе задержки: включение 1 с, отключение 2 с, шаг 500 мс.
METHOD PRIVATE BothDelaysOnThenOffTimed
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
END_VAR
