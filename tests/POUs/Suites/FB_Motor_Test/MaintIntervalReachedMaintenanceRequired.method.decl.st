// ТО по наработке 1 ч (порог 3600 с) и по 2 пускам: 3590 с + 10 с работы — предупреждение MAINT_RUNTIME,
// NE 107 MaintenanceRequired; второй пуск — MAINT_STARTS; xResetMaint обнуляет счётчики «с ТО» (Accepted).
// Источник: tools/reference/motor.py, сценарии maint_runtime_*.
METHOD PRIVATE MaintIntervalReachedMaintenanceRequired
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
