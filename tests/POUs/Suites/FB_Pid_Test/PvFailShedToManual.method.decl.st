// Отказ PV в Auto, реакция ShedToManual: ФБ переходит в Manual (и в stRetain) с текущим выходом,
// stCmd.rManualOut_pct уже равен выходу; в Manual отказ PV — не Failure.
METHOD PRIVATE PvFailShedToManual
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
END_VAR
