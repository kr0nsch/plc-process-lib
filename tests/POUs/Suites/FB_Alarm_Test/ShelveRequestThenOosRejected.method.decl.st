// Запрос Shelve принят методом (тревога ещё не в OutOfService), но в ближайшем вызове тела поднялся
// xOutOfService: тело запрос отклоняет — shelve не начинается, после выхода из OutOfService тревога
// не Shelved, а базовое состояние (условие активно — ActiveUnack). F-21 (в), контракт 10.1
METHOD PRIVATE ShelveRequestThenOosRejected
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию (tShelveMax 8 ч)
    xRet   : BOOL;           // ответ Shelve
END_VAR
