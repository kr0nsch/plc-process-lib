// Слежение: в Auto ФБ пишет rValue_eu в stCmd.rSubstValue_eu, поэтому подмена начинается с текущего значения 7,0 — даже
// если в том же вызове вход изменился (20 мА).
METHOD PRIVATE SubstitutionStartsFromCurrentValue
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
END_VAR
