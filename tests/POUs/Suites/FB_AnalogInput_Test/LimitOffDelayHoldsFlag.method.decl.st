// H 80 с задержкой снятия 2 с: значение ушло ниже уставки — флаг держится 1,9 с, снимается в 2,0 с.
METHOD PRIVATE LimitOffDelayHoldsFlag
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
END_VAR
