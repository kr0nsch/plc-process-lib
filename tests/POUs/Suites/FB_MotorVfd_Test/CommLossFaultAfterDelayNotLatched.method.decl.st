// Потеря связи (xCommLossIsFault = TRUE): сразу — контроль ОС приостановлен (FB_SUSPENDED), через tCommLoss =
// 3 с — нефиксируемый отказ (бит COMM_LOSS, Fault, выходы сняты, Available = FALSE, тревога слота 6), задание
// удерживается; связь вернулась, ПЧ работает, запрос Auto есть — Running без Reset.
METHOD PRIVATE CommLossFaultAfterDelayNotLatched
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
    itfAlm   : I_Alarm;           // тревога слота
END_VAR
