// ОС без команды ПЛК дольше tFbStart = 5 с: отказ UncommandedRun (High); до этого двигатель считается
// работающим по ОС; фронт ОС без команды — пуск (счётчик и окно пусков).
METHOD PRIVATE UncommandedRunDetected
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
