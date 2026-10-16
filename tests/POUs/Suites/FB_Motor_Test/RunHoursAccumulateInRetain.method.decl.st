// Наработка копится в stRetain: 90 мин работы шагами по 10 с — 5400 с, rRunTime_h = 1,5 ч (и «с ТО» так же,
// RunSeconds); 2,5 с шагами по 100 мс — 2 целых секунды (0,5 с — в накопителе), ещё 0,5 с — 3 с.
// Источник: tools/reference/motor.py, сценарии run_hours_90min_*, run_fraction_*.
METHOD PRIVATE RunHoursAccumulateInRetain
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot     : FB_Motor;          // двигатель под тестом
    stCmd     : ST_MotorCmd;       // команды
    stRetain  : ST_DeviceRetain;   // энергонезависимые данные
    stCfg     : ST_MotorCfg;       // конфигурация (умолчания)
    fbTime2   : FB_FakeTime;       // подменное время второго двигателя
    fbMot2    : FB_Motor;          // второй двигатель
    stCmd2    : ST_MotorCmd;       // его команды
    stRetain2 : ST_DeviceRetain;   // его энергонезависимые данные
END_VAR
