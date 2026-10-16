// ТО по циклам: udiMaintCycles = 2, до ТО остался один цикл. Открытие — счётчик «с ТО» 2: предупреждение
// VLV_WRN_MAINT_CYCLES, NE 107 MaintenanceRequired, бит DEV_STS_WARNING; xResetMaint — снова Good.
METHOD PRIVATE MaintCyclesReachedMaintenanceRequired
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
