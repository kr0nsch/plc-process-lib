// Неконечное задание держит прежнюю цель, но и она остаётся в пределах задания: задание NaN уже
// в первом вызове (связь со SCADA ещё не поднялась) даёт цель rSpMin_eu, а не 0 вне пределов;
// сужение пределов наладчиком, пока задание неконечно, ограничивает удерживаемую цель.
METHOD PRIVATE SetpointNaNHeldTargetWithinSpLimits
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: Manual
    stCfg    : ST_PidCfg;         // пределы задания 20…80
    uBits    : U_RealBits;        // источник NaN
    rTgtStart : REAL;             // цель в первом вызове при NaN
    rSpStart  : REAL;             // действующее задание в первом вызове
    rTgtValid : REAL;             // цель при задании 70
    rTgtHeld  : REAL;             // цель при NaN после 70
END_VAR
