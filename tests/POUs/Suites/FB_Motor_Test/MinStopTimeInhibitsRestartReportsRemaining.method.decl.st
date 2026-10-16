// tMinStop = 30 с: пауза отсчитывается от старта ПЛК и от останова; остаток — в uiInhibitRemain_s с
// округлением вверх (30, через 12,3 с — 18, через 29,9 с — 1), бит START_INHIBIT, xStart — RejectedInhibit;
// через 30 с пуск принимается. Источник: tools/reference/motor.py, сценарии inhibit_min_stop_*.
METHOD PRIVATE MinStopTimeInhibitsRestartReportsRemaining
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
