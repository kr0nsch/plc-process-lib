// Каждый тип пишет свой E_DeviceType в stSts.stCommon.eDevType с первого вызова (SCADA выбирает
// фейсплейт, генератор карты Modbus сверяет тип блока); до первого вызова — None. FB_MotorVfd
// сообщает MotorVfd, а не Motor: FB_Motor тип наследника не затирает и во втором вызове.
METHOD PRIVATE DevTypeReportedInStsCommon
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbAi     : FB_AnalogInput;       // аналоговый вход
    stAiCmd  : ST_AnalogInputCmd;    // его команды
    stAiCfg  : ST_AnalogInputCfg;    // его Cfg (умолчания)
    fbDi     : FB_DigitalInput;      // дискретный вход
    stDiCmd  : ST_DigitalInputCmd;   // его команды
    stDiCfg  : ST_DigitalInputCfg;   // его Cfg (умолчания)
    fbMot    : FB_Motor;             // двигатель прямого пуска
    stMotCmd : ST_MotorCmd;          // его команды
    stMotRet : ST_DeviceRetain;      // его retain
    stMotCfg : ST_MotorCfg;          // его Cfg (умолчания)
    fbVfd    : FB_MotorVfd;          // двигатель с ПЧ
    stVfdCmd : ST_MotorCmd;          // его команды
    stVfdRet : ST_DeviceRetain;      // его retain
    stVfdCfg : ST_MotorCfg;          // его Cfg (умолчания, с полем stVfd)
    fbVlv    : FB_Valve;             // запорная арматура
    stVlvCmd : ST_ValveCmd;          // её команды
    stVlvRet : ST_DeviceRetain;      // её retain
    stVlvCfg : ST_ValveCfg;          // её Cfg (умолчания)
    fbCv     : FB_ControlValve;      // регулирующий клапан
    stCvCmd  : ST_ControlValveCmd;   // его команды
    stCvRet  : ST_DeviceRetain;      // его retain
    stCvCfg  : ST_ControlValveCfg;   // его Cfg (умолчания)
    fbPid    : FB_PID;               // ПИД-регулятор
    stPidCmd : ST_PidCmd;            // его команды
    stPidRet : ST_DeviceRetain;      // его retain
    stPidCfg : ST_PidCfg;            // его Cfg (умолчания)
END_VAR
