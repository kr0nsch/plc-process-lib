coUnit.TEST('Util_IsFinite_Inf_ReturnsFalse');

uBits.dwValue := 16#7F800000;
AssertFalse(Condition := F_IsFinite(rIn := uBits.rValue), Message := '+Inf 16#7F800000');
uBits.dwValue := 16#FF800000;
AssertFalse(Condition := F_IsFinite(rIn := uBits.rValue), Message := '-Inf 16#FF800000');

coUnit.TEST_FINISHED();
