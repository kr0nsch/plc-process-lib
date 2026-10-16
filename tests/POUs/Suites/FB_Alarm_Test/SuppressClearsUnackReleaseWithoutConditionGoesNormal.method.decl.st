// Вход в подавление сбрасывает неквитированность (ActiveUnack → SuppressedByDesign); условие ушло
// во время подавления — снятие подавления даёт Normal, а не RtnUnack.
METHOD PRIVATE SuppressClearsUnackReleaseWithoutConditionGoesNormal
VAR
    fbTime : FB_FakeTime;    // подменное время
    fbAlm  : FB_Alarm;       // ФБ под тестом
    stCfg  : ST_AlarmCfg;    // параметры по умолчанию
END_VAR
