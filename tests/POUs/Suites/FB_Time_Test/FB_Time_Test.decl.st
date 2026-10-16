// Назначение: набор тестов coUnit для времени: F_LTimeToSec, F_TimeToSec, FB_FakeTime,
//             FB_SystemTime, FB_Delay. Время — только FB_FakeTime (две проверки системного
//             времени ничего не ждут). Каждый тест проходит за один вызов метода.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md
FUNCTION_BLOCK FB_Time_Test EXTENDS coUnit.FB_TestSuite
