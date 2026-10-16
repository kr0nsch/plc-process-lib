// Граница 3,8 мА — уже норма (NE43_MEAS_LOW_MA: «I < — вне диапазона»): Good, значение -1,25 %.
METHOD PRIVATE At3p8mAIsGood
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
