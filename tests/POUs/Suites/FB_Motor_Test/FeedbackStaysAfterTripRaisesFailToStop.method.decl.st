// Сварившийся контактор: внешняя авария (тепловое реле) отключила двигатель — xQRun снят, Fault, — а ОС «в
// работе» осталась. Через tFbStop = 5 с после отказа к ExtFault добавляется FailToStop (тревога слота 2, High:
// механизм не остановить из ПЛК); через 4,9 с после отказа — только ExtFault.
METHOD PRIVATE FeedbackStaysAfterTripRaisesFailToStop
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfAlm   : I_Alarm;           // тревога слота FailToStop
END_VAR
