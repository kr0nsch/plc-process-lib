// Подмена при подтверждённом отказе датчика (наладка блокировок при оборванной линии): в Manual уставки считаются по
// подменённому значению (11.3, п. 7: принудительный сброс — только в Auto), тревоги уставок подавлены отказом
// (xLimitsOnFail = FALSE), значение годно, NE 107 — Failure. Возврат в Auto при оборванной линии — уставки сняты сразу,
// значение — удерживаемое до отказа, xValid = FALSE.
METHOD PRIVATE SubstitutionDuringFailureLimitsOnSubstValue
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
    itfAlm : I_Alarm;             // слот тревоги через интерфейс
END_VAR
