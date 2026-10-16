// Слежение задания за PV в Manual (xSpTrackPv) идёт только за годной PV: при обрыве датчика
// (AI держит 0 и снимает xValid) задание оператора и цель остаются последними годными, иначе после
// возврата в Auto регулятор погнал бы процесс к ложному значению.
METHOD PRIVATE SpTrackPvInvalidPvKeepsLastSetpoint
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим
    stCfg    : ST_PidCfg;         // конфигурация теста
    rCmdSpF  : REAL;              // stCmd.rSp_eu при негодной PV
    rTgtF    : REAL;              // цель при негодной PV
END_VAR
