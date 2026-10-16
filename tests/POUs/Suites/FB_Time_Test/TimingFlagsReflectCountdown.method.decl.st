// xTimingOn и xTimingOff взведены только во время своих отсчётов (задержки по 1 с).
METHOD PRIVATE TimingFlagsReflectCountdown
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
END_VAR
