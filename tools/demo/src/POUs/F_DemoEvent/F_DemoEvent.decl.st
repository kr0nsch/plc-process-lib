// Назначение: запись события сценария (действие «оператора», возмущение) в журнал событий
//             GVL_DemoLog для подписей на графиках. Журнал полон — событие не пишется, FALSE.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/media/data/demo-events.csv; tools/demo/README.md
FUNCTION F_DemoEvent : BOOL
VAR_INPUT
    lrT_s     : LREAL;   // время события от старта сценария, с
    iScenario : INT;     // номер сценария: 1 — A, 2 — B, 3 — C
    iCode     : INT;     // код события (по сценарию)
END_VAR
