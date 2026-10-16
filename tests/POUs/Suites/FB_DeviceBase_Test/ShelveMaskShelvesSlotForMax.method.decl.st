// Маска wShelveReq откладывает слот на его tShelveMax (1 ч): Shelved, бит в wAlmShelved, в 50 мин
// ещё отложен, в 60 мин снова ActiveUnack. Маска обнуляется, результат Accepted.
METHOD PRIVATE ShelveMaskShelvesSlotForMax
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // слот 2: tShelveMax = 1 ч
    itfAlm   : I_Alarm;            // слот через интерфейс
    iStep    : INT;                // шаг цикла
END_VAR
