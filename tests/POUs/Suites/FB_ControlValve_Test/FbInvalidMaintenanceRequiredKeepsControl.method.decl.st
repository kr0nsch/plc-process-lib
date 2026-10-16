// ОС подключена, но недостоверна: CV_WRN_FB_INVALID, NE 107 MaintenanceRequired, тревога FbFailure;
// клапан управляется (30 % -> 60 %), xAutoActive и Available; рассогласование без ОС не контролируется
// дольше tDev. NaN при признаке «достоверна» — тоже отказ ОС.
METHOD PRIVATE FbInvalidMaintenanceRequiredKeepsControl
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    iStep    : INT;                  // шаг цикла
    itfAlm   : I_Alarm;              // слот тревоги через интерфейс
    uBits    : U_RealBits;           // NaN по битам
END_VAR
