// Срок shelve истёк во время подавления: состояние остаётся SuppressedByDesign, xShelved снят;
// снятие подавления при активном условии — ActiveUnack.
METHOD PRIVATE ShelveExpiresDuringSuppressReleaseGoesToBase
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // tShelveMax = 1 ч
END_VAR
