// Старт ПЛК в Auto (режим из stRetain) с xUseOutAct: stCmd.rManualOut_pct = 0 (GVL_Hmi после
// потери питания не сохраняется), механизм стоит на 37 % — выход первого вызова берётся из
// rOutAct_pct, интегратор инициализируется под него (I = 37 - 8 = 29 %), и регулирование идёт от
// 37 % без провала в ноль. Второй экземпляр: rOutAct_pct не конечен — выход из rManualOut_pct.
METHOD PRIVATE StartupOutActInitialisesOutput
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid     : FB_PID;            // ФБ под тестом: rOutAct_pct = 37 %
    fbPidNaN  : FB_PID;            // второй экземпляр: rOutAct_pct не конечен
    stCmd     : ST_PidCmd;         // команды: rManualOut_pct = 0
    stCmdNaN  : ST_PidCmd;         // команды второго экземпляра: rManualOut_pct = 42 %
    stRetain  : ST_DeviceRetain;   // режим Auto из Persistent Variables
    stRetNaN  : ST_DeviceRetain;   // то же для второго экземпляра
    stCfg     : ST_PidCfg;         // конфигурация теста
    uBits     : U_RealBits;        // источник NaN
    iStep     : INT;               // шаг цикла
    rOutSt    : REAL;              // выход первого вызова
    rISt      : REAL;              // интегратор первого вызова
    rCmdOutSt : REAL;              // stCmd.rManualOut_pct после первого вызова
END_VAR
