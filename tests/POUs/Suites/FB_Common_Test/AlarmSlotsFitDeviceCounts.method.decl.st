// Слоты тревог: последний индекс E_<Dev>Alarm + 1 = число используемых слотов типа
// (GVL_Const.<DEV>_ALARM_COUNT) и не больше DEV_ALARMS_MAX = 8 слотов базы.
METHOD PRIVATE AlarmSlotsFitDeviceCounts
