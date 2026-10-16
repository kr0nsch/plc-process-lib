coUnit.TEST('Util_RateLimit_ZeroDt_NoChange');

AssertEquals_REAL(Expected := 20.0, Actual := F_RateLimit(rCurrent := 20.0, rTarget := 80.0,
                  rRateUp_ups := 10.0, rRateDown_ups := 10.0, lrDt_s := 0.0), Delta := 0.0,
                  Message := 'dt = 0: no change');
AssertEquals_REAL(Expected := 20.0, Actual := F_RateLimit(rCurrent := 20.0, rTarget := 80.0,
                  rRateUp_ups := 0.0, rRateDown_ups := 0.0, lrDt_s := -1.0), Delta := 0.0,
                  Message := 'dt < 0: no change even without rate limits');

coUnit.TEST_FINISHED();
