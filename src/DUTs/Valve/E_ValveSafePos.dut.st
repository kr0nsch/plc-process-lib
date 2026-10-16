// Назначение: куда вести арматуру по защитной блокировке.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/fb/FB_Valve.md
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE E_ValveSafePos :
(
    Closed := 0,   // закрыть
    Open   := 1,   // открыть
    Stay   := 2    // остановить (только Motorized)
) INT;
END_TYPE
