// Пределы задания 20…90 %: цель Auto 95 % → 90 % (слежение stCmd.rSpeedSp_pct тоже 90), 5 % → 20 %;
// в Manual 150 % → 90 % и записывается обратно в stCmd.
METHOD PRIVATE SpeedClampedToMinMax
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
