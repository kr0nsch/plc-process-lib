// Назначение: экземпляры наборов тестов основы библиотеки (время, утилиты, общие типы).
//             Объявление экземпляра регистрирует набор в coUnit; PRG_Tests их не перечисляет.
//             {attribute 'linkalways'} обязателен: на GVL никто не ссылается, и без атрибута
//             CODESYS 3.5.17 не включает её в приложение — наборы молча не выполняются
//             (проверено зондом, docs/TESTING.md).
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/TESTING.md
{attribute 'qualified_only'}
{attribute 'linkalways'}
VAR_GLOBAL
    fbTimeTest   : FB_Time_Test;     // F_LTimeToSec, F_TimeToSec, FB_FakeTime, FB_SystemTime, FB_Delay
    fbUtilTest   : FB_Util_Test;     // F_IsFinite, F_Ne107Worst, F_RateLimit, FB_StartsWindow, FB_LimitMonitor
    fbCommonTest : FB_Common_Test;   // общие типы: SIZEOF, значения по умолчанию, интерфейсы, FB_TestSink
END_VAR
