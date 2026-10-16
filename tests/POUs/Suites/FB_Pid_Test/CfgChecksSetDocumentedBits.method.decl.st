// CheckConfig: каждая неверная группа параметров даёт свой бит wCfgErr (карта битов
// docs/fb/FB_PID.md); значения вне строгих перечислений — через объединение U_TestPidEnumInt,
// NaN — через U_RealBits.
METHOD PRIVATE CfgChecksSetDocumentedBits
VAR
    fbTime   : FB_FakeTime;        // подменное время, старт 1 ч
    fbPid    : FB_PID;             // ФБ под тестом
    stCmd    : ST_PidCmd;          // команды
    stRetain : ST_DeviceRetain;    // режим: Manual
    stCfgDef : ST_PidCfg;          // конфигурация по умолчанию
    stCfg    : ST_PidCfg;          // проверяемая конфигурация
    stSlot   : ST_AlarmCfg;        // копия слота тревоги (iec_checker 0.4 не разбирает a[i].x)
    uBad     : U_TestPidEnumInt;   // значение вне перечислений
    uBits    : U_RealBits;         // источник NaN
END_VAR
