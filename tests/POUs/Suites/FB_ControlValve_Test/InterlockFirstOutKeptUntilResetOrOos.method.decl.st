// Первопричина держится (CV-9): блокировка бит 2, затем добавился бит 0 (16#0005) — uiFirstOut = 2 не меняется.
// Reset снимает её; пока слово блокировок не 0, новой первопричины нет. Слово вернулось в 0, затем бит 1 —
// первопричина 1; вход в OutOfService её снимает.
METHOD PRIVATE InterlockFirstOutKeptUntilResetOrOos
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
END_VAR
