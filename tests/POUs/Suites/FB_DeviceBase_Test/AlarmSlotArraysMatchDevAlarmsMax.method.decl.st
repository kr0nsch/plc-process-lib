// Массивы слотов базы (afbAlarm, axAlmCond, axAlmSuppress, arAlmValue) записаны с границей 7
// числом (iec_checker 0.4 не разбирает константы в границах): их длина равна
// GVL_Const.DEV_ALARMS_MAX. Тест читает внутренние переменные базы намеренно — это проверка раскладки.
METHOD PRIVATE AlarmSlotArraysMatchDevAlarmsMax
VAR
    fbDev : FB_TestDevice;   // устройство (вызов не нужен)
    fbAlm : FB_Alarm;        // размер одного слота
END_VAR
