// Подмена (Manual): значение — stCmd.xSubstValue в том же вызове, без задержек 5 с; пригодно, NE 107 CheckFunction. До
// подмены ФБ следит: stCmd.xSubstValue = xValue.
METHOD PRIVATE SubstitutionOverridesValueBypassesDelay
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
END_VAR
