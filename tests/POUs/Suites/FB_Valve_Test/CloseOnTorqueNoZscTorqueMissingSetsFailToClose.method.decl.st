// Клиновая задвижка без ZSC (xZscUsed = FALSE), закрытие «по моменту», tTravel = 10 с. Муфта закрытия
// так и не сработала: на t0 + 9,9 с ещё Closing и выход «закрывать» держится, ровно на t0 + 10,0 с —
// FailToClose, выход снят, xClosed нет. Положения «закрыто по времени» у закрытия по моменту нет: его
// подтверждает только муфта.
METHOD PRIVATE CloseOnTorqueNoZscTorqueMissingSetsFailToClose
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация: без ZSC, закрытие по моменту
    iStep    : INT;               // шаг цикла
END_VAR
