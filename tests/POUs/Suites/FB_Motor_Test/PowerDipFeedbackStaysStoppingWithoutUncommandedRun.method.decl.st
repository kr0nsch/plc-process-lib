// Провал напряжения 0,3 с, который пережил ПЧ (кинетическая поддержка): ОС «в работе» не пропала. Команда
// снята; после восстановления питания двигатель тормозит под контролем останова (Stopping, tFbStop = 10 с), а
// не стоит в Stopped с ложным UncommandedRun через tFbStart = 5 с; ОС пропала через 6 с — Stopped без отказа.
METHOD PRIVATE PowerDipFeedbackStaysStoppingWithoutUncommandedRun
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация
END_VAR
