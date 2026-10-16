// Свойства I_Alarm совпадают с выходами ФБ: Id, State, AlarmPriority, Active, Unacked, Seq.
METHOD PRIVATE InterfacePropertiesMatchOutputs
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // приоритет Low
    itfAlm : I_Alarm;        // тот же ФБ через интерфейс
END_VAR
