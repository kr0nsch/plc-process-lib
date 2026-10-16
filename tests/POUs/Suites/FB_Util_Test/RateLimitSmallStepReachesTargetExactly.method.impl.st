coUnit.TEST('Util_RateLimit_SmallStep_ReachesTargetExactly');

AssertEquals_REAL(Expected := 50.0, Actual := F_RateLimit(rCurrent := 49.5, rTarget := 50.0,
                  rRateUp_ups := 10.0, rRateDown_ups := 10.0, lrDt_s := 1.0), Delta := 0.0,
                  Message := 'rise: exactly the target');
AssertEquals_REAL(Expected := 50.0, Actual := F_RateLimit(rCurrent := 50.4, rTarget := 50.0,
                  rRateUp_ups := 10.0, rRateDown_ups := 10.0, lrDt_s := 0.1), Delta := 0.0,
                  Message := 'fall: exactly the target');

coUnit.TEST_FINISHED();
