// Цель не конечна (NaN от ПИД/Modbus): задание удерживается, предупреждение SPEED_SP_INVALID, NaN в задание
// оператора не пишется; конечная цель снова принимается.
METHOD PRIVATE SpeedSpNaNHoldsRef
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    uBits    : U_RealBits;        // NaN по битам
END_VAR
