// F_IsFinite: +Inf и -Inf — FALSE.
METHOD PRIVATE IsFiniteInfReturnsFalse
VAR
    uBits : U_RealBits;      // значение REAL по битам IEEE 754
END_VAR
