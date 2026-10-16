// Без корректной Cfg с первого вызова (eFailValue и приоритет тревоги вне перечисления): биты DI_CFG_FAIL_VALUE и
// DI_CFG_ALARM, значение FALSE при xIn = TRUE, xValid = FALSE, Available = FALSE, CheckFunction. Исправленная Cfg —
// измерение.
METHOD PRIVATE InvalidCfgAtStartupValueFalseCheckFunction
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    uEnum  : U_AiDiTestEnum;       // значение вне строгого перечисления
    uPrio  : U_TestEnumInt;        // приоритет вне перечисления
END_VAR
