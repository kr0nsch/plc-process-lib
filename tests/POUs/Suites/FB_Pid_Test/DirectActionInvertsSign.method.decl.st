// Прямое и обратное действие (Kp = 2, без I): при PV на 10 % выше задания обратное действие
// уменьшает выход на 20 %, прямое — увеличивает; знак ошибки в Sts — со знаком действия.
METHOD PRIVATE DirectActionInvertsSign
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPidRev : FB_PID;            // обратное действие
    fbPidDir : FB_PID;            // прямое действие
    stCmdRev : ST_PidCmd;         // команды
    stCmdDir : ST_PidCmd;
    stRetRev : ST_DeviceRetain;   // режим: старт в Manual
    stRetDir : ST_DeviceRetain;
    stCfgRev : ST_PidCfg;         // конфигурация
    stCfgDir : ST_PidCfg;
END_VAR
