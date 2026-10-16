// Задержка включения 500 мс: дребезг (импульсы 200 и 300 мс) значение не включает, пока идёт отсчёт — бит
// DI_STS_TIMING_ON; устойчивый сигнал — TRUE ровно через 500 мс.
METHOD PRIVATE OnDelayFiltersBounce
VAR
    fbTime  : FB_FakeTime;          // подменное время
    fbDi    : FB_DigitalInput;      // ФБ под тестом
    stCmd   : ST_DigitalInputCmd;   // команды
    stCfg   : ST_DigitalInputCfg;   // конфигурация
    iStep   : INT;                  // шаг цикла
    xEverOn : BOOL;                 // значение включалось хотя бы раз
END_VAR
