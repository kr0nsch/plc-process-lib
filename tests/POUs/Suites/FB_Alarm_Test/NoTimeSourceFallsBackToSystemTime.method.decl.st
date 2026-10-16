// Без источника (itfTime = 0) FB_Alarm берёт встроенный FB_SystemTime: тревога без задержки
// появляется сразу, отметка перехода больше 0; задержка 1 ч за время теста не истекает.
METHOD PRIVATE NoTimeSourceFallsBackToSystemTime
VAR
    fbAlm  : FB_Alarm;       // без задержки
    fbAlm2 : FB_Alarm;       // задержка появления 1 ч
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    iStep  : INT;            // шаг цикла
END_VAR
