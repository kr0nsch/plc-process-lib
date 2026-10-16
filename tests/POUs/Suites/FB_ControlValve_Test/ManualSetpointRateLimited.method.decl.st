// Manual, рост 10 %/с, спад 20 %/с, шаг 0,1 с. Задание 0 -> 50 %: 10 % через 1 с, 49 % на 4,9 с, 50 % на
// 5,0 с (бит RAMPING снят); задание 50 -> 10 %: 30 % через 1 с, 10 % через 2 с. Задание оператора в
// Manual ФБ не переписывает.
METHOD PRIVATE ManualSetpointRateLimited
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    iStep    : INT;                  // шаг цикла
END_VAR
