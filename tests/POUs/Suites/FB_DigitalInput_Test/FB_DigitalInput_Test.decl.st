// Назначение: набор тестов coUnit для FB_DigitalInput: задержки включения и отключения (дребезг),
//             инверсия до задержек, подмена и её срок, отказ канала (ForceTrue, ForceFalse,
//             HoldLast), тревоги State и Failure, OutOfService, конфигурация. Время — только
//             FB_FakeTime.
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/fb/FB_DigitalInput.md
FUNCTION_BLOCK FB_DigitalInput_Test EXTENDS coUnit.FB_TestSuite
