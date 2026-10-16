// Тревога слота 0 PvInvalid: в Manual негодная PV тревоги не даёт; в Auto — ActiveUnack с номером
// udiAlarmIdBase + 0, квитирование — ActiveAck, возврат PV — Normal.
METHOD PRIVATE PvInvalidAlarmActiveOnlyInAuto
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    itfAlm   : I_Alarm;           // тревога PvInvalid
    eStMan   : E_AlarmState;      // состояние тревоги в Manual
    eStAuto  : E_AlarmState;      // в Auto при отказе PV
    eStAck   : E_AlarmState;      // после квитирования
END_VAR
