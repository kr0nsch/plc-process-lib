// Рампа 10 %/с за 2 с даёт одно и то же положение при шаге 10 мс (200 вызовов) и 100 мс (20 вызовов):
// скорость задана в %/с, шаг — фактический ltDt.
METHOD PRIVATE RampIndependentOfCycleTime
VAR
    fbTimeFast   : FB_FakeTime;          // время клапана с шагом 10 мс
    fbTimeSlow   : FB_FakeTime;          // время клапана с шагом 100 мс
    fbFast       : FB_ControlValve;      // клапан, шаг 10 мс
    fbSlow       : FB_ControlValve;      // клапан, шаг 100 мс
    stCmdFast    : ST_ControlValveCmd;   // команды
    stCmdSlow    : ST_ControlValveCmd;   // команды
    stRetainFast : ST_DeviceRetain;      // режим
    stRetainSlow : ST_DeviceRetain;      // режим
    stCfg        : ST_ControlValveCfg;   // рампа 10 %/с
    iStep        : INT;                  // шаг цикла
END_VAR
