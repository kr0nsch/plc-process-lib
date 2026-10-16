// Пуск считается по фронту ОС: попытка пуска без ОС — отметка в окне, но не пуск; ОС — пуск (всего и «с ТО»);
// пуск по месту (фронт ОС в Local без команды ПЛК) — тоже пуск и отметка в окне.
METHOD PRIVATE StartsCountedOnFeedbackEdge
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
