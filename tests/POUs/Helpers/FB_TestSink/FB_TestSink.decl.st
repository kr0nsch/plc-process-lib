// Назначение: тестовый приёмник событий тревог (I_AlarmSink): кольцо на 32 события.
//             Подставляется в GVL_Lib.itfAlarmSink только в тестах, которым нужны события;
//             тест возвращает GVL_Lib.itfAlarmSink := 0 до coUnit.TEST_FINISHED().
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md, раздел «Вспомогательные ФБ»
FUNCTION_BLOCK FB_TestSink IMPLEMENTS I_AlarmSink
VAR CONSTANT
    EVENTS_MAX : UINT := 32;                   // ёмкость кольца
END_VAR
VAR
    astEvent : ARRAY[0..EVENTS_MAX - 1] OF ST_AlarmEvent;  // кольцо событий
    uiNext   : UINT;                           // индекс следующей записи
    uiCount  : UINT;                           // событий с последнего Clear (не больше UINT_MAX)
END_VAR
