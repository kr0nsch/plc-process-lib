// SIZEOF(ST_AlarmCfg) = 16 (зонд Q14 контракта) и SIZEOF(ST_AiLimitCfg) = 20: элементы массивов
// astAlarm и astLimit в persistent-данных. Источник: tools/reference/common.py, сценарий cfg_sizes.
METHOD PRIVATE SizeOfAlarmCfgIs16
VAR
    stAlm : ST_AlarmCfg;           // параметры тревоги
    stLim : ST_AiLimitCfg;         // параметры уставки
END_VAR
