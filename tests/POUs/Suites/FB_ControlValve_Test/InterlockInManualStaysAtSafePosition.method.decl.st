// Manual, задание оператора 70 %. Блокировка: выход сразу в положение безопасности 15 %, задание
// Manual следит за ним (оператор не управляет выходом). Блокировка снята: Manual остаётся в 15 % —
// клапан сам к прежнему заданию оператора не уходит (CV-6, как у FB_Valve и двигателя).
METHOD PRIVATE InterlockInManualStaysAtSafePosition
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
END_VAR
