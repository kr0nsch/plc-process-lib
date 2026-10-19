// ОС положения NaN при xPosFbValid = TRUE (мусор Modbus): тревога FbFailure; значение её события и stSts.rPosFb_pct
// конечны — 0.0 (R6: журнал и карта регистров NaN не получают), рассогласование 0, выход удерживается.
METHOD PRIVATE FbNaNEventAndStsFinite
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)

    fbSink   : FB_TestSink;          // приёмник событий
    stEv     : ST_AlarmEvent;        // последнее событие
    uBits    : U_RealBits;           // NaN по битам
END_VAR
