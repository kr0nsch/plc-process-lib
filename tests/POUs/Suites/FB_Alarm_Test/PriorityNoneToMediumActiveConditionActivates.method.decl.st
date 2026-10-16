// Включение выключенной тревоги при активном условии: приоритет None → Medium даёт Activated в
// том же вызове (без задержки); с tOnDelay 1 с — через 1 с после включения.
METHOD PRIVATE PriorityNoneToMediumActiveConditionActivates
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // без задержки
    fbAlm2 : FB_Alarm;       // с задержкой появления
    stCfg  : ST_AlarmCfg;    // приоритет None, затем Medium
    iStep  : INT;            // шаг цикла
END_VAR
