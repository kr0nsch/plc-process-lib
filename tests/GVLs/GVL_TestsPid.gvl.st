// Назначение: экземпляр набора тестов семейства ПИД. Объявление экземпляра регистрирует набор в
//             coUnit; PRG_Tests его не перечисляет. {attribute 'linkalways'} обязателен
//             (docs/TESTING.md).
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/fb/FB_PID.md
{attribute 'qualified_only'}
{attribute 'linkalways'}
VAR_GLOBAL
    fbPidTest : FB_Pid_Test;   // FB_PID: алгоритм, anti-windup, режимы, задание, отказ PV, контур с FOPDT
END_VAR
