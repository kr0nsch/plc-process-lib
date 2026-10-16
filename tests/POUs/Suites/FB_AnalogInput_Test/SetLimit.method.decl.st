// Помощник: уставка uiIdx (E_AiAlarm.HH, H, L, LL) в Cfg входа. Копия элемента: iec_checker 0.4 не
// разбирает stCfg.astLimit[i].x
METHOD PRIVATE SetLimit
VAR_IN_OUT
    stCfgAi : ST_AnalogInputCfg;   // конфигурация входа
END_VAR
VAR_INPUT
    uiIdx    : UINT;               // уставка: E_AiAlarm.HH, H, L, LL
    xEnable  : BOOL;               // уставка включена
    rSp_eu   : REAL;               // значение уставки, инж. ед.
    rHyst_eu : REAL;               // гистерезис, инж. ед.
    tOnDly   : TIME;               // задержка срабатывания
    tOffDly  : TIME;               // задержка снятия
END_VAR
VAR
    stLim : ST_AiLimitCfg;         // копия уставки
END_VAR
