// Назначение: программа демонстрационного прогона (задача MainTask, 10 мс): общий отсчёт
//             времени от системного источника библиотеки и три независимых сценария на ФБ
//             plc-process-lib 1.0.0.0 — контур уровня (A), классификация NE 43 (B), тревога
//             ISA-18.2 (C). Устройства берут время сами (itfTime не задан — системное время), то
//             есть прогон идёт в реальном времени. Когда все сценарии завершены — xAllDone.
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/media/data/demo-run.json; tools/demo/README.md
PROGRAM PRG_Demo
VAR
    fbClock  : PL.FB_SystemTime;   // системное время библиотеки (монотонное LTIME)
    xStarted : BOOL;               // первый цикл выполнен
    ltStart  : LTIME;              // время старта сценариев
    ltPrev   : LTIME;              // время прошлого цикла
    ltNow    : LTIME;              // время этого цикла
    lrT_s    : LREAL;              // время от старта, с
    lrDt_s   : LREAL;              // шаг цикла, с
    fbLoop   : FB_DemoLevelLoop;   // A: контур уровня
    fbNe43   : FB_DemoNe43;        // B: NE 43
    fbAlarm  : FB_DemoAlarm;       // C: тревога ISA-18.2
END_VAR
