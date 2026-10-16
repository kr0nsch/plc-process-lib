// F_RateLimit: текущее значение NaN (мусор прошлого шага) заменяется конечной целью — ограничитель
// не застревает на NaN.
METHOD PRIVATE RateLimitNonFiniteCurrentJumpsToTarget
VAR
    uBits : U_RealBits;      // значение REAL по битам IEEE 754
END_VAR
