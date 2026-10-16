// Cfg по умолчанию проходит CheckConfig (wCfgErr = 0); после первого вызова — Auto («Измерение»), тип AnalogInput, 6
// слотов тревог, Good, бит DEV_STS_MODE_AUTO; седьмого слота нет; Local не запрашивается.
METHOD PRIVATE DefaultCfgFirstCallAutoTypeAndSlots
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
END_VAR
