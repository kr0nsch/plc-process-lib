// Рассогласование во время рампы не контролируется: рост 1 %/с к цели 50 %, факт отстаёт (0 %) — за 20 с
// (больше tSpeedDev = 2 с при допуске 10 %) предупреждения нет (задание 20 %); рампа завершена — предупреждение
// ровно через tSpeedDev. Источник: tools/reference/motor.py, сценарий ramp_slow_20s.
METHOD PRIVATE SpeedDeviationDuringRampIgnored
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
