// Запросы методов Reset(), AckAll() и RequestMode() выполняет один ближайший вызов тела, затем они
// снимаются (FinishCycle): uiCmdSeq растёт на 1 за запрос, а не в каждом цикле; тревога, появившаяся
// после выполненного запроса, остаётся неквитированной; режим, сменённый командой после
// RequestMode(), повторный запрос не возвращает. Иначе Reset() станции квитировал бы все будущие
// тревоги и бесконечно повторял бы сброс
METHOD PRIVATE MethodRequestsProcessedOnce
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
    iStep    : INT;                // шаг цикла
END_VAR
