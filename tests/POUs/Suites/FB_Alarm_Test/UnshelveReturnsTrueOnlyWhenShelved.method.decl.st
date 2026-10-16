// Unshelve возвращает TRUE, только пока shelve действует; без shelve запрос ни на что не влияет.
METHOD PRIVATE UnshelveReturnsTrueOnlyWhenShelved
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    xRet   : BOOL;           // ответ Unshelve
END_VAR
