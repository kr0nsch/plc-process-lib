// В Auto задание оператора следит за целью (60 %); переход в Manual — задание не прыгает, команда работы
// сохраняется.
METHOD PRIVATE ManualSpeedTracksAutoForBumpless
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
