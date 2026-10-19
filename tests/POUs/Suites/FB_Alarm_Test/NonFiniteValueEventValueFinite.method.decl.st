// Значение процесса NaN в момент перехода (PV из Modbus): rValue события конечно — 0.0 (R6: приёмник журнала и SQL
// не получают NaN); конечное значение передаётся как есть.
METHOD PRIVATE NonFiniteValueEventValueFinite
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // умолчания (Medium)
    fbSink : FB_TestSink;    // приёмник событий
    stEv1  : ST_AlarmEvent;  // событие при NaN
    stEv2  : ST_AlarmEvent;  // событие при конечном значении
    uBits  : U_RealBits;     // NaN по битам
END_VAR
