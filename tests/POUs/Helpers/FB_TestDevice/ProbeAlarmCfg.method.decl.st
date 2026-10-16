// Открывает защищённый CheckAlarmCfg для тестов: проверка массива ST_AlarmCfg любой Cfg устройства
METHOD PUBLIC ProbeAlarmCfg : BOOL
VAR_IN_OUT CONSTANT
    astCfgIn : ARRAY[0..GVL_Const.DEV_ALARMS_MAX - 1] OF ST_AlarmCfg;   // проверяемый массив
END_VAR
