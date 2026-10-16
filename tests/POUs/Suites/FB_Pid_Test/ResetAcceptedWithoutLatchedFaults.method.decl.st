// Reset у ПИД (фиксируемых отказов нет): xReset и Reset() принимаются, каждая команда даёт +1 к
// uiCmdSeq, бит xReset сбрасывается (чек-лист устройства, пункт 2).
METHOD PRIVATE ResetAcceptedWithoutLatchedFaults
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: Manual
    stCfg    : ST_PidCfg;         // конфигурация по умолчанию
    xResOk   : BOOL;              // ответ Reset()
END_VAR
