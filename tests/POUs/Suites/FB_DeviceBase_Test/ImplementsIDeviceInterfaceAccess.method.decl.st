// Устройства через I_Device (массив интерфейсов, как у станционной логики): RequestMode, Reset,
// Mode, Status, Fault, Available, AlarmCount, GetAlarm, AckAll работают одинаково для
// FB_TestDevice и его наследника.
METHOD PRIVATE ImplementsIDeviceInterfaceAccess
VAR
    fbTime    : FB_FakeTime;        // подменное время
    fbDev     : FB_TestDevice;      // первое устройство
    fbExt     : FB_TestDeviceExt;   // второе устройство (наследник)
    stCmd     : ST_TestDeviceCmd;   // команды первого
    stRetain  : ST_DeviceRetain;    // retain первого
    stCmd2    : ST_TestDeviceCmd;   // команды второго
    stRetain2 : ST_DeviceRetain;    // retain второго
    stCfg     : ST_TestDeviceCfg;   // общая конфигурация
    // lint:allow STL007 массив a<префикс элемента>, см. docs/STATIC_ANALYSIS.md
    aitfDev   : ARRAY[0..1] OF I_Device;   // устройства через интерфейс
    itfDev    : I_Device;           // элемент массива
    itfAlm    : I_Alarm;            // тревога через интерфейс
    uiDev     : UINT;               // номер устройства
    xAllAuto  : BOOL := TRUE;       // все в Auto
    xRet      : BOOL;               // ответы методов
END_VAR
