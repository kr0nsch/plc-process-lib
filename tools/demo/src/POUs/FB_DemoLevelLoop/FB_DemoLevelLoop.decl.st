// Назначение: сценарий A демонстрационного прогона — контур уровня по примеру 17.3 контракта:
//             LT (PL.FB_AnalogInput, 4–20 мА, 0..5 м) -> LIC (PL.FB_PID, Direct, обратный расчёт
//             по фактическому заданию ПЧ) -> насос с ПЧ (PL.FB_MotorVfd, мин. 20 %). Объект —
//             модель ёмкости на ST: баланс объёма, подача насоса пропорциональна скорости, ПЧ
//             разгоняется с рампой. Сценарий: 5 с — пуск насоса (слежение ПИД снимается без
//             рывка); 40 с — задание 2,5 -> 1,5 м (выход упирается в 100 %, интегратор не
//             накапливается); 95 с — приток 120 -> 210 м3/ч. Ёмкость и параметры вымышленные.
//             Коды событий: 1 — пуск насоса, 2 — ступень задания, 3 — ступень притока.
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/API.md, пример 17.3; tools/demo/README.md
FUNCTION_BLOCK FB_DemoLevelLoop
VAR_INPUT
    lrT_s  : LREAL;   // время от старта сценария, с
    lrDt_s : LREAL;   // шаг времени этого цикла, с
END_VAR
VAR_OUTPUT
    xDone : BOOL;     // сценарий завершён, журнал записан
END_VAR
VAR CONSTANT
    LEVEL_SPAN_M   : REAL := 5.0;       // шкала датчика: 4 мА = 0 м, 20 мА = 5 м
    MA_LO          : REAL := 4.0;       // ток начала шкалы, мА
    MA_SPAN        : REAL := 16.0;      // диапазон тока шкалы, мА
    AREA_M2        : LREAL := 1.5;      // площадь сечения ёмкости, м2
    LEVEL0_M       : LREAL := 2.3;      // начальный уровень, м
    Q_PUMP_MAX_M3H : REAL := 300.0;     // подача насоса при 100 % скорости, м3/ч (линейная модель)
    Q_IN_BASE_M3H  : REAL := 120.0;     // приток до возмущения, м3/ч
    Q_IN_SURGE_M3H : REAL := 210.0;     // приток после возмущения, м3/ч
    VFD_RAMP_PCTPS : REAL := 25.0;      // рампа ПЧ (модель привода), %/с
    S_PER_H        : LREAL := 3600.0;   // секунд в часе
    PCT_FULL       : REAL := 100.0;     // 100 %
    SP0_M          : REAL := 2.5;       // задание до ступени, м
    SP1_M          : REAL := 1.5;       // задание после ступени, м
    T_START_S      : LREAL := 5.0;      // пуск насоса (xAutoRun), с
    T_SP_STEP_S    : LREAL := 40.0;     // ступень задания, с
    T_SURGE_S      : LREAL := 95.0;     // ступень притока, с
    PID_KP         : REAL := 12.0;      // коэффициент усиления, %/%
    PID_TI_S       : REAL := 80.0;      // время интегрирования, с
    SPEED_MIN_PCT  : REAL := 20.0;      // мин. задание ПЧ в работе, %
    SCENARIO       : INT := 1;          // номер сценария в журнале событий
    EV_START       : INT := 1;          // событие: пуск насоса
    EV_SP_STEP     : INT := 2;          // событие: ступень задания
    EV_SURGE       : INT := 3;          // событие: ступень притока
END_VAR
VAR
    // устройства библиотеки, обмен — через структуры команд, Cfg и Retain, как в приложении
    fbLt          : PL.FB_AnalogInput;    // LT: датчик уровня
    stLtCmd       : PL.ST_AnalogInputCmd; // его команды
    stLtCfg       : PL.ST_AnalogInputCfg; // его Cfg
    fbLic         : PL.FB_PID;            // LIC: регулятор уровня
    stLicCmd      : PL.ST_PidCmd;         // его команды (задание оператора)
    stLicRet      : PL.ST_DeviceRetain;   // его режим
    stLicCfg      : PL.ST_PidCfg;         // его Cfg
    fbPump        : PL.FB_MotorVfd;       // насос с ПЧ
    stPumpCmd     : PL.ST_MotorCmd;       // его команды
    stPumpRet     : PL.ST_DeviceRetain;   // его режим и счётчики
    stPumpCfg     : PL.ST_MotorCfg;       // его Cfg
    // модель объекта
    lrLevel_m     : LREAL;                // уровень в ёмкости, м
    rSpeedAct_pct : REAL;                 // скорость ПЧ, %
    rQin_m3h      : REAL;                 // приток, м3/ч
    rQout_m3h     : REAL;                 // отбор насосом, м3/ч
    rLevel_mA     : REAL;                 // ток датчика уровня, мА
    // контур
    xLeadAuto     : BOOL;                 // насос в Auto и работает (прошлый цикл): ПИД не следит
    rLeadRef_pct  : REAL;                 // задание ПЧ прошлого цикла, %
    // сценарий и журнал
    xInit         : BOOL;                 // Cfg и начальное состояние заданы
    xStartDone    : BOOL;                 // пуск насоса выполнен
    xSpDone       : BOOL;                 // ступень задания выполнена
    xSurgeDone    : BOOL;                 // ступень притока выполнена
    lrNextLog_s   : LREAL;                // время следующей записи журнала, с
    uiIdx         : UINT;                 // индекс записи журнала
END_VAR
