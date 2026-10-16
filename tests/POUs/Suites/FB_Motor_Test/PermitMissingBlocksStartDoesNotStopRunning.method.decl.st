// Нет разрешения: в Auto запрос ждёт (бит PERMIT_MISSING, wPermitMissing, ReadyToStart = FALSE) и пуск
// происходит сам, когда разрешение появилось; пропажа разрешения работающий двигатель не останавливает;
// в Manual xStart — RejectedPermit.
METHOD PRIVATE PermitMissingBlocksStartDoesNotStopRunning
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
