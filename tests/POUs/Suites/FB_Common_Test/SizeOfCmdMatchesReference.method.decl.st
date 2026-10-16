// SIZEOF структур команд HMI/SCADA (GVL_Hmi приложения). Источник: tools/reference/common.py, сценарий cmd_sizes.
METHOD PRIVATE SizeOfCmdMatchesReference
VAR
    stDev : ST_DeviceCmd;          // общий заголовок
    stAi  : ST_AnalogInputCmd;
    stDi  : ST_DigitalInputCmd;
    stMot : ST_MotorCmd;
    stVlv : ST_ValveCmd;
    stCv  : ST_ControlValveCmd;
    stPid : ST_PidCmd;
END_VAR
