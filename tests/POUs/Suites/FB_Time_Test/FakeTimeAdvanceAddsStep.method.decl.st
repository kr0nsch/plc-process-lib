// Advance прибавляет шаг TIME: два шага по 250 мс, затем длинный шаг 49 сут.
METHOD PRIVATE FakeTimeAdvanceAddsStep
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    ltMark  : LTIME;         // время перед шагами
END_VAR
