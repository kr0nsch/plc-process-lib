// L1 контракта во время выполнения: у наследника со своим телом без SUPER^ тело базы не
// выполняется само — импульс режима не обработан, FinishCycle не вызван (eDevType = None).
METHOD PRIVATE DerivedBodyWithoutSuperBaseBodyNotRun
VAR
    fbTime   : FB_FakeTime;            // подменное время
    fbNo     : FB_TestDeviceNoSuper;   // наследник без SUPER^
    stCmd    : ST_TestDeviceCmd;       // команды
    stRetain : ST_DeviceRetain;        // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;       // конфигурация по умолчанию
END_VAR
