// Значение события тревог дискретного входа — xValue как 1.0 / 0.0 (DI-7): State при xValue = TRUE — Activated со
// значением 1.0, снятие — Cleared со значением 0.0; номер тревоги State = udiAlarmIdBase + 0.
METHOD PRIVATE AlarmEventsValueIsZeroOrOne
VAR
    fbTime  : FB_FakeTime;          // подменное время
    fbDi    : FB_DigitalInput;      // ФБ под тестом
    stCmd   : ST_DigitalInputCmd;   // команды
    stCfg   : ST_DigitalInputCfg;   // конфигурация
    fbSink  : FB_TestSink;          // приёмник событий
    stEvOn  : ST_AlarmEvent;        // событие появления
    stEvOff : ST_AlarmEvent;        // событие снятия
END_VAR
