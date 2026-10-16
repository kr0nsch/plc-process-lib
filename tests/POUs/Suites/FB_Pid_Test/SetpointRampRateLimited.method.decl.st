// Рампа задания 2 инж. ед./с: ступень операторского задания 40 -> 60 проходится за 10 с; через
// 5 с действующее задание 50 и бит SP_RAMPING, через 10 с — 60 и бит снят; цель — сразу 60.
METHOD PRIVATE SetpointRampRateLimited
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rSp5     : REAL;              // задание через 5 с
    wSts5    : WORD;              // wStatus через 5 с
    rTgt5    : REAL;              // цель через 5 с
END_VAR
