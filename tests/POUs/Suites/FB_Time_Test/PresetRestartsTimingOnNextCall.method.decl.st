// После Preset отсчёт начинается заново с ближайшего вызова тела: задержка 2 с, через 1,5 с
// Preset(FALSE), следующий вызов в t0 + 1,6 с — выход только в t0 + 3,6 с, а не в t0 + 2,0 с.
METHOD PRIVATE PresetRestartsTimingOnNextCall
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
    iStep   : INT;           // шаг цикла
END_VAR
