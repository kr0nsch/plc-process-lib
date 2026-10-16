// Обратный расчёт по фактическому выходу (xUseOutAct): механизм не опускается ниже 30 % (минимум
// частоты ПЧ), rOutAct_pct = MAX(30, выход прошлого вызова). При ошибке -10 % 60 с выход ПИД
// держится у внешнего предела (около 30 - Tt·Kp·|e|/Ti = 20 %), а не уходит в 0; после смены
// знака ошибки механизм отвечает сразу. Без xUseOutAct ПИД уходит в 0 и после смены знака
// остаётся ниже 30 %.
METHOD PRIVATE AntiWindupOutActFeedbackTracksExternalLimit
VAR
    fbTime     : FB_FakeTime;       // подменное время, старт 1 ч
    fbPidAct   : FB_PID;            // ФБ под тестом: xUseOutAct
    fbPidNoAct : FB_PID;            // сравнение: без xUseOutAct
    stCmdAct   : ST_PidCmd;         // команды
    stCmdNoAct : ST_PidCmd;
    stRetAct   : ST_DeviceRetain;   // режим: старт в Manual
    stRetNoAct : ST_DeviceRetain;
    stCfgAct   : ST_PidCfg;         // конфигурация
    stCfgNoAct : ST_PidCfg;
    iStep      : INT;               // шаг цикла
    rHoldAct   : REAL;              // выход в конце 60 с
    rHoldNoAct : REAL;
END_VAR
