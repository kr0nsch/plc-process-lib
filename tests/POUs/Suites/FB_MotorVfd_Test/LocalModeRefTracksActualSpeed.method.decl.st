// Local: выходы сняты, задание и задание оператора следят за фактической скоростью (42 %); возврат в Manual
// при работающем ПЧ — без рывка задания.
METHOD PRIVATE LocalModeRefTracksActualSpeed
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
