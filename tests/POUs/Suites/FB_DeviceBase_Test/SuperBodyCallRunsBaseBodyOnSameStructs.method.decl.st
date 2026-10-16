// Вопрос R3 контракта: SUPER^(stCmd := stCmd, stRetain := stRetain, stCfg := stCfg) в теле
// наследника выполняет тело базы один раз за вызов над теми же структурами, что переданы в вызов
// наследника: импульс сброшен и режим записан в структурах вызывающего, Cfg вызывающего прочитана,
// запись наследника в stCmd после SUPER^ видна; точка расширения до SUPER^ действует; вызов с
// другими структурами работает с ними.
METHOD PRIVATE SuperBodyCallRunsBaseBodyOnSameStructs
VAR
    fbTime    : FB_FakeTime;        // подменное время
    fbExt     : FB_TestDeviceExt;   // наследник с SUPER^
    stCmd     : ST_TestDeviceCmd;   // команды (первый набор)
    stRetain  : ST_DeviceRetain;    // энергонезависимые данные (первый набор)
    stCmd2    : ST_TestDeviceCmd;   // команды (второй набор)
    stRetain2 : ST_DeviceRetain;    // энергонезависимые данные (второй набор)
    stCfg     : ST_TestDeviceCfg;   // rGain = 3
END_VAR
