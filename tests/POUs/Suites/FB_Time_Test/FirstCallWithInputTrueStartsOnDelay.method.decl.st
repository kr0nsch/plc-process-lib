// Первый вызов сразу с xIn = TRUE ставит отметку и начинает отсчёт. Подменное время стартует с 1 ч:
// без отметки первого вызова разность с нулевой отметкой была бы 1 ч, и выход включился бы сразу.
METHOD PRIVATE FirstCallWithInputTrueStartsOnDelay
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
    fbDelay : FB_Delay;      // ФБ под тестом
END_VAR
