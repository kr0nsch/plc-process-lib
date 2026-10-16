// F_IsFinite: тихий NaN с обоими знаками и с полной мантиссой — FALSE (проверка R4 контракта).
METHOD PRIVATE IsFiniteNaNReturnsFalse
VAR
    uBits : U_RealBits;      // значение REAL по битам IEEE 754
END_VAR
