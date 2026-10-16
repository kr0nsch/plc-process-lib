// Клапан не двигается (ОС 0 %), задание 0 -> 50 % с рампой 1 %/с (50 с): во время рампы рассогласование
// не контролируется. После конца рампы предупреждение — ровно через tDev = 10 с (на 9 с ещё нет).
METHOD PRIVATE DeviationDuringRampIgnored
VAR
    fbTime    : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv      : FB_ControlValve;      // клапан под тестом
    stCmd     : ST_ControlValveCmd;   // команды HMI
    stRetain  : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg     : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    iStep     : INT;                  // шаг цикла
    xEverWarn : BOOL;                 // предупреждение было во время рампы
END_VAR
