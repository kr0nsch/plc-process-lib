// xAlarmOnTrue = FALSE (тревога при пропадании сигнала, например «давление в норме»): TRUE — тревоги нет; FALSE —
// тревога State ActiveUnack, бит DI_STS_ALARM_COND, приоритет в ePrioUnack.
METHOD PRIVATE AlarmOnFalseActivatesWhenValueFalse
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    itfAlm : I_Alarm;              // слот тревоги через интерфейс
END_VAR
