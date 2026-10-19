// Клиновая задвижка, закрытие по моменту (xTorqueUsed, xCloseOnTorque), закрыта при ZSC. «Открыть»: при страгивании
// клина муфта открытия срабатывает, пока ZSC ещё замкнут, — это не заклинивание (VLV-21): ход продолжается, отказа
// нет. ZSC разомкнулся; ещё tLimitFilter (0,5 с) муфта не контролируется, затем муфта в ходе — TorqueTrip.
METHOD PRIVATE OpenTorqueWhileUnseatingIgnored
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
