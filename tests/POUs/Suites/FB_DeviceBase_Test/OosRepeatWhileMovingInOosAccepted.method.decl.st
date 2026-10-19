// Повтор запроса OutOfService, когда устройство уже выведено из работы, а механизм движется (двигают по месту,
// xMoving): принимается (F-22 (в)) — битом команды и RequestMode: Accepted, uiCmdSeq + 1, режим OutOfService.
METHOD PRIVATE OosRepeatWhileMovingInOosAccepted
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация

    uiSeq    : UINT;               // номер команды после вывода из работы
    xRet     : BOOL;               // ответ RequestMode
END_VAR
