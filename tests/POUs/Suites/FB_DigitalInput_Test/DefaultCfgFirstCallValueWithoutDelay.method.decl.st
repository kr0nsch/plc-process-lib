// Cfg по умолчанию проходит CheckConfig; после первого вызова — Auto, тип DigitalInput, 2 слота, Good. Значение в
// первом вызове — без задержки включения (2 с): после старта ПЛК вход сразу равен сигналу. Тревога State по умолчанию
// выключена (None) и не формируется.
METHOD PRIVATE DefaultCfgFirstCallValueWithoutDelay
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    itfAlm : I_Alarm;              // слот тревоги через интерфейс
END_VAR
