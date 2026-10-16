// Событие перехода тревоги; FALSE — приёмник переполнен (FB_Alarm результат не повторяет)
METHOD OnAlarmEvent : BOOL
VAR_IN_OUT CONSTANT
    // lint:allow STL007 VAR_IN_OUT CONSTANT — параметр, а не константа, см. docs/STATIC_ANALYSIS.md
    stEvent : ST_AlarmEvent;   // событие
END_VAR
