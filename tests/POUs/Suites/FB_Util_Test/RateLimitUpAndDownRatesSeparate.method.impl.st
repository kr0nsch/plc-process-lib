coUnit.TEST('Util_RateLimit_UpAndDownRatesSeparate');

AssertEquals_REAL(Expected := 25.0, Actual := F_RateLimit(rCurrent := 20.0, rTarget := 80.0,
                  rRateUp_ups := 10.0, rRateDown_ups := 2.0, lrDt_s := 0.5), Delta := 1.0E-5,
                  Message := 'rise 10/s over 0.5 s');
AssertEquals_REAL(Expected := 79.0, Actual := F_RateLimit(rCurrent := 80.0, rTarget := 20.0,
                  rRateUp_ups := 10.0, rRateDown_ups := 2.0, lrDt_s := 0.5), Delta := 1.0E-5,
                  Message := 'fall 2/s over 0.5 s');
AssertEquals_REAL(Expected := 27.5, Actual := F_RateLimit(rCurrent := 25.0, rTarget := 80.0,
                  rRateUp_ups := 10.0, rRateDown_ups := 2.0, lrDt_s := 0.25), Delta := 1.0E-5,
                  Message := 'rise 10/s over 0.25 s');
AssertEquals_REAL(Expected := 78.5, Actual := F_RateLimit(rCurrent := 79.0, rTarget := 20.0,
                  rRateUp_ups := 10.0, rRateDown_ups := 2.0, lrDt_s := 0.25), Delta := 1.0E-5,
                  Message := 'fall 2/s over 0.25 s');

coUnit.TEST_FINISHED();
