// FB_FakeTime стартует с LTIME#1H, а не с 0: ловит код, который считает «0 = не инициализировано».
METHOD PRIVATE FakeTimeStartsAtOneHour
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
END_VAR
