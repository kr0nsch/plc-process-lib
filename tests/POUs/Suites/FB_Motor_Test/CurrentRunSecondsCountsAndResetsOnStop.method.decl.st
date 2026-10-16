// Текущая непрерывная работа: 65 с работы — CurrentRunSeconds = 65 (и stSts.udiRunCurrent_s); останов — 0;
// новый пуск считает с нуля (3 с), наработка всего продолжается (68 с).
// Источник: tools/reference/motor.py, сценарии current_run_*.
METHOD PRIVATE CurrentRunSecondsCountsAndResetsOnStop
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
