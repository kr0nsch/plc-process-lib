// OutOfService: выход удерживается (40 %), задание, блокировка и отказ позиционера не действуют, задание
// Manual следит за удерживаемым выходом, NE 107 CheckFunction.
METHOD PRIVATE OutOfServiceHoldsOutput
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
END_VAR
