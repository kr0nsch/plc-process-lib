// Умолчания astAlarm Cfg всех семи устройств и тестового проходят CheckAlarmCfg (инвариант
// генератора для конфигурации тревог); массивы с границей GVL_Const.DEV_ALARMS_MAX - 1 из DUT
// передаются в параметр ARRAY[0..7]. Приоритет 5 и -1 — отказ, 4 (Critical) — норма.
METHOD PRIVATE DefaultAlarmCfgOfAllTypesPassesCheckAlarmCfg
VAR
    fbDev  : FB_TestDevice;         // доступ к CheckAlarmCfg
    stAi   : ST_AnalogInputCfg;     // умолчания AI
    stDi   : ST_DigitalInputCfg;    // умолчания DI
    stMot  : ST_MotorCfg;           // умолчания двигателя
    stVlv  : ST_ValveCfg;           // умолчания арматуры
    stCv   : ST_ControlValveCfg;    // умолчания регулирующего клапана
    stPid  : ST_PidCfg;             // умолчания ПИД
    stTest : ST_TestDeviceCfg;      // умолчания тестового устройства
    stSlot : ST_AlarmCfg;           // копия слота
    uBad   : U_TestEnumInt;         // число вне перечисления
END_VAR
