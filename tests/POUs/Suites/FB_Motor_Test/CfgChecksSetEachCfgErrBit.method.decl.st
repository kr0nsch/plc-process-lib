// CheckConfig двигателя: каждая проверка 13.9 даёт свой бит wCfgErr; границы допустимы (30 пусков в час,
// tResetPulse = tResetWindow); без ОС времена ОС не проверяются.
METHOD PRIVATE CfgChecksSetEachCfgErrBit
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    uBad     : U_TestEnumInt;     // значение вне перечисления
END_VAR
