// Cfg испорчена в работе (скорость < 0): бит CV_CFG_RATE и CheckFunction, рампа продолжается по
// последней корректной Cfg (10 %/с): 10 % через 1 с.
METHOD PRIVATE InvalidCfgAtRuntimeKeepsLastValid
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    iStep    : INT;                  // шаг цикла
END_VAR
