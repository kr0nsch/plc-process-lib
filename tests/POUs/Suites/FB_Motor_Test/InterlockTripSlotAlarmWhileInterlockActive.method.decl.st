// Останов блокировкой в работе — тревога слота 5 InterlockTrip (приоритет по умолчанию None, здесь Low),
// номер тревоги udiAlarmIdBase + 5; пока блокировка действует — тревога активна, после снятия — нет.
METHOD PRIVATE InterlockTripSlotAlarmWhileInterlockActive
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfAlm   : I_Alarm;           // тревога слота
END_VAR
