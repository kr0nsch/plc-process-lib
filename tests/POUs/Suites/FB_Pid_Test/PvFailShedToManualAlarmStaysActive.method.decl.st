// Отказ PV в Auto с реакцией ShedToManual: ФБ сам уходит в Manual, и тревога PvInvalid всё равно
// появляется (ActiveUnack) и держится, пока PV негодна: оператор должен узнать, что контур
// переведён на ручное управление. Возврат PV снимает условие (RtnUnack), квитирование — Normal.
// Выход из OutOfService в Manual при негодной PV тревоги не даёт: Manual выбрал оператор.
METHOD PRIVATE PvFailShedToManualAlarmStaysActive
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbPid    : FB_PID;            // ФБ под тестом
    stCmd    : ST_PidCmd;         // команды
    stRetain : ST_DeviceRetain;   // режим: старт в Manual
    stCfg    : ST_PidCfg;         // конфигурация теста
    itfAlm   : I_Alarm;           // тревога PvInvalid
    iStep    : INT;               // шаг цикла
    eModeSh  : E_DeviceMode;      // режим в вызове отказа PV
    eStShed  : E_AlarmState;      // тревога в вызове отказа PV
    eStHeld  : E_AlarmState;      // через 5 с в Manual при негодной PV
    wActHeld : WORD;              // wAlmActive через 5 с
    wUnaHeld : WORD;              // wAlmUnack через 5 с
    eStRtn   : E_AlarmState;      // после возврата PV
    eStAck   : E_AlarmState;      // после квитирования
    eStOper  : E_AlarmState;      // OutOfService -> Manual оператором при негодной PV
END_VAR
