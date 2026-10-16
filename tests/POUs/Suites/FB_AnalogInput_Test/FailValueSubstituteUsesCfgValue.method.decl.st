// eFailValue = Substitute: до подтверждения отказа держится последнее хорошее значение (25), после — rFailValue_eu =
// 99, xValid = FALSE.
METHOD PRIVATE FailValueSubstituteUsesCfgValue
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
END_VAR
