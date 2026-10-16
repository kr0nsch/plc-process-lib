// Разрешение на открытие пропало в ходе: работающий ход не останавливается (бит PERMIT_MISSING и
// wPermitMissing показывают недостачу), арматура доходит до ZSO.
METHOD PRIVATE PermitLostWhileMovingContinuesMotion
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
