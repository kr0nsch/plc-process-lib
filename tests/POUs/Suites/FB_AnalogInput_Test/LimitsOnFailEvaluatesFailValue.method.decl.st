// xLimitsOnFail = TRUE и Substitute 95: после подтверждения отказа уставки считаются по значению отказа — HH (90)
// взводится, тревога HH не подавлена (ActiveUnack). Так проектировщик задаёт безопасную реакцию на отказ датчика.
METHOD PRIVATE LimitsOnFailEvaluatesFailValue
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
    iStep  : INT;                 // шаг цикла
END_VAR
