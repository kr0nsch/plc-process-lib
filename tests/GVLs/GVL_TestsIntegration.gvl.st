// Назначение: экземпляр набора межсемейных тестов устройств (все семь типов вместе). Объявление
//             экземпляра регистрирует набор в coUnit; PRG_Tests его не перечисляет.
//             {attribute 'linkalways'} обязателен (docs/TESTING.md).
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md, раздел «Межсемейные тесты»
{attribute 'qualified_only'}
{attribute 'linkalways'}
VAR_GLOBAL
    fbIntegrationTest : FB_Integration_Test;   // семь типов устройств: умолчания Cfg, тип, слоты тревог
END_VAR
