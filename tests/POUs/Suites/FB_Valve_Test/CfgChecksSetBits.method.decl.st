// Каждая проверка CheckConfig даёт свой бит wCfgErr: тип вне перечисления; tTravel = 0; Stay у соленоида
// и eSafePos вне перечисления; закрытие по моменту без муфты и муфта у соленоида; tReverse = 0 у
// Motorized (у соленоида допустим); tResetWindow = 0; приоритет тревоги вне перечисления.
METHOD PRIVATE CfgChecksSetBits
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    uBad     : U_TestValveEnum;   // значения вне строгих перечислений
    stSlot   : ST_AlarmCfg;       // копия слота тревоги
END_VAR
