// Задержка появления после выключения и включения тревоги отсчитывается заново, от включения:
// тревога с tOnDelay 2 с была активна и квитирована, на 5 с выключена (приоритет None) при
// активном условии; после включения — Normal 1,9 с и ActiveUnack ровно через 2 с, а не сразу по
// старому состоянию задержки. F-21 (б)
METHOD PRIVATE PriorityReenabledOnDelayCountsFromEnabling
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // tOnDelay 2 с
    iStep  : INT;            // шаг цикла
END_VAR
