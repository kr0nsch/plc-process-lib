// Вызов тела одного слота FB_Alarm (часть RunAlarms). Слот передаётся через VAR_IN_OUT: вызов
// элемента массива ФБ afbAlarm[i](...) iec_checker 0.4 не разбирает. Внутренний шаг базы:
// PROTECTED, а не PRIVATE (правило L5 контракта); имя зарезервировано, наследник его не объявляет
METHOD PROTECTED CallAlarmSlot
VAR_INPUT
    xCond      : BOOL;          // условие тревоги слота
    xSupp      : BOOL;          // подавление по условию
    udiSlotId  : UDINT;         // номер тревоги: udiIdBase + слот
    rSlotValue : REAL;          // значение процесса для события
    stSlotCfg  : ST_AlarmCfg;   // параметры слота
END_VAR
VAR_IN_OUT
    fbAlarm : FB_Alarm;         // слот afbAlarm[i]
END_VAR
