// ОС подключена, допуск 5 %, tDev = 30 с. Выход 50 %, ОС 40 %: до 29 с предупреждения нет, ровно на 30 с —
// CV_WRN_DEVIATION, NE 107 OutOfSpecification, тревога слота Deviation; отказа нет, выход не меняется,
// rDeviation_pct = 10 %. ОС 48 % — предупреждение снято, бит AT_SETPOINT.
METHOD PRIVATE DeviationWarningAfterDelay
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    iStep    : INT;                  // шаг цикла
    itfAlm   : I_Alarm;              // слот тревоги через интерфейс
END_VAR
