// Провал питания у стоящего двигателя тоже даёт паузу tMinStop = 20 с от момента пропадания: через 5 с после
// провала (питание вернулось через 1 с) пуск — RejectedInhibit, остаток 15 с; через 20 с — принят.
// Источник: tools/reference/motor.py, сценарий inhibit_power_loss_after_5s.
METHOD PRIVATE PowerDipWhileStoppedPauseFromPowerLoss
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
