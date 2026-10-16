// Устройство без тревог (uiAlarmCount = 0): все условия и маски взведены — ни один слот не
// вызывается, сводка пустая, GetAlarm(0) = 0; маска квитирования — Accepted, маска shelve —
// RejectedState. Проверка цикла FOR 1 TO MIN(...) без беззнакового «0 - 1».
METHOD PRIVATE ZeroAlarmCountNoSlotsRun
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    itfAlm   : I_Alarm;            // ответ GetAlarm
    uiSlot   : UINT;               // номер слота
END_VAR
