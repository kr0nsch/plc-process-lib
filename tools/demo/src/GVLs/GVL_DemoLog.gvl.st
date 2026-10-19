// Назначение: журналы демонстрационного прогона. Сценарии пишут отсчёты сами, по своему
//             периоду от системного времени, а tools/demo/demo_capture.py читает массивы после
//             флага xAllDone через онлайн-приложение CODESYS (read_values). Перечисления пишутся
//             целыми (значения E_* библиотеки), слова состояния — как есть.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   tools/demo/README.md
{attribute 'qualified_only'}
VAR_GLOBAL
    xAllDone        : BOOL;     // все три сценария завершены, журналы заполнены
    // A: контур уровня LT -> LIC (FB_PID) -> насос с ПЧ (FB_MotorVfd), модель ёмкости
    uiLoopN         : UINT;     // записано отсчётов
    arLoopT_s       : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // время от старта сценария, с
    arLoopLevel_m   : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // уровень модели, м
    arLoopPv_m      : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // PV регулятора (rValue_eu датчика), м
    arLoopSp_m      : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // действующее задание stSts.rSp_eu, м
    arLoopOut_pct   : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // выход ПИД rOut_pct, %
    arLoopP_pct     : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // P-составляющая, %
    arLoopI_pct     : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // I-составляющая, %
    arLoopRef_pct   : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // задание на ПЧ rSpeedRef_pct, %
    arLoopAct_pct   : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // скорость ПЧ (модель), %
    arLoopQin_m3h   : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // приток, м3/ч
    arLoopQout_m3h  : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF REAL;   // отбор насосом, м3/ч
    aiLoopMotor     : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF INT;    // E_MotorState насоса
    awLoopPidSts    : ARRAY[0..GVL_DemoConst.LOOP_LOG_N - 1] OF WORD;   // wStatus ПИД (PID_STS_*)
    // B: ток 0 -> 24 мА на входе FB_AnalogInput, классификация NE 43
    uiNe43N         : UINT;     // записано отсчётов
    arNe43T_s       : ARRAY[0..GVL_DemoConst.NE43_LOG_N - 1] OF REAL;   // время от старта сценария, с
    arNe43In_mA     : ARRAY[0..GVL_DemoConst.NE43_LOG_N - 1] OF REAL;   // ток на входе, мА
    arNe43Value_m   : ARRAY[0..GVL_DemoConst.NE43_LOG_N - 1] OF REAL;   // rValue_eu, м
    axNe43Valid     : ARRAY[0..GVL_DemoConst.NE43_LOG_N - 1] OF BOOL;   // xValid
    aiNe43Signal    : ARRAY[0..GVL_DemoConst.NE43_LOG_N - 1] OF INT;    // E_AiSignalState (мгновенно)
    aiNe43Ne107     : ARRAY[0..GVL_DemoConst.NE43_LOG_N - 1] OF INT;    // E_Ne107Status
    awNe43Sts       : ARRAY[0..GVL_DemoConst.NE43_LOG_N - 1] OF WORD;   // wStatus (AI_STS_*)
    awNe43AlmActive : ARRAY[0..GVL_DemoConst.NE43_LOG_N - 1] OF WORD;   // wAlmActive (слоты E_AiAlarm)
    // C: тревога H уровня (слот E_AiAlarm.H аналогового входа), действия оператора
    uiAlmN          : UINT;     // записано отсчётов
    arAlmT_s        : ARRAY[0..GVL_DemoConst.ALM_LOG_N - 1] OF REAL;    // время от старта сценария, с
    arAlmLevel_m    : ARRAY[0..GVL_DemoConst.ALM_LOG_N - 1] OF REAL;    // rValue_eu, м
    axAlmH          : ARRAY[0..GVL_DemoConst.ALM_LOG_N - 1] OF BOOL;    // флаг уставки xH
    aiAlmState      : ARRAY[0..GVL_DemoConst.ALM_LOG_N - 1] OF INT;     // E_AlarmState слота H
    awAlmUnack      : ARRAY[0..GVL_DemoConst.ALM_LOG_N - 1] OF WORD;    // wAlmUnack
    awAlmShelved    : ARRAY[0..GVL_DemoConst.ALM_LOG_N - 1] OF WORD;    // wAlmShelved
    // события: сценарий 1 — A, 2 — B, 3 — C; коды — в комментариях сценариев
    uiEvN           : UINT;     // записано событий
    arEvT_s         : ARRAY[0..GVL_DemoConst.EVENT_LOG_N - 1] OF REAL;  // время события от старта сценария, с
    aiEvScenario    : ARRAY[0..GVL_DemoConst.EVENT_LOG_N - 1] OF INT;   // номер сценария
    aiEvCode        : ARRAY[0..GVL_DemoConst.EVENT_LOG_N - 1] OF INT;   // код события
END_VAR
