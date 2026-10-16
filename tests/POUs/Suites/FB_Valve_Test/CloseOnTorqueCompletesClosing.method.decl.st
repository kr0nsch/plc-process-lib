// Клиновая задвижка: муфта подключена, закрытие «по моменту». Через 3 с хода сработала муфта закрытия
// раньше ZSC — Closed без отказа, выход снят, xClosed; предупреждения «положение по времени» нет. ZSC
// так и не сработал — ухода с концевика нет: положение подтверждено муфтой, а не концевиком.
METHOD PRIVATE CloseOnTorqueCompletesClosing
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
