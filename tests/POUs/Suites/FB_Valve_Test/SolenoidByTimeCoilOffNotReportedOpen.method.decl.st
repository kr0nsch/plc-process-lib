// Соленоид НЗ (SolenoidEto, без тока закрыт) без концевиков, Manual: открыт по времени хода (tTravel =
// 2 с, катушка под током). Пропало напряжение: катушка без тока, клапан уходит на пружину — «открыто»
// снято (Unknown). Напряжение вернулось: Manual стоит (цель снята), катушка без тока, «открыто» не
// показывается. Снова открыт по времени; Local и возврат в Manual: клапан, закрывшийся на пружине в
// Local, сам не открывается — катушка без команды не включается.
METHOD PRIVATE SolenoidByTimeCoilOffNotReportedOpen
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация: SolenoidEto без концевиков
    iStep    : INT;               // шаг цикла
    xEverOn  : BOOL;              // катушка включалась без команды
END_VAR
