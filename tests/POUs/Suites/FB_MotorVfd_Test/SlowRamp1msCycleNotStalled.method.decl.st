// Рампа задания 0,003 %/с при цикле 1 мс (VFD-13): состояние рампы в LREAL — за 1 с задание растёт на 0,003 %
// (в REAL приращение 3·10⁻⁶ % рядом с 70 % терялось бы и рампа стояла). Ожидаемое: 70 + 0,003 · 1 с.
METHOD PRIVATE SlowRamp1msCycleNotStalled
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
