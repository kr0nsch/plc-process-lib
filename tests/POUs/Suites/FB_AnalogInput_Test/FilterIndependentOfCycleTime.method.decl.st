// Один и тот же интервал 5 с при T = 10 с: шаг 10 мс (500 вызовов), 250 мс (20 вызовов) и неравномерный 50/150/300 мс
// дают одно значение 39,347 (1 - e^-0,5): фильтр считает по реальному шагу времени. Неявный Эйлер dt/(T + dt) при 250
// мс дал бы 38,97. источник: tools/reference/ai_reference.py, сценарии filter «5 с шагом 10 мс», «… 250 мс», «…
// неравномерно».
METHOD PRIVATE FilterIndependentOfCycleTime
VAR
    fbTimeA : FB_FakeTime;         // время экземпляра A
    fbTimeB : FB_FakeTime;         // время экземпляра B
    fbTimeC : FB_FakeTime;         // время экземпляра C
    fbAiA   : FB_AnalogInput;      // шаг 10 мс
    fbAiB   : FB_AnalogInput;      // шаг 250 мс
    fbAiC   : FB_AnalogInput;      // неравномерный шаг
    stCmdA  : ST_AnalogInputCmd;   // команды A
    stCmdB  : ST_AnalogInputCmd;   // команды B
    stCmdC  : ST_AnalogInputCmd;   // команды C
    stCfg   : ST_AnalogInputCfg;   // конфигурация
    iStep   : INT;                 // шаг цикла
END_VAR
