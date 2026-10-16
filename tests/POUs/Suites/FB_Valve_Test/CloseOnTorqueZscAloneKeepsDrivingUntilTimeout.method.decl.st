// Клиновая задвижка, закрытие «по моменту», tTravel = 10 с. ZSC сработал на t0 + 3 с (концевик стоит
// чуть раньше посадки клина): выход «закрывать» не снимается — клин дожимается до муфты, xClosed нет.
// Муфта так и не сработала: ровно на t0 + 10,0 с — FailToClose, выход снят; положение по ZSC видно в
// xClosed. Reset снимает отказ — далее состояние по концевикам (Closed).
METHOD PRIVATE CloseOnTorqueZscAloneKeepsDrivingUntilTimeout
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
