// Запрос Auto при негодной PV вместе со старшим запросом OutOfService в одном вызове (P-13):
// одна команда — результат старшего (Accepted), uiCmdSeq + 1, оба бита сброшены.
METHOD PRIVATE SetAutoWithOosRequestOneCommand
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим
    stCfg    : ST_PidCfg;         // конфигурация теста
END_VAR
