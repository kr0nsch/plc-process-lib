// Отказ PV в Auto, реакция SafeOut (rSafeOut_pct = 15 %): выход 15 % без рампы; после возврата PV
// регулирование продолжается с 15 % без рывка (шаг инициализации).
METHOD PRIVATE PvFailSafeOutDrivesSafeOutput
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rFail    : REAL;              // выход при отказе
    rResume  : REAL;              // выход в вызове возврата PV
END_VAR
