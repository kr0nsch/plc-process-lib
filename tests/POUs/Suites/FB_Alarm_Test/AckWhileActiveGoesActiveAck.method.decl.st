// Квитирование активной тревоги: Ack() возвращает TRUE и только ставит запрос; ближайший вызов
// тела переводит ActiveUnack → ActiveAck (тревога остаётся в списке, неквитированности нет).
METHOD PRIVATE AckWhileActiveGoesActiveAck
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    xRet   : BOOL;           // ответ метода
END_VAR
