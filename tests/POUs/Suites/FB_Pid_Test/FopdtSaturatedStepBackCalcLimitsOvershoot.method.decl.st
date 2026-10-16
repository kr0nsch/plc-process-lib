// Насыщение в замкнутом контуре: тот же объект и ПИД, предел выхода 30 %, ступень задания 0 -> 40,
// 60 с. С обратным расчётом (Tt = авто) выход раньше уходит с предела и перерегулирования нет;
// без него (Tt = 1·10^6 с) интегратор накапливается, перерегулирование около 9 %.
METHOD PRIVATE FopdtSaturatedStepBackCalcLimitsOvershoot
VAR
    fbTime     : FB_FakeTime;       // подменное время, старт 1 ч
    fbPidAw    : FB_PID;            // ФБ под тестом: Tt = авто
    fbPidNoAw  : FB_PID;            // сравнение: Tt = 1e6 с
    fbPlantAw  : FB_FopdtModel;     // модели объекта
    fbPlantNo  : FB_FopdtModel;
    stCmdAw    : ST_PidCmd;         // команды
    stCmdNoAw  : ST_PidCmd;
    stRetAw    : ST_DeviceRetain;   // режим: Auto из Retain
    stRetNoAw  : ST_DeviceRetain;
    stCfgAw    : ST_PidCfg;         // конфигурация
    stCfgNoAw  : ST_PidCfg;
    iStep      : INT;               // шаг модели (0,1 с)
    rPeakAw    : REAL;              // максимум PV
    rPeakNoAw  : REAL;
    xSatAw     : BOOL;              // выход был на пределе
    xSatNoAw   : BOOL;
    rUnsatAw   : REAL;              // когда выход ушёл с предела, с
    rUnsatNoAw : REAL;
END_VAR
