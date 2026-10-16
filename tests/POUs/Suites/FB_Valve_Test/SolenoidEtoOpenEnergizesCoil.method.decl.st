// Соленоид НЗ (SolenoidEto, без тока закрыт): xOpen — катушка под током, Opening, выходов привода нет;
// ZSO — Open, катушка держит; xClose — катушка обесточена, Closing.
METHOD PRIVATE SolenoidEtoOpenEnergizesCoil
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
