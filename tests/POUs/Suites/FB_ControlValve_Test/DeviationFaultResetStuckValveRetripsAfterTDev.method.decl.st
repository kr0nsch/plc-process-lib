// Рассогласование — отказ (xDevIsFault), реакция Hold, tDev = 5 с. Manual, задание 50 %, клапан
// заклинило на 30 %: на t0 + 5 с — CV_FLT_DEVIATION, выход удерживается (50 %), предупреждения
// рассогласования нет — это отказ. Reset при неснятой причине снимает отказ и начинает отсчёт tDev заново:
// на t1 + 4 с отказа нет, ровно на t1 + 5 с он возвращается.
METHOD PRIVATE DeviationFaultResetStuckValveRetripsAfterTDev
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы, Hold)
    iStep    : INT;                  // шаг цикла
END_VAR
