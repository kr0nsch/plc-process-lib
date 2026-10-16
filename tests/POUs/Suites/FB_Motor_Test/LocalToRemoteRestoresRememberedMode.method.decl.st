// Возврат из Local — в запомненный дистанционный режим: Auto → Local → Auto; в Local команда xSetManual меняет
// запомненный режим, и двигатель, запущенный по месту, после возврата продолжает работать в Manual.
METHOD PRIVATE LocalToRemoteRestoresRememberedMode
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
