// Назначение: сценарий B демонстрационного прогона — классификация тока по NAMUR NE 43 в
//             PL.FB_AnalogInput (0..5 м, tFailDelay 2 с, без фильтра). Профиль тока 0 -> 24 мА:
//             обрыв 0 мА; медленный проход защитной полосы 3,6–3,8 мА (дольше задержки
//             подтверждения); подъём по шкале; медленный проход полосы 20,5–21,0 мА и отказ «вверх»;
//             24 мА; возврат на 12 мА. Журнал: ток, значение, xValid, мгновенный eSignal и
//             подтверждённый статус NE 107.
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/fb/FB_AnalogInput.md, «Цепочка обработки»; tools/demo/README.md
FUNCTION_BLOCK FB_DemoNe43
VAR_INPUT
    lrT_s : LREAL;   // время от старта сценария, с
END_VAR
VAR_OUTPUT
    xDone : BOOL;    // сценарий завершён, журнал записан
END_VAR
VAR CONSTANT
    LEVEL_SPAN_M : REAL := 5.0;   // шкала: 4 мА = 0 м, 20 мА = 5 м
    PROFILE_LAST : UINT := 8;     // последний индекс точек профиля
    // точки профиля тока (время, мА); между точками — линейно, после последней — её значение
    PROFILE_T_S  : ARRAY[0..8] OF LREAL := [0.0, 3.0, 6.4, 16.4, 32.8, 41.8, 44.6, 50.0, 50.1];
    PROFILE_I_MA : ARRAY[0..8] OF REAL := [0.0, 0.0, 3.4, 3.9, 20.3, 21.2, 24.0, 24.0, 12.0];
END_VAR
VAR
    fbAi        : PL.FB_AnalogInput;      // проверяемый вход
    stAiCmd     : PL.ST_AnalogInputCmd;   // его команды
    stAiCfg     : PL.ST_AnalogInputCfg;   // его Cfg
    xInit       : BOOL;                   // Cfg задана
    rIn_mA      : REAL;                   // ток на входе, мА
    uiSeg       : UINT;                   // индекс точки профиля
    lrNextLog_s : LREAL;                  // время следующей записи журнала, с
    uiIdx       : UINT;                   // индекс записи журнала
END_VAR
