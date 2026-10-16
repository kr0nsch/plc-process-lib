// Неконечное задание (NaN из Modbus или расчёта): цель остаётся прежней, предупреждение
// PID_WRN_SP_INVALID и общий бит DEV_STS_WARNING; конечное задание снимает предупреждение.
METHOD PRIVATE SetpointNaNHoldsTargetWarns
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: Manual
    stCfg    : ST_PidCfg;         // конфигурация по умолчанию
    uBits    : U_RealBits;        // источник NaN
    rTgtNaN  : REAL;              // цель при NaN
    wWrnNaN  : WORD;              // wWarning при NaN
    wStsNaN  : WORD;              // wStatus при NaN
END_VAR
