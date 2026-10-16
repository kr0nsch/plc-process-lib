// Длина массивов слотов базы (afbAlarm, axAlmCond, axAlmSuppress, arAlmValue) равна
// GVL_Const.DEV_ALARMS_MAX: циклы базы идут по константе, тест ловит расхождение, если границу
// запишут числом. Тест читает внутренние переменные базы намеренно — это проверка раскладки.
METHOD PRIVATE AlarmSlotArraysMatchDevAlarmsMax
VAR
    fbDev : FB_TestDevice;   // устройство (вызов не нужен)
    fbAlm : FB_Alarm;        // размер одного слота
END_VAR
