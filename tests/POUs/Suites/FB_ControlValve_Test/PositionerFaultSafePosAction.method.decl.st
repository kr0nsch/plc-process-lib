// Отказ позиционера, реакция SafePos (100 %, «открыть при отказе»), рампа 2 %/с: выход 40 % -> 100 % в
// том же вызове, CV_FLT_POSITIONER, Failure, SAFE_POS. Отказ не фиксируется: ушёл — wFault = 0, рампа к
// 40 % от 100 %: 98 % через 1 с.
METHOD PRIVATE PositionerFaultSafePosAction
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    iStep    : INT;                  // шаг цикла
END_VAR
