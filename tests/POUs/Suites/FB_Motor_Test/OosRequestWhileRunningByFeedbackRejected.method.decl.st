// Вывод из работы — только когда механизм стоит (2.2): после внешней аварии команда снята (Fault), но ОС
// «в работе» держится (сварился контактор) — xSetOos отклоняется (RejectedState), зафиксированные отказы не
// снимаются; ОС пропала — вывод из работы принят.
METHOD PRIVATE OosRequestWhileRunningByFeedbackRejected
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
