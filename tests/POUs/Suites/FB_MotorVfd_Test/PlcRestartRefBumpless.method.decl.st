// Перезапуск ПЛК при работающем ПЧ: подхват (VFD-09). Auto, запрос есть, ПЧ на 70 %: задание на ПЧ сразу 70 % —
// фактическая скорость в пределах rSpeedMin…rSpeedMax, — без провала к 0 и рампы с нуля (rRampUp 10 %/с). Manual,
// ПЧ на 55 %: подхват пишет фактическую скорость и в задание оператора stCmd.rSpeedSp_pct (оно не энергонезависимо
// и после старта 0) — двигатель не тормозится до rSpeedMin.
METHOD PRIVATE PlcRestartRefBumpless
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)

    fbTime2  : FB_FakeTime;       // время второго двигателя
    fbVfd2   : FB_MotorVfd;       // двигатель в Manual
    stCmd2   : ST_MotorCmd;       // его команды
    stRet2   : ST_DeviceRetain;   // его данные (Manual)
END_VAR
