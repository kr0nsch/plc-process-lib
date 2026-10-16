// AdvanceL: шаги меньше 1 мс (4 по 250 мкс) и больше 49 сут (60 сут).
METHOD PRIVATE FakeTimeAdvanceLSubMsAndLongSteps
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    ltMark  : LTIME;         // время перед шагами
    iStep   : INT;           // шаг цикла
END_VAR
