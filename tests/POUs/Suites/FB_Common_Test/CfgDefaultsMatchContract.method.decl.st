// Значения Cfg по умолчанию — по контракту (на них опирается генератор: экземпляр без строки
// конфигурации корректен). Инициализатор элемента массива (ePriority := ...) оставляет прочим
// полям умолчания ST_AlarmCfg (проверка R9 контракта для DUT).
METHOD PRIVATE CfgDefaultsMatchContract
VAR
    stAlm : ST_AlarmCfg;           // умолчания ST_AlarmCfg
    stSlot : ST_AlarmCfg;          // копия элемента astAlarm[i]
    stLim : ST_AiLimitCfg;         // копия элемента astLimit[i]
    stAi  : ST_AnalogInputCfg;
    stDi  : ST_DigitalInputCfg;
    stMot : ST_MotorCfg;
    stVlv : ST_ValveCfg;
    stCv  : ST_ControlValveCfg;
    stPid : ST_PidCfg;
END_VAR
