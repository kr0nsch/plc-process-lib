// Номера и значения событий: udiAlarmIdBase 120 — тревога HH = 120, Failure = 124; значение события HH — rValue_eu
// (95), Failure — сырое rIn (22,5 мА).
METHOD PRIVATE AlarmEventsFailureValueIsRawInput
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    fbSink : FB_TestSink;         // приёмник событий
    stEv   : ST_AlarmEvent;       // событие
END_VAR
