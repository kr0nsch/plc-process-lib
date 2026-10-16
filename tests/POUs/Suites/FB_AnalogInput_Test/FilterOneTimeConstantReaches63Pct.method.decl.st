// Фильтр T = 10 с, ступень 0 -> 100 % с шагом 100 мс: в 9,9 с — 62,842, ровно через T — 63,212 (1 - e^-1). источник:
// tools/reference/ai_reference.py, сценарии filter «… 99 шагов по 0,1 с» и «… 100 шагов по 0,1 с».
METHOD PRIVATE FilterOneTimeConstantReaches63Pct
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
END_VAR
