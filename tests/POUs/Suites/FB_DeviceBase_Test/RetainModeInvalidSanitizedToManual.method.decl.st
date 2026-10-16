// Значение вне {Auto, Manual} в stRetain.eRemoteMode (7 — мусор, 0 — очищенная память) заменяется
// на Manual и записывается обратно; устройство работает в Manual; это не команда (uiCmdSeq = 0).
METHOD PRIVATE RetainModeInvalidSanitizedToManual
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    uBad     : U_TestEnumInt;      // число вне перечисления
END_VAR
