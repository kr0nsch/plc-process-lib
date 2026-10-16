// AI/DI-подобное устройство (без stRetain, режима Local нет): после старта Auto из stModeMem,
// переключатель «Местное» не действует, xSetManual — Manual (подмена) с CheckFunction; stRetain не
// трогается.
METHOD PRIVATE InputLikeModeMemStartsAutoManualIsCheck
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbIn     : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // не используется
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
