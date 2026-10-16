// Дребезг блок-контакта в работе: ОС пропала на 0,2 с (меньше tFbLossFilter = 0,5 с) и вернулась — это не
// останов и не новый пуск: пусков 1, текущая непрерывная работа не обнулилась (по ней станция ограничивает
// непрерывную работу и чередует насосы), отказа нет. Источник: tools/reference/motor.py, сценарии
// dropout_bridged_at_return_s, dropout_bridged_total_s.
METHOD PRIVATE FeedbackDropoutWithinFilterNotCountedAsStart
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbMot    : FB_Motor;          // двигатель под тестом
    stCmd    : ST_MotorCmd;       // команды
    stRetain : ST_DeviceRetain;   // энергонезависимые данные
    stCfg    : ST_MotorCfg;       // конфигурация (умолчания)
END_VAR
