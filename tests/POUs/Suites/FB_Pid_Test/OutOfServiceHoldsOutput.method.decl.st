// OutOfService: выход удерживается при любой PV, расчёта нет, Cmd следит за выходом, CheckFunction;
// выход в Auto — шаг инициализации без бита DT_GAP, регулирование продолжается с удержанного
// выхода без рывка.
METHOD PRIVATE OutOfServiceHoldsOutput
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rOutOos  : REAL;              // выход в вызове входа в OOS
    eResOos  : E_CmdResult;       // результат xSetOos
    rOutExit : REAL;              // выход в вызове выхода из OOS
    wWrnExit : WORD;              // wWarning в вызове выхода
END_VAR
