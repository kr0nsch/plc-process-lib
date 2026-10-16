// Безударный переход Manual -> Auto (Kp = 2, Ti = 10 с, Td = 1 с): ошибка 3 % есть уже в
// Manual, интегратор предустановлен I = u - P - D = 35 - 6 - 0; в момент перехода выход равен
// ручному 35 %, дальше меняется только интегратором; Cmd следит за выходом в Auto.
METHOD PRIVATE ManualToAutoBumpless
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rIManual : REAL;              // интегратор в Manual
    rOutSw   : REAL;              // выход в вызове перехода
END_VAR
