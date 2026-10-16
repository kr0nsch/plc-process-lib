// Инверсия (НЗ-контакт) до задержек: xIn TRUE — значение FALSE; пропадание xIn — фронт инвертированного сигнала, его и
// задерживает tOnDelay 300 мс (бит DI_STS_RAW = 1 сразу); возврат xIn — спад без задержки.
METHOD PRIVATE InvertInvertsBeforeDelay
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDi   : FB_DigitalInput;      // ФБ под тестом
    stCmd  : ST_DigitalInputCmd;   // команды
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    iStep  : INT;                  // шаг цикла
END_VAR
