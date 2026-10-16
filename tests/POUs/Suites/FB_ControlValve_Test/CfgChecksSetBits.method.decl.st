// Каждая проверка CheckConfig даёт свой бит wCfgErr: пределы (min < 0, max > 100, min >= max), скорость
// (< 0, NaN), положение безопасности вне 0…100, рассогласование при подключённой ОС (допуск 0, tDev = 0;
// без ОС не проверяется), плотное закрытие (< 0, >= rOutMax), реакция на отказ вне перечисления,
// приоритет тревоги.
METHOD PRIVATE CfgChecksSetBits
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    uBad     : U_TestValveEnum;      // значение вне перечисления
    uBits    : U_RealBits;           // NaN по битам
    stSlot   : ST_AlarmCfg;          // копия слота тревоги
END_VAR
