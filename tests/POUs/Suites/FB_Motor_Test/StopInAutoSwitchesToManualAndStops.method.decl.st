// «Стоп» оператора в Auto: устройство переходит в Manual (запомнено в retain), команда работы снимается сразу,
// Stopping до пропадания ОС, затем Stopped; результат Accepted.
METHOD PRIVATE StopInAutoSwitchesToManualAndStops
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
