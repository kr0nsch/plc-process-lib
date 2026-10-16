coUnit.TEST('Util_RateLimit_NonFiniteCurrent_JumpsToTarget');

uBits.dwValue := 16#7FC00000;
AssertEquals_REAL(Expected := 42.0, Actual := F_RateLimit(rCurrent := uBits.rValue, rTarget := 42.0,
                  rRateUp_ups := 1.0, rRateDown_ups := 1.0, lrDt_s := 0.1), Delta := 0.0,
                  Message := 'NaN current: jump to the finite target');

coUnit.TEST_FINISHED();
