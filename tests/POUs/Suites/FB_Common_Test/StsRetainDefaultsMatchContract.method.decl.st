// Умолчания общего заголовка и энергонезависимых данных: до первого вызова eMode = Manual,
// eNe107 = CheckFunction («не проверено»), тип None; дистанционный режим в Retain — Manual.
// Вложенный заголовок stCommon сохраняет свои умолчания.
METHOD PRIVATE StsRetainDefaultsMatchContract
VAR
    stDev    : ST_DeviceSts;       // общий заголовок
    stMot    : ST_MotorSts;        // вложенный заголовок
    stRetain : ST_DeviceRetain;    // энергонезависимые данные
END_VAR
