// Preset ставит выход сразу, без задержек включения и отключения (5 с каждая).
METHOD PRIVATE PresetForcesOutputWithoutDelay
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
END_VAR
