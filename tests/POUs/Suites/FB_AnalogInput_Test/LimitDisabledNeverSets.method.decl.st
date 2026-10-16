// Выключенные уставки (HH 10 и LL 90 при значении 50) флаги не взводят ни в одном вызове и не проверяются CheckConfig
// (порядок и шкала — только у включённых).
METHOD PRIVATE LimitDisabledNeverSets
VAR
    fbTime   : FB_FakeTime;         // подменное время
    fbAi     : FB_AnalogInput;      // ФБ под тестом
    stCmd    : ST_AnalogInputCmd;   // команды
    stCfg    : ST_AnalogInputCfg;   // конфигурация
    itfAlm   : I_Alarm;             // слот тревоги через интерфейс
    iStep    : INT;                 // шаг цикла
    xEverSet : BOOL;                // флаг взводился хотя бы раз
END_VAR
