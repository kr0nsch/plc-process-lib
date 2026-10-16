// Защитный сигнал (ForceTrue, «сухой ход»): после возврата канала задержки отсчитываются от значения отказа, а не
// от значения до отказа (DI-2). tOnDelay 2 с, tOffDelay 3 с. 1) До отказа FALSE, после возврата датчик сработал
// (TRUE) — значение остаётся TRUE без провала (иначе 2 с FALSE при xValid = TRUE: насос пустили бы на сухую).
// 2) До отказа FALSE, после возврата датчик в норме — TRUE снимается только через tOffDelay, ровно в tr + 3,0 с.
METHOD PRIVATE ChannelFaultRecoveredForcedValueReleasedThroughDelay
VAR
    fbTime   : FB_FakeTime;          // подменное время
    fbDi     : FB_DigitalInput;      // ФБ под тестом
    stCmd    : ST_DigitalInputCmd;   // команды
    stCfg    : ST_DigitalInputCfg;   // конфигурация
    iStep    : INT;                  // шаг цикла
    xEverOff : BOOL;                 // значение выключалось хотя бы раз
END_VAR
