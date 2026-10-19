// F_RateLimitLr: цель NaN (мусор Modbus) или шаг времени 0 — значение не меняется; скорость 0 — сразу к цели;
// текущее значение NaN — сразу к цели (как F_RateLimit, F-11).
METHOD PRIVATE RateLimitLrNonFiniteTargetOrZeroDtHoldsCurrent
VAR
    uBits : U_RealBits;      // значение REAL по битам IEEE 754
    lrOut : LREAL;           // результат F_RateLimitLr
    lrNaN : LREAL;           // NaN в LREAL
END_VAR
