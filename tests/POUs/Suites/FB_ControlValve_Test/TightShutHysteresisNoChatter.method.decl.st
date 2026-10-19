// Плотное закрытие 2 % с гистерезисом CV_TIGHT_HYST_PCT = 1 % (CV-13): задание 2,02 %, затем по кругу 1,98 / 2,02 %
// десять вызовов — выход один раз уходит в 0 % и дальше не дёргается; 2,99 % — ещё 0 %; 3,0 % — выход 3,0 %, бит
// TIGHT_SHUT снят.
METHOD PRIVATE TightShutHysteresisNoChatter
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)

    iStep    : INT;                  // шаг цикла
    iJumps   : INT;                  // скачков выхода больше 1 %
    rPrev    : REAL;                 // выход прошлого вызова
END_VAR
