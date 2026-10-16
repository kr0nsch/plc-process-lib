// Слово состояния ПЧ достоверно только при связи (14.2): связи нет 1 с (меньше tCommLoss), в последнем
// прочитанном слове «авария» и «не готов» — ни ExtFault (дольше tExtFaultFilter), ни PERMIT_MISSING. Связь
// появилась, авария держится — ExtFault через tExtFaultFilter, «не готов» — PERMIT_MISSING.
METHOD PRIVATE CommLostStatusWordIgnored
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
