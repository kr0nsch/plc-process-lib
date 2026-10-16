// Отказ позиционера с реакцией Hold (по умолчанию): выход удерживается (40 %) при смене задания, бита
// SAFE_POS нет; отказ ушёл — выход к заданию 70 %.
METHOD PRIVATE PositionerFaultHoldAction
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
END_VAR
