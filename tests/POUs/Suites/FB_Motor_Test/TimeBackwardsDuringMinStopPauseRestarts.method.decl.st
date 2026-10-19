// Пауза tMinStop = 10 с (защита погружного насоса от обратного вращения): двигатель остановлен, прошло 2 с, время
// назад на 30 с (SetNow — смена источника времени). Пауза отсчитывается заново (M-03, M-17), а не снимается
// переполнением LTIME без знака: пуск — RejectedInhibit, остаток 10 с; 1 с в 9,9 с; через 10 с пуск принят.
METHOD PRIVATE TimeBackwardsDuringMinStopPauseRestarts
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация
END_VAR
