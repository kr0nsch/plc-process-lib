// xActive показывает условие после задержек независимо от наложенного состояния: при shelve
// условие уходит и возвращается — xActive следует за ним, состояние Shelved не меняется.
METHOD PRIVATE ActiveWhileShelvedFollowsCondition
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    itfAlm : I_Alarm;        // тот же ФБ через интерфейс
END_VAR
