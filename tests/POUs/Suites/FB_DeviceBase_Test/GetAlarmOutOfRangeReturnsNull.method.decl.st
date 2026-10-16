// GetAlarm отдаёт слот только в 0..AlarmCount - 1: при трёх слотах — слоты 0…2, номер 3 и 65535 —
// 0; до первого вызова слотов нет.
METHOD PRIVATE GetAlarmOutOfRangeReturnsNull
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    itfAlm   : I_Alarm;            // ответ GetAlarm
END_VAR
