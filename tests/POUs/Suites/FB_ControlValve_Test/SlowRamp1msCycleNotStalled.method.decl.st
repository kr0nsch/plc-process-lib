// Рампа 0,003 %/с при цикле 1 мс (CV-14): приращение за шаг 3·10⁻⁶ % меньше половины шага REAL рядом с 70 %
// (7,6·10⁻⁶ %) — в REAL рампа стояла бы на месте. Состояние рампы в LREAL: за 1 с (1000 шагов по 1 мс) выход
// 70,003 % — столько же, сколько при цикле 100 мс (10 шагов). источник: tools/reference/valve_reference.py,
// сценарий cv_slow_ramp.
METHOD PRIVATE SlowRamp1msCycleNotStalled
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)

    fbTime2  : FB_FakeTime;          // время второго клапана
    fbCv2    : FB_ControlValve;      // тот же клапан с циклом 100 мс
    stCmd2   : ST_ControlValveCmd;   // его команды
    stRet2   : ST_DeviceRetain;      // его режим
    iStep    : INT;                  // шаг цикла
END_VAR
