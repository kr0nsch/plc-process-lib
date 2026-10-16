// Вход в OutOfService из ActiveUnack снимает неквитированность; при выходе с активным условием
// тревога снова ActiveUnack, без условия — Normal.
METHOD PRIVATE OosEntryClearsUnackReannunciatesOnExit
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // с активным условием
    fbAlm2 : FB_Alarm;       // условие уходит во время OutOfService
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
END_VAR
