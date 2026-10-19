// Назначение: экземпляры наборов тестов семейства входов (FB_AnalogInput, FB_DigitalInput).
//             Объявление экземпляра регистрирует набор в coUnit; PRG_Tests их не перечисляет.
//             {attribute 'linkalways'} обязателен: без него CODESYS 3.5.17 не включает GVL в
//             приложение, и наборы молча не выполняются (docs/TESTING.md).
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/TESTING.md
{attribute 'qualified_only'}
{attribute 'linkalways'}
VAR_GLOBAL
    fbAnalogInputTest  : FB_AnalogInput_Test;    // FB_AnalogInput: масштабирование, NE 43, фильтр, уставки, подмена
    fbDigitalInputTest : FB_DigitalInput_Test;   // FB_DigitalInput: задержки, инверсия, подмена, отказ канала
END_VAR
