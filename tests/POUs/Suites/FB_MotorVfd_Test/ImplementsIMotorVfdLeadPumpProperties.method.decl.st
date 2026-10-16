// I_MotorVfd для ведущего насоса: SpeedRef, SpeedAct, SpeedAutoActive (Auto, Running, без отказа), Running и
// Mode через интерфейс; в Manual SpeedAutoActive = FALSE.
METHOD PRIVATE ImplementsIMotorVfdLeadPumpProperties
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfLead  : I_MotorVfd;        // ведущий насос через интерфейс
END_VAR
