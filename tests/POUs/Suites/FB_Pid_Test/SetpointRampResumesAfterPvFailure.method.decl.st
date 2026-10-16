// Рампа задания (2 инж. ед./с, 40 -> 60) и недостоверная PV: пока PV негодна, расчёта нет и
// действующее задание стоит (44); возврат PV — шаг инициализации с dt = 0, рампа продолжается с
// 44 (не прыгает к цели 60) и через 1 с даёт 46. Бит SP_RAMPING остаётся, пока задание не у цели.
METHOD PRIVATE SetpointRampResumesAfterPvFailure
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid     : FB_PID;            // ФБ под тестом
    stCmd     : ST_PidCmd;         // команды
    stRetain  : ST_DeviceRetain;   // режим: Manual
    stCfg     : ST_PidCfg;         // конфигурация теста
    iStep     : INT;               // шаг цикла
    rSp2      : REAL;              // задание через 2 с
    rSpFail   : REAL;              // задание после 1 с с негодной PV
    rSpResume : REAL;              // задание в вызове возврата PV
    wStsRes   : WORD;              // wStatus в вызове возврата PV
END_VAR
