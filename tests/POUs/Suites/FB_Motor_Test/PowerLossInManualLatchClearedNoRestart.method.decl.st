// Пропадание напряжения в Manual снимает ручную защёлку: после восстановления питания двигатель не
// запускается сам; отказа нет.
METHOD PRIVATE PowerLossInManualLatchClearedNoRestart
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
