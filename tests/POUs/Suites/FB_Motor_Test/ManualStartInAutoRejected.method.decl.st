// Auto: команда оператора «Пуск» отклоняется (RejectedMode), импульс сброшен, двигатель стоит, режим Auto.
METHOD PRIVATE ManualStartInAutoRejected
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
