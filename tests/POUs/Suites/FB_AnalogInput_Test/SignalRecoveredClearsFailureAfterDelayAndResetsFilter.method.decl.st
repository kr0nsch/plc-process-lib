// Фильтр 10 с, tFailDelay 2 с: отказ подтверждён; сигнал вернулся (75 %) — отказ держится 1,9 с (значение удерживается
// 50), снимается ровно через 2,0 с, и значение сразу 75: фильтр начался с текущего значения. Без сброса фильтра было бы
// 54,53 (источник: tools/reference/ai_reference.py, сценарий filter «возврат сигнала 50 -> 75 без сброса фильтра»).
METHOD PRIVATE SignalRecoveredClearsFailureAfterDelayAndResetsFilter
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
END_VAR
