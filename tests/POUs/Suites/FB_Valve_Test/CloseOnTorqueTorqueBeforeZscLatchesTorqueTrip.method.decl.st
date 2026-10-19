// Клиновая задвижка, закрытие «по моменту», ZSC подключён. Муфта закрытия сработала на t0 + 3 с, а
// ZSC — нет: ZSC настроен чуть раньше посадки клина (VLV-19), значит, это не посадка, а заклинивание или
// посторонний предмет — TorqueTrip, выход снят, xClosed нет. Тот же ход без ZSC (xZscUsed = FALSE):
// муфта — штатное окончание закрытия, Closed без отказа, и после того как муфта отпустила, задвижка
// остаётся Closed.
METHOD PRIVATE CloseOnTorqueTorqueBeforeZscLatchesTorqueTrip
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv     : FB_Valve;          // задвижка с ZSC
    stCmd     : ST_ValveCmd;       // команды HMI
    stRetain  : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg     : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    fbVlv2    : FB_Valve;          // задвижка без ZSC
    stCmd2    : ST_ValveCmd;       // команды HMI второй задвижки
    stRetain2 : ST_DeviceRetain;   // режим Manual по умолчанию
    stCfg2    : ST_ValveCfg;       // конфигурация второй задвижки
    iStep     : INT;               // шаг цикла
END_VAR
