// Нет напряжения при открытии: Intermediate, выходы сняты, VLV_WRN_POWER_LOST, отказа нет; команда —
// RejectedInhibit; 12 с без напряжения (больше tTravel) отказа хода не дают. Напряжение вернулось:
// Manual стоит (цель снята); Auto снова ведёт к цели. Готовность для автоматики (Available,
// VLV_STS_AVAILABLE) в Auto есть только при напряжении.
METHOD PRIVATE PowerLossStopsWithoutFault
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
