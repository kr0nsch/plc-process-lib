// Назначение: экземпляры наборов тестов семейства арматуры (FB_Valve, FB_ControlValve).
//             Объявление экземпляра регистрирует набор в coUnit; PRG_Tests их не перечисляет.
//             {attribute 'linkalways'} обязателен: на GVL никто не ссылается, и без атрибута
//             CODESYS 3.5.17 не включает её в приложение — наборы молча не выполняются
//             (docs/TESTING.md).
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md
{attribute 'qualified_only'}
{attribute 'linkalways'}
VAR_GLOBAL
    fbValveTest        : FB_Valve_Test;          // FB_Valve: ход, концевики, реверс, соленоиды, блокировки, режимы
    fbControlValveTest : FB_ControlValve_Test;   // FB_ControlValve: рампа, пределы, рассогласование, безопасность
END_VAR
