// R13 контракта (данные для Control Win V3, не для ПЛК210): 300 копирований ST_MotorCfg (216 байт —
// копия LKG одного двигателя за цикл) занимают меньше 1 мс.
METHOD PRIVATE LkgCopy300MotorCfgBelow1ms
VAR
    fbSys   : FB_SystemTime;   // системное время
    stSrc   : ST_MotorCfg;     // источник копии
    stDst   : ST_MotorCfg;     // приёмник копии
    ltStart : LTIME;           // начало замера
    ltEnd   : LTIME;           // конец замера
    iStep   : INT;             // шаг цикла
END_VAR
