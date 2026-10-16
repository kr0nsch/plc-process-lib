// Вход в Starting начинает рампу с rSpeedMin_pct = 30 % (а не с 0): в вызове пуска 30 %, через шаг 100 мс —
// 31 %, через 1 с — 40 % (рост 10 %/с, цель 80 %). Источник: tools/reference/motor.py, сценарии start_preset_*.
METHOD PRIVATE StartPresetsRampToMin
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
