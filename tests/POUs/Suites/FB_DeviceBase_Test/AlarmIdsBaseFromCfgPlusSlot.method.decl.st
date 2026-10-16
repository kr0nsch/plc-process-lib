// Номер тревоги слота = stCfg.udiAlarmIdBase + слот: база 120, слот 5 — 125; номер и значение
// процесса приходят в событии.
METHOD PRIVATE AlarmIdsBaseFromCfgPlusSlot
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // udiAlarmIdBase = 120
    fbSink   : FB_TestSink;        // приёмник событий
    stEv     : ST_AlarmEvent;      // последнее событие
    itfAlm   : I_Alarm;            // слот через интерфейс
END_VAR
