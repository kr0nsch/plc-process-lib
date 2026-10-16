coUnit.TEST('Util_IsFinite_NaN_ReturnsFalse');

uBits.dwValue := 16#7FC00000;
AssertFalse(Condition := F_IsFinite(rIn := uBits.rValue), Message := 'quiet NaN 16#7FC00000');
uBits.dwValue := 16#FFC00000;
AssertFalse(Condition := F_IsFinite(rIn := uBits.rValue), Message := 'negative quiet NaN 16#FFC00000');
uBits.dwValue := 16#7FFFFFFF;
AssertFalse(Condition := F_IsFinite(rIn := uBits.rValue), Message := 'NaN with full mantissa 16#7FFFFFFF');

coUnit.TEST_FINISHED();
