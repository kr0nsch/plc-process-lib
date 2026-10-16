// ShedToManual при слежении не выполняется: регулятор не управляет, выход задаёт механизм. Когда
// слежение снято, а PV всё ещё негодна, — переход в Manual с текущим (отслеженным) выходом.
METHOD PRIVATE PvFailShedToManualDeferredWhileTracking
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    eModeTrk : E_DeviceMode;      // режим через 1 с слежения
END_VAR
