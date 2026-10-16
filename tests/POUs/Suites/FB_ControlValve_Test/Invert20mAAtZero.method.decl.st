// Инверсия выхода: 0 % — 20 мА, 25 % — 16 мА, 100 % — 4 мА; без инверсии 25 % — 8 мА. Ток — и в выходе,
// и в Sts.
METHOD PRIVATE Invert20mAAtZero
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
END_VAR
