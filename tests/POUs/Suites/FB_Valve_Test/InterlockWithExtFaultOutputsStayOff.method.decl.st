// Авария привода (ExtFault: тепловое реле, обрыв фазы) — привод неисправен: блокировка выходы не включает (VLV-20),
// состояние Fault, бит INTERLOCKED показывает только действующую блокировку.
METHOD PRIVATE InterlockWithExtFaultOutputsStayOff
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла

    xAnyOut  : BOOL;              // выход привода хоть раз
END_VAR
