// Граница 20,5 мА — ещё норма (NE43_MEAS_HIGH_MA: «I > — вне диапазона»): Good, значение 103,125 %.
METHOD PRIVATE At20p5mAIsGood
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
