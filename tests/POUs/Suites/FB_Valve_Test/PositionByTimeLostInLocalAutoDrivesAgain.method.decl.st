// Концевиков нет, Auto: открыта по времени хода (tTravel = 10 с, на t0 + 10,0 с — Open). Local: с места
// арматуру могут закрыть, положение «по времени» больше не известно — Unknown, xOpened нет,
// VLV_WRN_POSITION_UNKNOWN. Возврат в дистанционный режим (Auto, xAutoOpen): привод снова ведёт к цели —
// Opening, выход «открывать» на tTravel, ровно через 10,0 с — снова Open по времени. С устаревшим «Open»
// автоматика считала бы открытой задвижку, которую закрыли с места.
METHOD PRIVATE PositionByTimeLostInLocalAutoDrivesAgain
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим: Auto
    stCfg    : ST_ValveCfg;       // конфигурация: без концевиков
    iStep    : INT;               // шаг цикла
END_VAR
