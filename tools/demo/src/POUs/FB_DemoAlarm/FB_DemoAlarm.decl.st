// Назначение: сценарий C демонстрационного прогона — тревога ISA-18.2 в слоте H аналогового
//             входа PL.FB_AnalogInput (0..5 м, уставка H 4,0 м, гистерезис 0,1 м, задержка 1 с;
//             приоритет Medium, shelve не дольше 15 с). Уровень трижды выходит за H, «оператор»
//             квитирует и откладывает тревогу командами stCmd, как кнопками HMI: Normal ->
//             ActiveUnack -> ActiveAck -> Normal; возврат без квитирования (RtnUnack) и
//             квитирование; shelve и повторное оповещение по истечении срока.
//             Коды событий: 1 — квитирование (xAck), 2 — shelve (wShelveReq).
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/fb/FB_Alarm.md, «Состояния»; tools/demo/README.md
FUNCTION_BLOCK FB_DemoAlarm
VAR_INPUT
    lrT_s : LREAL;   // время от старта сценария, с
END_VAR
VAR_OUTPUT
    xDone : BOOL;    // сценарий завершён, журнал записан
END_VAR
VAR CONSTANT
    LEVEL_SPAN_M  : REAL := 5.0;      // шкала: 4 мА = 0 м, 20 мА = 5 м
    MA_LO         : REAL := 4.0;      // ток начала шкалы, мА
    MA_SPAN       : REAL := 16.0;     // диапазон тока шкалы, мА
    H_SP_M        : REAL := 4.0;      // уставка H, м
    H_HYST_M      : REAL := 0.1;      // гистерезис H, м
    H_ON_DELAY    : TIME := T#1S;     // задержка срабатывания H
    SHELVE_MAX    : TIME := T#15S;    // максимальный срок shelve (короткий — для демонстрации)
    SLOT_H_MASK   : WORD := 16#0002;  // бит слота E_AiAlarm.H в масках команд
    SCENARIO      : INT := 3;         // номер сценария в журнале событий
    EV_ACK        : INT := 1;         // событие: квитирование
    EV_SHELVE     : INT := 2;         // событие: shelve
    PROFILE_LAST  : UINT := 13;       // последний индекс точек профиля уровня
    // точки профиля уровня (время, м); между точками — линейно, после последней — её значение
    PROFILE_T_S   : ARRAY[0..13] OF LREAL := [0.0, 8.0, 12.0, 30.0, 34.0, 40.0, 43.0, 50.0, 53.0, 60.0,
                                            63.0, 90.0, 93.0, 100.0];
    PROFILE_L_M   : ARRAY[0..13] OF REAL := [3.5, 3.5, 4.3, 4.3, 3.6, 3.6, 4.3, 4.3, 3.6, 3.6,
                                           4.3, 4.3, 3.6, 3.6];
    ACT_LAST      : UINT := 3;        // последний индекс действий оператора
    ACT_T_S       : ARRAY[0..3] OF LREAL := [18.0, 58.0, 67.0, 86.0];   // моменты действий, с
    ACT_CODE      : ARRAY[0..3] OF INT := [1, 1, 2, 1];                 // EV_ACK / EV_SHELVE
END_VAR
VAR
    fbLevel     : PL.FB_AnalogInput;      // датчик уровня с уставкой H
    stLevelCmd  : PL.ST_AnalogInputCmd;   // его команды (кнопки HMI)
    stLevelCfg  : PL.ST_AnalogInputCfg;   // его Cfg
    itfAlmH     : PL.I_Alarm;             // тревога слота H
    xInit       : BOOL;                   // Cfg задана
    rLevel_m    : REAL;                   // уровень по профилю, м
    uiSeg       : UINT;                   // индекс точки профиля
    uiAct       : UINT;                   // следующее действие оператора
    iState      : INT;                    // E_AlarmState слота H
    lrNextLog_s : LREAL;                  // время следующей записи журнала, с
    uiIdx       : UINT;                   // индекс записи журнала
END_VAR
