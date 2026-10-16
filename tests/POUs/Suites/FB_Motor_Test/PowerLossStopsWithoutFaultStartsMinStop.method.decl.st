// Пропадание напряжения в Auto: Stopped без отказа, предупреждение POWER_LOST и запрет пуска; tMinStop = 20 с
// отсчитывается от момента пропадания: питание вернулось через 5 с — остаток 15 с, пуск по запросу Auto — ровно
// через 20 с. Источник: tools/reference/motor.py, сценарий inhibit_power_loss_after_5s.
METHOD PRIVATE PowerLossStopsWithoutFaultStartsMinStop
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
