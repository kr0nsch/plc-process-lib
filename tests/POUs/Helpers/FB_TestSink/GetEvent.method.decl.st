// Событие, записанное uiBack событий назад (0 — последнее); нет такого — пустое событие
METHOD PUBLIC GetEvent : ST_AlarmEvent
VAR_INPUT
    uiBack : UINT;             // сколько событий назад
END_VAR
VAR
    stNone : ST_AlarmEvent;    // пустое событие
END_VAR
