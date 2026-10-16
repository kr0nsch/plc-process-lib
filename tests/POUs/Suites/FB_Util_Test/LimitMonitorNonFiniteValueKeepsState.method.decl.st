// Неконечное значение (NaN, ±Inf, больше REAL_SANE_MAX) флаг не меняет: -Inf не снимает
// взведённый флаг верхней уставки, +Inf не взводит снятый.
METHOD PRIVATE LimitMonitorNonFiniteValueKeepsState
VAR
    fbTime   : FB_FakeTime;       // подменное время
    fbLim    : FB_LimitMonitor;   // ФБ под тестом
    stLimCfg : ST_AiLimitCfg;     // параметры уставки
    uBits : U_RealBits;      // значение REAL по битам IEEE 754
END_VAR
