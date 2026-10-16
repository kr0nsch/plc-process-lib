// Задание автоматики не число (NaN из Modbus/ПИД): выход удерживается, CV_WRN_SP_INVALID; конечное
// задание — снова к нему, предупреждение снято.
METHOD PRIVATE AutoSpNaNHoldsWithWarning
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    uBits    : U_RealBits;           // NaN по битам
END_VAR
