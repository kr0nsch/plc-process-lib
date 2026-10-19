// Задвижка в Auto открыта по ZSO; замыкание в цепи ZSC — оба концевика дольше tLimitFilter, отказ BothLimits.
// Блокировка (положение безопасности Closed): привод исправен, отказал только контроль концевиков — задвижка
// закрывается (VLV-20), состояние Fault, биты INTERLOCKED и CLOSING. Концевикам верить нельзя, поэтому ход
// заканчивается по tTravel (60 с), а не по ZSC; дальше, пока блокировка держится, ход не повторяется; оба выхода
// никогда.
METHOD PRIVATE InterlockWithBothLimitsDrivesSafe
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла

    xCloseOn : BOOL;              // «закрывать» включено во всех вызовах хода до 59,9 с
    xBoth    : BOOL;              // оба выхода хоть раз
END_VAR
