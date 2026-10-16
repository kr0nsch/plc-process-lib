// F_RateLimit: цель NaN, +Inf или больше REAL_SANE_MAX (мусор из Modbus/ПИД) — значение удерживается.
METHOD PRIVATE RateLimitNonFiniteTargetHoldsCurrent
VAR
    uBits : U_RealBits;      // значение REAL по битам IEEE 754
    rOut  : REAL;            // результат F_RateLimit
END_VAR
