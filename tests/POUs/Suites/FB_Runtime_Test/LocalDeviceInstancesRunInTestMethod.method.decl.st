// R5 контракта: шесть экземпляров устройства (FB_TestDeviceExt: 8 слотов FB_Alarm, LKG) и их
// структуры — локальные переменные метода теста; стека задачи хватает, все работают.
METHOD PRIVATE LocalDeviceInstancesRunInTestMethod
VAR
    fbTime   : FB_FakeTime;                            // подменное время
    // lint:allow STL007 массив a<префикс элемента>, см. docs/STATIC_ANALYSIS.md
    afbDev   : ARRAY[0..5] OF FB_TestDeviceExt;        // устройства в стеке метода
    // lint:allow STL007 массив a<префикс элемента>, см. docs/STATIC_ANALYSIS.md
    astCmd   : ARRAY[0..5] OF ST_TestDeviceCmd;        // их команды
    // lint:allow STL007 массив a<префикс элемента>, см. docs/STATIC_ANALYSIS.md
    astRet   : ARRAY[0..5] OF ST_DeviceRetain;         // их retain
    stCfg    : ST_TestDeviceCfg;                       // общая конфигурация
    itfDev   : I_Device;                               // устройство через интерфейс
    uiDev    : UINT;                                   // номер устройства
    xAllAuto : BOOL := TRUE;                           // все перешли в Auto
END_VAR
