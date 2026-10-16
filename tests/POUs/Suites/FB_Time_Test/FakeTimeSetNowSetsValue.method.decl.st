// SetNow ставит время вперёд и назад (назад — допустимо, ФБ библиотеки это переживают).
METHOD PRIVATE FakeTimeSetNowSetsValue
VAR
    fbTime  : FB_FakeTime;   // подменное время, старт 1 ч
END_VAR
