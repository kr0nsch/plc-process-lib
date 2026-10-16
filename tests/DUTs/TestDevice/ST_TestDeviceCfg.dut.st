// Назначение: конфигурация тестового устройства FB_TestDevice. Заканчивается полями тревог, как
//             ST_<Dev>Cfg библиотеки (udiAlarmIdBase, astAlarm). Значения по умолчанию проходят
//             CheckConfig. Только для тестов.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md, раздел «Тестовое устройство»
{attribute 'qualified_only'}
TYPE ST_TestDeviceCfg :
STRUCT
    rGain          : REAL := 2.0;    // коэффициент; корректен, если конечен и > 0 (бит 0 wCfgErr)
    tRunDelay      : TIME := T#0S;   // задержка включения в Auto (вложенный FB_Delay до BeginCycle)
    udiAlarmIdBase : UDINT := 0;     // номер первой тревоги устройства
    astAlarm       : ARRAY[0..GVL_Const.DEV_ALARMS_MAX - 1] OF ST_AlarmCfg;   // по слотам; умолчания ST_AlarmCfg
END_STRUCT
END_TYPE
