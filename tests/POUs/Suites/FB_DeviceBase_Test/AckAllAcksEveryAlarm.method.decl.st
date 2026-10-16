// AckAll() квитирует все тревоги устройства: три активных слота → ActiveAck, wAlmUnack = 0, бит
// DEV_STS_ALARM_UNACK снят, результат Accepted; когда квитировать нечего, AckAll() — FALSE.
// Бит stCmd.xAck делает то же и сбрасывается.
METHOD PRIVATE AckAllAcksEveryAlarm
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    itfAlm   : I_Alarm;            // слот через интерфейс
    xRet     : BOOL;               // ответ AckAll
END_VAR
