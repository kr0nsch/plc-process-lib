// Умолчания ST_ControlValveCfg проходят CheckConfig; тип ControlValve, слотов тревог 4, приоритеты по
// умолчанию (PositionerFault — Medium, InterlockAct — None); ток 4 мА при 0 %; Manual — xAutoActive нет.
METHOD PRIVATE DefaultCfgPassesCheck
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    itfAlm   : I_Alarm;              // слот тревоги через интерфейс
END_VAR
