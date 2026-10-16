// FB_Motor и FB_MotorVfd в одном массиве I_Motor: станция читает Running, Starts, RunSeconds без знания
// типа; тип в stCommon.eDevType — Motor и MotorVfd; Reset() через I_Device.
METHOD PRIVATE ImplementsIMotorPolymorphicArray
VAR
    fbTime         : FB_FakeTime;              // подменное время, старт 1 ч
    fbVfd          : FB_MotorVfd;              // двигатель с ПЧ под тестом
    stCmd          : ST_MotorCmd;              // команды
    stRetain       : ST_DeviceRetain;          // энергонезависимые данные
    stCfg          : ST_MotorCfg;              // конфигурация (умолчания)
    fbTime2        : FB_FakeTime;              // время двигателя прямого пуска
    fbMot          : FB_Motor;                 // двигатель прямого пуска
    stCmd2         : ST_MotorCmd;              // его команды
    stRetain2      : ST_DeviceRetain;          // его энергонезависимые данные
    // lint:allow STL007 массив a<префикс элемента>, см. docs/STATIC_ANALYSIS.md
    aitfMot        : ARRAY[1..2] OF I_Motor;   // насосы станции
    itfMot         : I_Motor;                  // насос через интерфейс
    itfDev         : I_Device;                 // устройство через интерфейс
    uiIdx          : UINT;                     // номер насоса
    uiRunningCount : UINT;                     // работающих
    udiStartsSum   : UDINT;                    // пусков всего
    udiRunSum      : UDINT;                    // наработка всего, с
END_VAR
