// Назначение: экземпляры наборов тестов тревог и базы устройств (этап 2 основы) и зондов времени
//             выполнения. Объявление экземпляра регистрирует набор в coUnit; PRG_Tests их не
//             перечисляет. {attribute 'linkalways'} обязателен (docs/TESTING.md).
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/TESTING.md
{attribute 'qualified_only'}
{attribute 'linkalways'}
VAR_GLOBAL
    fbAlarmTest      : FB_Alarm_Test;        // FB_Alarm: состояния ISA-18.2, задержки, shelve, подавление, OOS, события
    fbDeviceBaseTest : FB_DeviceBase_Test;   // FB_DeviceBase через FB_TestDevice: режимы, LKG, NE 107, тревоги
    fbRuntimeTest    : FB_Runtime_Test;      // вопросы 24.2 контракта, решаемые тестом на Control Win V3
END_VAR
