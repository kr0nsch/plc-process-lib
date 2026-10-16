// PV не конечна при xPvValid = TRUE (P-04): в Auto это отказ PV — Failure, бит PV_FAIL, wFault,
// тревога; выход удерживается (Hold), NaN в расчёт не попадает. Годная PV — продолжение без рывка.
METHOD PRIVATE PvNaNTreatedAsInvalid
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим
    stCfg    : ST_PidCfg;         // конфигурация теста
    uBits    : U_RealBits;        // источник NaN
    eStNaN   : E_Ne107Status;     // статус при NaN
    wStsNaN  : WORD;              // wStatus при NaN
    wFltNaN  : WORD;              // wFault при NaN
    wAlmNaN  : WORD;              // wAlmActive при NaN
    rOutNaN  : REAL;              // выход при NaN
END_VAR
