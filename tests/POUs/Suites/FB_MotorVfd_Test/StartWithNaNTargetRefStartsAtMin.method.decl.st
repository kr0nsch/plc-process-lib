// Пуск при не конечной цели (ПИД выдал NaN, пока насос стоял), без ограничения роста (rRampUp_pctps = 0):
// задание начинается с rSpeedMin_pct = 25 %, а не с последней конечной цели 60 %; предупреждение
// SPEED_SP_INVALID. Конечная цель — задание сразу к ней (V-03).
METHOD PRIVATE StartWithNaNTargetRefStartsAtMin
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация
    uBits    : U_RealBits;        // NaN по битам
END_VAR
