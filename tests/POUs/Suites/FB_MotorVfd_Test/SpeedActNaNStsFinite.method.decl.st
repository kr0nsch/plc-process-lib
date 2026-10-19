// Фактическая скорость NaN при xCommOk (мусор Modbus): связь недостоверна, задание удерживается; в Sts и свойстве
// SpeedAct — конечное 0.0 (R6: карта регистров NaN не получает).
METHOD PRIVATE SpeedActNaNStsFinite
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)

    uBits    : U_RealBits;        // NaN по битам
    itfLead  : I_MotorVfd;        // двигатель через интерфейс
END_VAR
