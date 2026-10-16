// Назначение: экземпляры наборов тестов семейства двигателей (FB_Motor, FB_MotorVfd). Объявление
//             экземпляра регистрирует набор в coUnit; PRG_Tests их не перечисляет.
//             {attribute 'linkalways'} обязателен (docs/TESTING.md).
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md
{attribute 'qualified_only'}
{attribute 'linkalways'}
VAR_GLOBAL
    fbMotorTest    : FB_Motor_Test;      // FB_Motor: режимы, контроль ОС, отказы, блокировки, времена, счётчики
    fbMotorVfdTest : FB_MotorVfd_Test;   // FB_MotorVfd: задание скорости, связь с ПЧ, рассогласование, интерфейсы
END_VAR
