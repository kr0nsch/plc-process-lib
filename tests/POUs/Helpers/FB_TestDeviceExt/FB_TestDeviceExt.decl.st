// Назначение: наследник второго уровня FB_TestDevice для проверок времени выполнения R2 и R3
//             контракта: тело вызывает тело FB_TestDevice через SUPER^ со всеми VAR_IN_OUT,
//             до вызова пишет точку расширения, после — унаследованный stCmd; хук OnModeChanged
//             переопределён ещё раз (виртуальный вызов THIS^ из метода базы). Только для тестов.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md, раздел «Тестовое устройство»
FUNCTION_BLOCK FB_TestDeviceExt EXTENDS FB_TestDevice
VAR_INPUT
    xExtFault : BOOL;            // доп. причина отказа — в точку расширения xFaultAdd до SUPER^
END_VAR
VAR
    uiExtBodyCalls : UINT;       // сколько раз выполнено это тело
    uiExtHookCalls : UINT;       // вызовов этой части хука
END_VAR
