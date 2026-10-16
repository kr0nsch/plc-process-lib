// Вопрос R2 для двух уровней: у FB_TestDeviceExt хук переопределён ещё раз. THIS^.OnModeChanged из
// метода FB_DeviceBase вызывает реализацию самого производного ФБ; её SUPER^.OnModeChanged
// выполняет часть FB_TestDevice, затем своя часть: след 12 на одну смену режима, 1212 — на две.
METHOD PRIVATE HookViaThisDispatchesToMostDerivedOverride
VAR
    fbTime   : FB_FakeTime;        // подменное время
    fbExt    : FB_TestDeviceExt;   // наследник второго уровня
    stCmd    : ST_TestDeviceCmd;   // команды
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
    stCfg    : ST_TestDeviceCfg;   // конфигурация по умолчанию
END_VAR
