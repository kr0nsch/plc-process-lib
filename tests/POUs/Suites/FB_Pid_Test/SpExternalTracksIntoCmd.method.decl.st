// Внешнее задание: цель — rSpExt_eu (в пределах rSpMin_eu…rSpMax_eu), ФБ пишет её в
// stCmd.rSp_eu; после снятия xSpExt операторское задание продолжается с того же значения.
METHOD PRIVATE SpExternalTracksIntoCmd
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация по умолчанию (задание 0…100)
    rCmdSp1  : REAL;              // stCmd.rSp_eu при внешнем задании 63
    rTgt1    : REAL;              // цель при внешнем задании 63
END_VAR
