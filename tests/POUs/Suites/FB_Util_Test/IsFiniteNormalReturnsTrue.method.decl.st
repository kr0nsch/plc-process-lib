// F_IsFinite: обычные числа, 0, -0, наименьшее денормализованное и граница ±REAL_SANE_MAX
// (включительно) — TRUE.
METHOD PRIVATE IsFiniteNormalReturnsTrue
VAR
    uBits : U_RealBits;      // значение REAL по битам IEEE 754
END_VAR
