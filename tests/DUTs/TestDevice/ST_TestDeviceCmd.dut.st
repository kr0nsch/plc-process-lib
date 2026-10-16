// Назначение: команды тестового устройства FB_TestDevice — общий заголовок и команды механизма,
//             как у ST_<Dev>Cmd библиотеки. Только для тестов.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md, раздел «Тестовое устройство»
{attribute 'qualified_only'}
TYPE ST_TestDeviceCmd :
STRUCT
    stCommon : ST_DeviceCmd;   // общий заголовок
    xStart   : BOOL;           // импульс: пуск (Manual)
    xStop    : BOOL;           // импульс: стоп (в Auto — переход в Manual и стоп)
    uiTrace  : UINT;           // пишет тело наследника FB_TestDeviceExt после SUPER^ (проверка R3)
END_STRUCT
END_TYPE
