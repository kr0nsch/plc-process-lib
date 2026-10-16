// Шаг времени больше DT_ACCUM_MAX (зависание, остановка задачи) засчитывается как 10 с: после шага 1 ч — 10 с,
// после шага 3 с — 13 с. Источник: tools/reference/motor.py, сценарии run_large_step_*.
METHOD PRIVATE RunHoursLargeTimeStepBounded
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
