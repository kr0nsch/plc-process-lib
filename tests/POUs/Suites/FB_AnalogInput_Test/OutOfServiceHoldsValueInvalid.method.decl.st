// OutOfService: значение удерживается (50 при 16 мА на входе), xValid = FALSE, CheckFunction, флаги уставок сняты, все
// слоты OutOfService; обрыв в OOS не даёт Failure (сигнал не контролируется); слежение пишет удерживаемое значение в
// rSubstValue_eu и в OOS (правило 2.1, AI-10). Выход («Измерение») — измеренное значение 75.
METHOD PRIVATE OutOfServiceHoldsValueInvalid
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
    iStep  : INT;                 // шаг цикла
END_VAR
