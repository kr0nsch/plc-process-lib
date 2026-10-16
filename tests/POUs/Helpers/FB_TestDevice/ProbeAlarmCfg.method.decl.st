// Открывает защищённый CheckAlarmCfg для тестов: проверка массива ST_AlarmCfg любой Cfg устройства
METHOD PUBLIC ProbeAlarmCfg : BOOL
VAR_IN_OUT CONSTANT
    // lint:allow STL007 VAR_IN_OUT CONSTANT массив a<префикс>, см. docs/STATIC_ANALYSIS.md
    astCfgIn : ARRAY[0..7] OF ST_AlarmCfg;   // проверяемый массив
END_VAR
