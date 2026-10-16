// Каждая обработанная команда пишет eCmdResult и увеличивает uiCmdSeq: в одном вызове режим и пуск
// (в Auto отклонён) — +2, результат последней RejectedMode; Reset и маска shelve без
// принявших слотов — +2, результат RejectedState.
METHOD PRIVATE CmdResultSeqIncrementsPerCommand
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // слот 0: shelve запрещён
END_VAR
