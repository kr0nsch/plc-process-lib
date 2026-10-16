// Все семь типов доступны через I_Device (интерфейс станции и SCADA-адаптера): число слотов тревог
// AlarmCount (I_AlarmSource) после первого вызова равно <DEV>_ALARM_COUNT из GVL_Const, слот 0
// доступен через GetAlarm, режим — из перечисления. У FB_Motor и FB_MotorVfd слотов одинаково (8).
METHOD PRIVATE AllTypesAlarmCountThroughIDevice
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
    aitfDev  : ARRAY[1..7] OF I_Device;   // устройства через интерфейс
    auiSlots : ARRAY[1..7] OF UINT;       // ожидаемое число слотов
    uiDev    : UINT;                      // номер устройства
    itfAlm   : I_Alarm;                   // слот 0 устройства
    xCountOk : BOOL := TRUE;              // у всех AlarmCount совпал
    xSlotOk  : BOOL := TRUE;              // у всех слот 0 доступен
    xModeOk  : BOOL := TRUE;              // у всех режим из перечисления
END_VAR
