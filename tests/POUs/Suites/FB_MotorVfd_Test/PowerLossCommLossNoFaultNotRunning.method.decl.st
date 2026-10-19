// Пропало питание станции: xPowerOk = FALSE, ПЧ обесточен, связи нет (VFD-11, VFD-12). Отказа CommLoss и тревоги
// слота 6 нет — пропадание питания — останов без отказа (13.7); двигатель не работает: xRunning снят сразу,
// Stopped, наработка за час не растёт. Питание вернулось — ПЧ загружается VFD_POWER_UP_DELAY = 10 с, затем фильтр
// tCommLoss = 3 с: отказ связи — только через 13 с, если связь так и не появилась; связь есть — отказ снят.
METHOD PRIVATE PowerLossCommLossNoFaultNotRunning
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)

    udiRun0  : UDINT;             // наработка до пропадания питания, с
    itfAlm   : I_Alarm;           // тревога слота CommLoss
END_VAR
