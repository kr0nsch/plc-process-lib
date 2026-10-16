// stCmd.xReset: сброс зафиксированного отказа (причина ушла) и квитирование всех тревог — одна
// команда (результат Accepted, uiCmdSeq + 1), бит сброшен. Метод Reset() квитирует так же.
METHOD PRIVATE ResetCmdAcksAlarmsAndClearsLatch
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    xRet     : BOOL;               // ответ Reset
END_VAR
