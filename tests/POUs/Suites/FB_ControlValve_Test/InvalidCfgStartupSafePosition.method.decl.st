// Корректной Cfg ещё не было (rOutMin >= rOutMax): CV_CFG_LIMITS, CheckFunction; выход — положение
// безопасности из поданной Cfg (30 %, 8,8 мА) и в Auto, xAutoActive = FALSE, задание Manual следит.
// Положение безопасности NaN — 0 % (4 мА), 150 % — ограничено 100 %.
METHOD PRIVATE InvalidCfgStartupSafePosition
VAR
    fbTime      : FB_FakeTime;          // подменное время
    fbCv        : FB_ControlValve;      // клапан с неверными пределами
    fbCvBad     : FB_ControlValve;      // клапан с неверным положением безопасности
    stCmd       : ST_ControlValveCmd;   // команды
    stCmdBad    : ST_ControlValveCmd;   // команды второго клапана
    stRetain    : ST_DeviceRetain;      // режим
    stRetainBad : ST_DeviceRetain;      // режим второго клапана
    stCfg       : ST_ControlValveCfg;   // rOutMin >= rOutMax
    stCfgBad    : ST_ControlValveCfg;   // rSafePos_pct вне 0…100
    uBits       : U_RealBits;           // NaN по битам
    iStep       : INT;                  // шаг цикла
END_VAR
