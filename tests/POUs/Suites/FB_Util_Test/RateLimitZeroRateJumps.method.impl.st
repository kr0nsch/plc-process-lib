coUnit.TEST('Util_RateLimit_ZeroRate_Jumps');

AssertEquals_REAL(Expected := 80.0, Actual := F_RateLimit(rCurrent := 20.0, rTarget := 80.0,
                  rRateUp_ups := 0.0, rRateDown_ups := 0.0, lrDt_s := 0.1), Delta := 0.0,
                  Message := 'zero rates: rise jumps to the target');
AssertEquals_REAL(Expected := 20.0, Actual := F_RateLimit(rCurrent := 80.0, rTarget := 20.0,
                  rRateUp_ups := 0.0, rRateDown_ups := 0.0, lrDt_s := 0.1), Delta := 0.0,
                  Message := 'zero rates: fall jumps to the target');
AssertEquals_REAL(Expected := 80.0, Actual := F_RateLimit(rCurrent := 20.0, rTarget := 80.0,
                  rRateUp_ups := 0.0, rRateDown_ups := 5.0, lrDt_s := 1.0), Delta := 0.0,
                  Message := 'zero rise rate: jump up');
AssertEquals_REAL(Expected := 75.0, Actual := F_RateLimit(rCurrent := 80.0, rTarget := 20.0,
                  rRateUp_ups := 0.0, rRateDown_ups := 5.0, lrDt_s := 1.0), Delta := 1.0E-5,
                  Message := 'fall rate 5/s still limits');

coUnit.TEST_FINISHED();
