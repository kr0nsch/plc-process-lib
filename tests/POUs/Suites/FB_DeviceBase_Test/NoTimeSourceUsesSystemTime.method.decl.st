// Без источника (itfTime = 0) база берёт встроенный FB_SystemTime: действующий источник задан,
// время вызова больше 0, шаг между двумя соседними вызовами меньше 1 с.
METHOD PRIVATE NoTimeSourceUsesSystemTime
VAR
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
