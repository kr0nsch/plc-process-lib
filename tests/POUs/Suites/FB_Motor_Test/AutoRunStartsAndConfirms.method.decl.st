// Auto: запрос xAutoRun запускает двигатель (Starting, xQRun), ОС через 1 с подтверждает пуск (Running);
// пуск считается по фронту ОС, отметка в окне пусков — при входе в Starting; двигатель доступен автоматике.
METHOD PRIVATE AutoRunStartsAndConfirms
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
