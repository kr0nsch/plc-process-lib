// Соленоидный клапан НЗ (SolenoidEto) с ZSO и ZSC, открыт командой до ZSO. Пропало питание привода: катушка
// обесточена, клапан уходит на пружину — ZSO пропал, через 1 с ZSC. Отказа PositionLost нет: без напряжения уход
// с концевика не контролируется (VLV-08), состояние Closed. Питание вернулось — отказа нет, в Manual катушка не
// включается.
METHOD PRIVATE SolenoidWithZsoPowerLossNoPositionLostFault
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла

    wFltSeen : WORD;              // отказы, которые хоть раз появлялись
END_VAR
