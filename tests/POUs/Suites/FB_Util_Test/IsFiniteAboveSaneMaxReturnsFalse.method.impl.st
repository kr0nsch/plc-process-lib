coUnit.TEST('Util_IsFinite_AboveSaneMax_ReturnsFalse');

AssertFalse(Condition := F_IsFinite(rIn := 1.0E31), Message := '1e31 is above REAL_SANE_MAX');
AssertFalse(Condition := F_IsFinite(rIn := -1.0E31), Message := '-1e31 is above REAL_SANE_MAX');
uBits.dwValue := 16#7F7FFFFF;
AssertFalse(Condition := F_IsFinite(rIn := uBits.rValue), Message := 'largest REAL is above REAL_SANE_MAX');

coUnit.TEST_FINISHED();
