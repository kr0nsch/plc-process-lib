// Неконечное значение подмены (NaN с HMI) не принимается: значение остаётся прежним (42), а не NaN.
METHOD PRIVATE SubstitutionNonFiniteValueHeld
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    uBits  : U_RealBits;          // NaN по битам
END_VAR
