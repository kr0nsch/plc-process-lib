// RequestMode(Local) и значение вне перечисления возвращают FALSE: запроса нет, команда не считается.
METHOD PRIVATE RequestModeLocalReturnsFalse
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    uBad     : U_TestEnumInt;      // число вне перечисления
    xRet     : BOOL;               // ответы RequestMode
END_VAR
