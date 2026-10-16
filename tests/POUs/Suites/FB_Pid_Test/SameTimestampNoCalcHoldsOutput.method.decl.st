// Второй вызов в тот же момент (dt = 0; P-02): расчёта нет — выход и D прежние, хотя PV
// изменилась; следующий шаг учитывает изменение PV один раз. Расчёт с нулевым шагом дал бы
// всплеск D = Kp·Td/Tf·ΔPV = 10 %.
METHOD PRIVATE SameTimestampNoCalcHoldsOutput
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rOutBef  : REAL;              // выход до вызова с тем же временем
    rDBef    : REAL;              // D до него
    rOutSame : REAL;              // выход в вызове с тем же временем
    rDSame   : REAL;              // D в нём
END_VAR
