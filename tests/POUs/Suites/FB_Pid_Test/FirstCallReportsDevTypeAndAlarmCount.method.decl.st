// Первый вызов: тип устройства Pid в stSts.stCommon.eDevType, один слот тревог (PID_ALARM_COUNT),
// режим из stRetain (Manual по умолчанию), Local не поддерживается (RequestMode(Local) = FALSE).
METHOD PRIVATE FirstCallReportsDevTypeAndAlarmCount
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: Manual
    stCfg    : ST_PidCfg;         // конфигурация по умолчанию
END_VAR
