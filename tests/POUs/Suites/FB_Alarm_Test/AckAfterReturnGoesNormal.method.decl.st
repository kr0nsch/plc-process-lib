// Квитирование вернувшейся тревоги: RtnUnack → Normal, тревога уходит из списка.
METHOD PRIVATE AckAfterReturnGoesNormal
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    xRet   : BOOL;           // ответ метода
END_VAR
