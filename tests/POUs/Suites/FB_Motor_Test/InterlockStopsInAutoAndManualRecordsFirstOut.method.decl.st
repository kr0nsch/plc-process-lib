// Блокировка останавливает двигатель в Auto и в Manual; первопричина — младший из битов, взведённых при
// переходе слова из 0 (биты 3 и 5 разом → 3), последующие биты её не меняют; вход в Starting её снимает;
// в Manual блокировка снимает ручную защёлку.
METHOD PRIVATE InterlockStopsInAutoAndManualRecordsFirstOut
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
