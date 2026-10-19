// Пуск в Manual во время короткого пропуска связи (короче tCommLoss): пуск не блокируется, а задание передать
// нельзя — предустановка rSpeedMin ждёт связи (VFD-10). Связь вернулась — задание 30 % (rSpeedMin), а не рампа от
// 0; дальше рампа 1 %/с: 30,1 % через 0,1 с.
METHOD PRIVATE StartInCommGapRefPresetToMin
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVfd    : FB_MotorVfd;       // двигатель с ПЧ под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
