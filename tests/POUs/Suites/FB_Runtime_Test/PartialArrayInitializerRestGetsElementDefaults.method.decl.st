// R9 контракта: частичный инициализатор astAlarm в объявлении переменной Cfg (как в GVL_Persist)
// задаёт слот 0, остальные слоты получают умолчания ST_AlarmCfg (Medium), а не умолчания DUT
// устройства (у ST_AnalogInputCfg: слот 1 — Low, слот 3 — High); поля Cfg вне инициализатора
// сохраняют умолчания DUT.
METHOD PRIVATE PartialArrayInitializerRestGetsElementDefaults
VAR
    stPart : ST_AnalogInputCfg := (rRangeHi_eu := 5.0, astAlarm := [(ePriority := E_AlarmPriority.Low)]);   // зонд
    stFull : ST_AnalogInputCfg;   // умолчания DUT для сравнения
    stSlot : ST_AlarmCfg;         // копия слота
END_VAR
