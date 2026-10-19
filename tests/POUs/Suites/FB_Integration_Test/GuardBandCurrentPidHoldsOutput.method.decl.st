// Датчик уровня выдаёт ток отказа NAMUR, а канал AI читает 3,61 мА (защитная полоса NE 43, AI-13). ПИД (Reverse,
// Auto, задание 5 м, выход 40 %) работает tFailDelay = 2 с по значению насыщения, затем AI снимает xValid — ПИД
// фиксирует отказ PV и удерживает выход (Hold), а не уводит его к 100 % за минуту.
METHOD PRIVATE GuardBandCurrentPidHoldsOutput
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbAi     : FB_AnalogInput;       // LT: уровень 4–20 мА, 0..10 м
    stAiCmd  : ST_AnalogInputCmd;    // его команды
    stAiCfg  : ST_AnalogInputCfg;    // его Cfg
    fbPid    : FB_PID;               // LIC: регулятор уровня
    stPidCmd : ST_PidCmd;            // его команды
    stPidRet : ST_DeviceRetain;      // его режим
    stPidCfg : ST_PidCfg;            // его Cfg
    iStep    : INT;                  // шаг цикла
    rOut5s   : REAL;                 // выход ПИД через 5 с
END_VAR
