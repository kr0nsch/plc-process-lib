// Повторный Shelve во время shelve отсчитывает срок заново: через 40 мин после первого — снова 1 ч.
METHOD PRIVATE ReshelveRestartsTimer
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    xRet   : BOOL;           // ответ Shelve
END_VAR
