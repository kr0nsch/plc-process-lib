// «Стоп» и «Пуск» в одном вызове: «Стоп» старше — двигатель останавливается, оба импульса сброшены.
METHOD PRIVATE StopAndStartSameCallStopWins
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
