// SIZEOF семи структур состояния — таблица 4.6 контракта (карта регистров Modbus = порядок полей,
// скрытого выравнивания нет). Источник: таблица 4.6 и tools/reference/common.py, сценарий sts_sizes.
METHOD PRIVATE SizeOfStsMatchesRegisterMap
VAR
    stDev : ST_DeviceSts;          // общий заголовок
    stAi  : ST_AnalogInputSts;
    stDi  : ST_DigitalInputSts;
    stMot : ST_MotorSts;           // и для FB_MotorVfd
    stVlv : ST_ValveSts;
    stCv  : ST_ControlValveSts;
    stPid : ST_PidSts;
END_VAR
