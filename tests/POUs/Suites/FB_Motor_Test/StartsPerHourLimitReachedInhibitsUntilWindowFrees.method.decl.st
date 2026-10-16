// Лимит 3 пуска в час, пуски в t0, t0 + 10 мин, t0 + 20 мин: в t0 + 30 мин пуск отклонён (RejectedInhibit),
// uiStartsLastHour = 3, остаток 1800 с, предупреждение STARTS_LIMIT; в t0 + 59 мин остаток 60 с; в t0 + 60 мин
// первая отметка вышла из окна — пуск принят. Источник: tools/reference/motor.py, сценарии starts_limit_3_*.
METHOD PRIVATE StartsPerHourLimitReachedInhibitsUntilWindowFrees
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
