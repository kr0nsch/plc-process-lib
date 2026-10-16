// Условие ушло до квитирования: ActiveUnack → RtnUnack; тревога остаётся неквитированной и в списке.
METHOD PRIVATE ReturnWithoutAckGoesRtnUnack
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
END_VAR
