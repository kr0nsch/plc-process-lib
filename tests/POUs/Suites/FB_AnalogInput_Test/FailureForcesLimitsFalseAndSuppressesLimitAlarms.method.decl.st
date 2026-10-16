// H 4,0 активна (4,25 м); обрыв: пока отказ не подтверждён, H держится по удержанному значению, ложного LL (0,5) нет;
// после подтверждения флаги сняты, тревога H — SuppressedByDesign, тревога Failure — ActiveUnack.
METHOD PRIVATE FailureForcesLimitsFalseAndSuppressesLimitAlarms
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
    iStep  : INT;                 // шаг цикла
END_VAR
