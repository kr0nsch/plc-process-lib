// Обрыв уже в первом вызове: удерживать нечего — значение 0.0 и xValid = FALSE сразу (не «годный ноль»), ложного LL
// нет, NE 107 Good до подтверждения; бита AI_STS_FAIL_PENDING нет — значение не удерживается как годное; через 2 с —
// Failure; после возврата и подтверждения — измеренное значение.
METHOD PRIVATE StartupWireBreakInvalidUntilFirstGoodValue
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
END_VAR
