// Отложенная оператором тревога и подавленная логикой — разные биты (ISA-18.2, ALM-2): слот 0 отложен (wShelveReq)
// — бит только в wAlmShelved; слот 1 подавлен (axSuppressIn) — бит только в wAlmSuppressed. Вывод устройства из
// работы — ни shelve, ни подавление: оба слова 0 (OutOfService виден по eMode).
METHOD PRIVATE ShelvedAndSuppressedSeparateMasks
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация
END_VAR
