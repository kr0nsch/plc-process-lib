// Обрыв (0 мА) при tFailDelay = 2 с: до 1,9 с отказа нет, значение удерживается (2,5 м), ложного LL нет, бит
// AI_STS_FAIL_PENDING; ровно через 2,0 с — Failure, xValid = FALSE, бит AI_FLT_FAIL_LOW (AI_STS_FAIL_PENDING снят),
// тревога Failure, LL снят принудительно. Образец — раздел 23.3 контракта.
METHOD PRIVATE WireBreakSetsFailureAfterDelay
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
    iStep  : INT;                 // шаг цикла
END_VAR
