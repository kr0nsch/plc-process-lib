// Блокировка (бит 2) при рампе 1 %/с: выход 60 % -> 10 % в том же вызове, мимо рампы и ниже rOutMin
// (20 %); биты SAFE_POS и INTERLOCKED, wInterlock, первопричина 2; xAutoActive = FALSE; задание Manual
// следит за принудительным выходом. После снятия — рампа от 10 %: 11 % через 1 с.
METHOD PRIVATE InterlockSafePosBypassesRamp
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
END_VAR
