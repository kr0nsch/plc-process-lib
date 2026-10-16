// Блокировка не фиксируется: в Auto после её снятия двигатель сам запускается по xAutoRun (tMinStop = 0),
// в Manual — нет (ручная защёлка снята блокировкой).
METHOD PRIVATE InterlockClearedAutoRestartsManualDoesNot
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot     : FB_Motor;          // двигатель под тестом
    stCmd     : ST_MotorCmd;       // команды
    stRetain  : ST_DeviceRetain;   // энергонезависимые данные
    stCfg     : ST_MotorCfg;       // конфигурация (умолчания)
    fbTime2   : FB_FakeTime;       // подменное время второго двигателя
    fbMot2    : FB_Motor;          // второй двигатель
    stCmd2    : ST_MotorCmd;       // его команды
    stRetain2 : ST_DeviceRetain;   // его энергонезависимые данные
END_VAR
