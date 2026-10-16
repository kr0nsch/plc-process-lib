// Вывод из работы при работающем двигателе — RejectedState (чек-лист, пункт 3); у стоящего — принят: режим
// OutOfService, NE 107 CheckFunction, пуск — RejectedMode.
METHOD PRIVATE OosRequestWhileRunningRejected
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
