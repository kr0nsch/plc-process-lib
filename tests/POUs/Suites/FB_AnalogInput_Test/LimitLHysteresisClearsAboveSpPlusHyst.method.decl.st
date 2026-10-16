// Уставка L 20, гистерезис 2: 20,1 — нет; 20,0 — да; 22,0 — ещё да; 22,1 — снят.
METHOD PRIVATE LimitLHysteresisClearsAboveSpPlusHyst
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
