// Auto 70 %: задание Manual следит (70 %). Переход в Manual при задании автоматики 20 %: выход остаётся
// 70 %, xAutoActive = FALSE; задание оператора 60 % — рампа 5 %/с от 70 %: 65 % через 1 с.
METHOD PRIVATE AutoToManualBumpless
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    iStep    : INT;                  // шаг цикла
END_VAR
