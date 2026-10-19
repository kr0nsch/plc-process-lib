// I_MotorVfd для ведущего насоса: SpeedRef, SpeedAct, SpeedAutoActive, Running и Mode через интерфейс.
// SpeedAutoActive (VFD-06) — только Auto, Running и без отказа: FALSE у стоящего в Auto насоса, в Starting (ОС ещё
// нет), в Stopping (ОС ещё есть), при отказе связи и в Manual; TRUE — Auto и Running.
METHOD PRIVATE ImplementsIMotorVfdLeadPumpProperties
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfLead  : I_MotorVfd;        // ведущий насос через интерфейс
END_VAR
