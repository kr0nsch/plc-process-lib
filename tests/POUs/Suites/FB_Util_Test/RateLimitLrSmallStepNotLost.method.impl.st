coUnit.TEST('Util_RateLimitLr_SmallStep_NotLost');

lrUp := 70.0;
lrDown := 70.0;
FOR iStep := 1 TO 1000 DO
    lrUp := F_RateLimitLr(lrCurrent := lrUp, rTarget := 100.0, rRateUp_ups := 0.003, rRateDown_ups := 0.003,
                          lrDt_s := 0.001);
    lrDown := F_RateLimitLr(lrCurrent := lrDown, rTarget := 0.0, rRateUp_ups := 0.003, rRateDown_ups := 0.003,
                            lrDt_s := 0.001);
END_FOR
// ожидаемое: 70 ± 0,003 · 1 с; допуск — шаг REAL скорости 0,003 · 1000 шагов
AssertEquals_LREAL(Expected := LREAL#70.003, Actual := lrUp, Delta := LREAL#1.0E-7, Message := 'ramp up not lost');
AssertEquals_LREAL(Expected := LREAL#69.997, Actual := lrDown, Delta := LREAL#1.0E-7, Message := 'ramp down not lost');
AssertEquals_LREAL(Expected := LREAL#42.5, Actual := F_RateLimitLr(lrCurrent := LREAL#42.49, rTarget := 42.5,
                   rRateUp_ups := 1.0, rRateDown_ups := 1.0, lrDt_s := 1.0), Delta := LREAL#0.0,
                   Message := 'reaches the target exactly');

coUnit.TEST_FINISHED();
