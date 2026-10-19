// Помощник: uiN циклов контура уровня по примеру 17.3 контракта, перед каждым — шаг подменного времени tDt
// (T#0S — тот же момент): ведущий насос (прошлый вызов) -> AI -> ПИД (xTrack := NOT SpeedAutoActive,
// rTrack = rOutAct = SpeedRef) -> задание ПЧ -> ПЧ -> модель ПЧ (работает по команде, скорость = заданию).
// Ассертов внутри нет
METHOD PRIVATE LevelLoopStep
VAR_IN_OUT
    fbT      : FB_FakeTime;          // подменное время
    fbAi     : FB_AnalogInput;       // датчик уровня
    stAiCmd  : ST_AnalogInputCmd;    // его команды
    fbPid    : FB_PID;               // регулятор уровня
    stPidCmd : ST_PidCmd;            // его команды
    stPidRet : ST_DeviceRetain;      // его режим
    fbVfd    : FB_MotorVfd;          // ведущий насос
    stVfdCmd : ST_MotorCmd;          // его команды
    stVfdRet : ST_DeviceRetain;      // его режим и счётчики
END_VAR
VAR_IN_OUT CONSTANT
    stAiCfg  : ST_AnalogInputCfg;    // Cfg датчика
    stPidCfg : ST_PidCfg;            // Cfg регулятора
    stVfdCfg : ST_MotorCfg;          // Cfg насоса
END_VAR
VAR_INPUT
    rLevel_mA : REAL;                // ток датчика уровня, мА
    uiN       : UINT;                // число циклов
    tDt       : TIME;                // шаг времени перед каждым циклом
END_VAR
VAR
    uiLoop    : UINT;                // номер цикла
    xLeadAuto : BOOL;                // ведущий насос в Auto и работает (прошлый цикл)
    rLeadRef  : REAL;                // задание ведущего насоса (прошлый цикл), %
END_VAR
