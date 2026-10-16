// Пределы 10…90 %: задание Manual 95 % — выход 90 % (бит LIMITED_MAX), 5 % — 10 % (LIMITED_MIN); в Auto
// 120 % — 90 %, 55 % — без ограничения. rPosSp_pct — задание после пределов.
METHOD PRIVATE OutputLimitsClamp
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    wLimBits : WORD;                 // биты LIMITED_MIN и LIMITED_MAX
END_VAR
