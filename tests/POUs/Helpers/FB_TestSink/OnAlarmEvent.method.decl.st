// Записать событие в кольцо (самое старое затирается); приёмник не переполняется — TRUE
METHOD PUBLIC OnAlarmEvent : BOOL
VAR_IN_OUT CONSTANT
    // lint:allow STL007 VAR_IN_OUT CONSTANT — параметр, а не константа, см. docs/STATIC_ANALYSIS.md
    stEvent : ST_AlarmEvent;   // событие
END_VAR
