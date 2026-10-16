// Старт ПЛК, ПЧ работает, ОС — из слова состояния, но связи первые 0,5 с нет (мастер Modbus ещё не опросил
// слейв): подхват ждёт первой достоверной ОС — при появлении связи двигатель подхвачен (Running, команда), без
// UncommandedRun и без счёта пуска.
METHOD PRIVATE PlcRestartCommLaterAdoptedWithoutFault
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
