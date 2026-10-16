// Уставка H 80, гистерезис 2 (вход Eng 0..100): 79,9 — нет; 80,0 — да (граница включена); 78,0 — ещё да; 77,9 — снят.
// Тревога H — ActiveUnack, бит AI_STS_H.
METHOD PRIVATE LimitHHysteresisClearsBelowSpMinusHyst
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
END_VAR
