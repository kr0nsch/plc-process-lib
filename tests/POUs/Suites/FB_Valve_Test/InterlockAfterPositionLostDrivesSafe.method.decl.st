// Задвижка в Auto открыта по ZSO; ZSO пропал (обрыв) — через tLimitFilter зафиксирован PositionLost, выходов нет.
// Блокировка (Closed): задвижка закрывается (VLV-20); ход заканчивается по ZSC — он согласован (ZSO нет). Отказ
// держится до Reset; после Reset — Closed по концевикам, движения нет (уже в положении безопасности).
METHOD PRIVATE InterlockAfterPositionLostDrivesSafe
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
