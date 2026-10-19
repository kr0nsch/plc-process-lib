coUnit.TEST('Util_RateLimitLr_NonFiniteTargetOrZeroDt_HoldsCurrent');

uBits.dwValue := 16#7FC00000;
lrOut := F_RateLimitLr(lrCurrent := LREAL#42.0, rTarget := uBits.rValue, rRateUp_ups := 1.0, rRateDown_ups := 1.0,
                       lrDt_s := 0.1);
// AssertEquals_LREAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := LREAL_TO_REAL(lrOut)), Message := 'NaN target: result finite');
AssertEquals_LREAL(Expected := LREAL#42.0, Actual := lrOut, Delta := LREAL#0.0, Message := 'NaN target: hold');
AssertEquals_LREAL(Expected := LREAL#42.0, Actual := F_RateLimitLr(lrCurrent := LREAL#42.0, rTarget := 50.0,
                   rRateUp_ups := 1.0, rRateDown_ups := 1.0, lrDt_s := 0.0), Delta := LREAL#0.0,
                   Message := 'zero dt: hold');
AssertEquals_LREAL(Expected := LREAL#50.0, Actual := F_RateLimitLr(lrCurrent := LREAL#42.0, rTarget := 50.0,
                   rRateUp_ups := 0.0, rRateDown_ups := 0.0, lrDt_s := 0.1), Delta := LREAL#0.0,
                   Message := 'zero rate: jumps to target');
lrNaN := REAL_TO_LREAL(uBits.rValue);
lrOut := F_RateLimitLr(lrCurrent := lrNaN, rTarget := 50.0, rRateUp_ups := 1.0, rRateDown_ups := 1.0, lrDt_s := 0.1);
AssertTrue(Condition := F_IsFinite(rIn := LREAL_TO_REAL(lrOut)), Message := 'NaN current: result finite');
AssertEquals_LREAL(Expected := LREAL#50.0, Actual := lrOut, Delta := LREAL#0.0,
                   Message := 'NaN current: jumps to target');

coUnit.TEST_FINISHED();
