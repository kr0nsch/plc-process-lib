// Граница NE 43 3,6 мА включена в отказ (A-02, сверить с NAMUR NE 43): FailLow, Failure (tFailDelay = 0), бит
// AI_FLT_FAIL_LOW; чуть выше, 3,61 мА — уже UnderRange.
METHOD PRIVATE At3p6mAIsFailure
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
