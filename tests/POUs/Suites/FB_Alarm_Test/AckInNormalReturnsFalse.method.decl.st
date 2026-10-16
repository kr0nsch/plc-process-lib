// Ack без эффекта: в Normal и ActiveAck метод возвращает FALSE и переходов не даёт.
METHOD PRIVATE AckInNormalReturnsFalse
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
    xRet   : BOOL;           // ответ Ack
END_VAR
