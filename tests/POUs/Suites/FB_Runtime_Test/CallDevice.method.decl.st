// Помощник: вызов элемента массива устройств через VAR_IN_OUT (iec_checker 0.4 не разбирает
// вызов afbDev[i](...))
METHOD PRIVATE CallDevice
VAR_IN_OUT
    fbDevice : FB_TestDeviceExt;    // устройство
    stCmdDev : ST_TestDeviceCmd;    // его команды
    stRetDev : ST_DeviceRetain;     // его retain
END_VAR
VAR_IN_OUT CONSTANT
    // lint:allow STL007 VAR_IN_OUT CONSTANT — параметр, а не константа, см. docs/STATIC_ANALYSIS.md
    stCfgDev : ST_TestDeviceCfg;    // конфигурация
END_VAR
VAR_INPUT
    itfTimeSrc : I_TimeSource;      // источник времени
END_VAR
