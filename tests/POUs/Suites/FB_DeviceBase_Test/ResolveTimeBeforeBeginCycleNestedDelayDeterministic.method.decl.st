// ResolveTime до BeginCycle: вложенный FB_Delay, вызванный раньше BeginCycle, с первого вызова
// получает подменное время — задержка включения 2 с отрабатывает ровно (на 1,9 с выхода нет).
METHOD PRIVATE ResolveTimeBeforeBeginCycleNestedDelayDeterministic
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // Auto
    stCfg    : ST_TestDeviceCfg;   // tRunDelay = 2 с
    iStep    : INT;                // шаг цикла
END_VAR
