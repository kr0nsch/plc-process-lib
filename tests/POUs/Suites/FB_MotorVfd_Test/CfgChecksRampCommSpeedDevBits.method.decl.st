// Переопределение CheckConfig: бит 9 (рампа < 0), бит 10 (tCommLoss = T#0S), бит 11 (rSpeedDev_pct > 0 при
// tSpeedDev = T#0S) и биты FB_Motor вместе (tResetWindow = T#0S — бит 2).
METHOD PRIVATE CfgChecksRampCommSpeedDevBits
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd     : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd     : ST_MotorCmd;       // команды
    stRetain  : ST_DeviceRetain;   // энергонезависимые данные
    stCfg     : ST_MotorCfg;       // конфигурация (умолчания)
    wExpected : WORD;              // ожидаемые биты
END_VAR
