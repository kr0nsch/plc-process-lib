// Авария ПЧ из слова состояния — внешняя авария (фильтр 200 мс, фиксируется); Reset даёт импульс xQReset,
// ПЧ сбрасывает аварию через 0,5 с — отказ снят в окне без второго нажатия.
METHOD PRIVATE VfdFaultTripsAndResetPulses
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
