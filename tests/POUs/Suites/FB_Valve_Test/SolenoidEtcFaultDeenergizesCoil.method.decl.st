// Соленоид НО (SolenoidEtc, без тока открыт): закрытие — катушка под током и держит Closed. Внешняя
// авария — Fault, катушка обесточена (положение пружины, независимо от eSafePos), выходов привода нет;
// причина ушла — катушка без тока до Reset, пружина открыла клапан (xOpened).
METHOD PRIVATE SolenoidEtcFaultDeenergizesCoil
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
