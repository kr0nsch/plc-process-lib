// FinishCycle заполняет все 14 полей stCommon: слово состояния (биты устройства и общие),
// wFault, wWarning, wCfgErr, режим, NE 107, результат и номер команды, маски тревог, наивысший
// приоритет неквитированных, тип устройства, резерв.
METHOD PRIVATE StsHeaderAllFieldsFilled
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbDev    : FB_TestDevice;      // устройство под тестом
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // слот 0: High
    stHdr    : ST_DeviceSts;       // копия заголовка
END_VAR
