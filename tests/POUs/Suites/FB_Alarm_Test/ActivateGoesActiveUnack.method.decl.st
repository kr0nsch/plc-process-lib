// Условие появилось (без задержек): Normal → ActiveUnack; xActive, xUnacked, xInList взведены,
// udiSeq = 1, ltLastChange — время перехода.
METHOD PRIVATE ActivateGoesActiveUnack
VAR
    fbTime : FB_FakeTime;    // подменное время, старт 1 ч
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // Medium, без задержек, shelve до 8 ч
END_VAR
