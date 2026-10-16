// Плотное закрытие 5 %: задание 4 % — выход 0 % (бит TIGHT_SHUT, 4 мА), 6 % — 6 %. Рампа не залипает под
// порогом: рост 1 %/с, задание 20 %: на 4,5 с выход 0 % (рампа 4,5 %), на 5,0 с — 5 %, на 10 с — 10 %.
METHOD PRIVATE TightShutBelowThresholdGivesZero
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    iStep    : INT;                  // шаг цикла
END_VAR
