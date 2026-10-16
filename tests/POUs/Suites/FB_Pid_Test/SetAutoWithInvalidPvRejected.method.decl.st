// Запрос Auto при негодной PV (бит xSetAuto и RequestMode) отклоняется до ProcessMode:
// RejectedFault, бит снят, режим остаётся Manual, каждая команда даёт +1 к uiCmdSeq.
METHOD PRIVATE SetAutoWithInvalidPvRejected
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация по умолчанию
    xReqOk   : BOOL;              // ответ RequestMode
END_VAR
