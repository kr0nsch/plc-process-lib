// Внешняя авария зафиксирована, Reset с tResetPulse = 1 с (сброс УПП): через 0,5 с время назад на 30 с. Импульс
// xQReset и окно tResetWindow отсчитываются заново (M-17), а не обрываются переполнением: импульс держится ещё 1 с
// после скачка; авария, снятая в окне, сброшена без RejectedFault.
METHOD PRIVATE TimeBackwardsDuringResetPulsePulseRestarts
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация
END_VAR
