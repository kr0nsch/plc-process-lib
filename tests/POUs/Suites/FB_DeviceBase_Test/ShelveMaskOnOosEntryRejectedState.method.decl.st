// Маска shelve в вызове, в котором устройство уходит в OutOfService (xSetOos и wShelveReq вместе), и
// в OutOfService: shelve не принимается (10.1) — результат маски RejectedState, а не ложный Accepted
// (слот в этот момент ещё не в OutOfService и на запрос ответил бы TRUE); после выхода из
// OutOfService тревога не Shelved
METHOD PRIVATE ShelveMaskOnOosEntryRejectedState
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию (tShelveMax 8 ч)
    itfAlm   : I_Alarm;            // слот 0 через интерфейс
END_VAR
