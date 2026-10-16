// Сводка тревог: слоты Low, High, Medium активны — ePrioUnack = High; квитирован High — Medium;
// слот Medium вернулся без квитирования — wAlmActive = 2#011, wAlmUnack = 2#101; подавление слота 0
// — бит в wAlmShelved и снят из wAlmUnack.
METHOD PRIVATE AlarmSummaryWordsAndPrioUnack
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // приоритеты слотов 0…2
END_VAR
