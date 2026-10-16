// D по измерению (Kp = 1, Td = 5 с, N = 10, без I): ступень задания меняет выход только на P
// (D = 0, «удара» нет), ступень PV на 2 % даёт D = -Kp·Td/(Tf + dt)·2 %.
METHOD PRIVATE DOnMeasurementSetpointStepNoDerivativeKick
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
END_VAR
