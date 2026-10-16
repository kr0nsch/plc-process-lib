// Помощник: вызов одного устройства массива со всеми VAR_IN_OUT (короче цикл теста)
METHOD PRIVATE CallDevice
VAR_IN_OUT
    fbDevice : FB_TestDeviceExt;    // устройство
    stCmdDev : ST_TestDeviceCmd;    // его команды
    stRetDev : ST_DeviceRetain;     // его retain
END_VAR
VAR_IN_OUT CONSTANT
    stCfgDev : ST_TestDeviceCfg;    // конфигурация
END_VAR
VAR_INPUT
    itfTimeSrc : I_TimeSource;      // источник времени
END_VAR
