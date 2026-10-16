// Рассогласование — отказ (xDevIsFault), реакция SafePos (20 %), рампа 10 %/с, tDev = 5 с. Auto, выход
// 50 %, ОС 30 %: на 4 с отказа нет, на 5 с — CV_FLT_DEVIATION, Failure и сразу 20 % без рампы (бит
// SAFE_POS), xAutoActive = FALSE. Отказ фиксирован; Reset снимает, рампа к 50 % — от текущих 20 %.
METHOD PRIVATE DeviationAsFaultGoesSafePosition
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
    iStep    : INT;                  // шаг цикла
END_VAR
