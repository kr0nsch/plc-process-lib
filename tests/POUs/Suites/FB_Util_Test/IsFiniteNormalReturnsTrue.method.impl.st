coUnit.TEST('Util_IsFinite_Normal_ReturnsTrue');

AssertTrue(Condition := F_IsFinite(rIn := 1.5), Message := '1.5');
AssertTrue(Condition := F_IsFinite(rIn := -273.15), Message := '-273.15');
AssertTrue(Condition := F_IsFinite(rIn := 0.0), Message := '0.0');
uBits.dwValue := 16#80000000;
AssertTrue(Condition := F_IsFinite(rIn := uBits.rValue), Message := '-0.0');
uBits.dwValue := 16#00000001;
AssertTrue(Condition := F_IsFinite(rIn := uBits.rValue), Message := 'smallest denormal');
AssertTrue(Condition := F_IsFinite(rIn := GVL_Const.REAL_SANE_MAX), Message := 'REAL_SANE_MAX is inclusive');
AssertTrue(Condition := F_IsFinite(rIn := -GVL_Const.REAL_SANE_MAX), Message := '-REAL_SANE_MAX is inclusive');

coUnit.TEST_FINISHED();
