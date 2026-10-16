// Отказ PV в Auto, реакция Hold (Kp = 2, Ti = 10 с): выход удерживается, интегратор заморожен,
// Failure, бит PID_FLT_PV_INVALID, бит PV_FAIL, тревога PvInvalid активна. PV вернулась с другой
// ошибкой (6 % вместо 4 %): шаг инициализации, выход продолжается с удержанного без рывка.
METHOD PRIVATE PvFailHoldOutputBumplessResume
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    iStep    : INT;               // шаг цикла
    rBefore  : REAL;              // выход до отказа
    rFail    : REAL;              // выход через 2 с отказа
    eStFail  : E_Ne107Status;     // статус при отказе
    wFltFail : WORD;              // wFault при отказе
    wStsFail : WORD;              // wStatus при отказе
    wAlmFail : WORD;              // wAlmActive при отказе
    rResume  : REAL;              // выход в вызове возврата PV
END_VAR
