// Слежение в Auto (Kp = 2, Ti = 10 с, нижний предел 10 %): выход = rTrack_pct без пределов (0 %),
// интегратор I = u - P - D, бит TRACKING, Cmd следит за выходом; после снятия xTrack выход
// продолжается с 25 % без рывка. Available = FALSE при слежении (PV годна, Auto), TRUE после снятия.
METHOD PRIVATE TrackPresetsIntegratorBumplessRelease
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid     : FB_PID;            // ФБ под тестом
    stCmd     : ST_PidCmd;         // команды
    stRetain  : ST_DeviceRetain;   // режим: Auto из Retain
    stCfg     : ST_PidCfg;         // конфигурация теста
    iStep     : INT;               // шаг цикла
    rOutTrk0  : REAL;              // выход при слежении за 0 %
    xTrkBit0  : BOOL;              // бит TRACKING при слежении
    rOutRel   : REAL;              // выход в вызове снятия слежения
END_VAR
