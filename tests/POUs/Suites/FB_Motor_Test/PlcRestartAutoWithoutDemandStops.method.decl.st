// Старт ПЛК в Auto без запроса при работающем по ОС двигателе: штатный останов с контролем (Stopping, команда
// не подаётся), после пропадания ОС — Stopped без отказа.
METHOD PRIVATE PlcRestartAutoWithoutDemandStops
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
