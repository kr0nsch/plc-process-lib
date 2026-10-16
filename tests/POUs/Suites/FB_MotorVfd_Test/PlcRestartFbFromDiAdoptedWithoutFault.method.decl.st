// Старт ПЛК, ОС по DI (xFbFromComm = FALSE), слово состояния ПЧ ещё не прочитано: в первом вызове точки
// расширения берут корректную stCfg, а не умолчания — двигатель подхвачен, UncommandedRun нет.
METHOD PRIVATE PlcRestartFbFromDiAdoptedWithoutFault
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
