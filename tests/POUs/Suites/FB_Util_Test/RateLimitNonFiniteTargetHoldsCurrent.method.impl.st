coUnit.TEST('Util_RateLimit_NonFiniteTarget_HoldsCurrent');

// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
uBits.dwValue := 16#7FC00000;
rOut := F_RateLimit(rCurrent := 42.0, rTarget := uBits.rValue, rRateUp_ups := 0.0, rRateDown_ups := 0.0,
                    lrDt_s := 0.1);
AssertTrue(Condition := F_IsFinite(rIn := rOut), Message := 'NaN target: result finite');
AssertEquals_REAL(Expected := 42.0, Actual := rOut, Delta := 0.0, Message := 'NaN target: hold');
uBits.dwValue := 16#7F800000;
rOut := F_RateLimit(rCurrent := 42.0, rTarget := uBits.rValue, rRateUp_ups := 0.0, rRateDown_ups := 0.0,
                    lrDt_s := 0.1);
AssertTrue(Condition := F_IsFinite(rIn := rOut), Message := '+Inf target: result finite');
AssertEquals_REAL(Expected := 42.0, Actual := rOut, Delta := 0.0, Message := '+Inf target: hold');
AssertEquals_REAL(Expected := 42.0, Actual := F_RateLimit(rCurrent := 42.0, rTarget := 1.0E31,
                  rRateUp_ups := 0.0, rRateDown_ups := 0.0, lrDt_s := 0.1), Delta := 0.0,
                  Message := 'target above REAL_SANE_MAX: hold');

coUnit.TEST_FINISHED();
