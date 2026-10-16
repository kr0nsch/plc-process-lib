// Рампа задания: min 20 %, рост 10 %/с, спад 5 %/с, шаг 100 мс; пуск — с 20 %, через 1,5 с — 35 %, через 3 с —
// цель 50 %; цель 30 %: через 2 с — 40 %, через 4 с — 30 %. Источник: tools/reference/motor.py, сценарии ramp_*.
METHOD PRIVATE SpeedRampLimitsRate
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
