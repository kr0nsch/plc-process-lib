// Смена приоритета активной тревоги (Medium → High) действует сразу и события не порождает.
METHOD PRIVATE PriorityChangeWhileActiveNoEvent
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // Medium, затем High
    itfAlm : I_Alarm;        // тот же ФБ через интерфейс
END_VAR
