// Задержки T#0S: фронт и спад проходят в том же вызове, отсчёта нет. Время не продвигается.
METHOD PRIVATE ZeroDelaysPassThroughSameCall
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
END_VAR
