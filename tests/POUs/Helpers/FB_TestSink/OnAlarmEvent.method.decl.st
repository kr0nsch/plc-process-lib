// Записать событие в кольцо (самое старое затирается); приёмник не переполняется — TRUE
METHOD PUBLIC OnAlarmEvent : BOOL
VAR_IN_OUT CONSTANT
    stEvent : ST_AlarmEvent;   // событие
END_VAR
