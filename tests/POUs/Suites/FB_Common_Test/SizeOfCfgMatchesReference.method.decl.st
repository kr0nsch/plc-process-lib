// SIZEOF структур Cfg — по расчёту раскладки (Control Win V3 32 бит). Cfg лежат в Persistent
// Variables приложения: изменение типа переинициализирует уставки (A-13), тест ловит его.
// Источник: tools/reference/common.py, сценарий cfg_sizes.
METHOD PRIVATE SizeOfCfgMatchesReference
VAR
    stAi  : ST_AnalogInputCfg;
    stDi  : ST_DigitalInputCfg;
    stMot : ST_MotorCfg;
    stVfd : ST_VfdCfg;
    stVlv : ST_ValveCfg;
    stCv  : ST_ControlValveCfg;
    stPid : ST_PidCfg;
END_VAR
