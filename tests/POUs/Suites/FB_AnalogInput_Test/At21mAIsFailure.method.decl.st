// Граница NE 43 21,0 мА включена в отказ (A-02): FailHigh, Failure, бит AI_FLT_FAIL_HIGH; 20,99 мА — ещё OverRange.
METHOD PRIVATE At21mAIsFailure
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
