// tShelveMax = T#0S запрещает shelve: Shelve() возвращает FALSE, тревога остаётся ActiveUnack.
// Выключенная тревога (приоритет None) shelve тоже не принимает.
METHOD PRIVATE ShelveMaxZeroShelveRejected
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // tShelveMax = 0
    xRet   : BOOL;           // ответ Shelve
END_VAR
