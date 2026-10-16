// F_IsFinite: |x| > REAL_SANE_MAX — мусор (перепутан порядок слов Modbus): 1e31, -1e31 и
// наибольшее REAL — FALSE.
METHOD PRIVATE IsFiniteAboveSaneMaxReturnsFalse
VAR
    uBits : U_RealBits;      // значение REAL по битам IEEE 754
END_VAR
