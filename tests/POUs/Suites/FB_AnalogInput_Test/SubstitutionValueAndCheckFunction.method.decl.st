// Подмена (Manual): значение — stCmd.rSubstValue_eu без фильтра, пригодно, NE 107 CheckFunction, бит
// DEV_STS_MODE_MANUAL; уставки считаются по подменённому значению (H 80 при 85). «Измерение» — снова 50.
METHOD PRIVATE SubstitutionValueAndCheckFunction
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
