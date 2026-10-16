// tMinRun = 10 с: снятие xAutoRun через 2 с после входа в Running останавливает двигатель только через 10 с
// от входа в Running (на 9,9 с ещё работает).
METHOD PRIVATE MinRunTimeDelaysAutoStop
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
