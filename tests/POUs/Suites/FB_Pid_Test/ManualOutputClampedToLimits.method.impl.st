coUnit.TEST('Pid_Manual_OutputClampedToLimits');
stCfg.rOutMin_pct := 10.0;
stCfg.rOutMax_pct := 90.0;
stCfg.rSafeOut_pct := 10.0;                                                            // в пределах выхода (бит 11)
stCmd.rManualOut_pct := 95.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
rOutHi := fbPid.rOut_pct;
xSatHi := fbPid.xSatHigh;
stCmd.rManualOut_pct := 5.0;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rOutLo := fbPid.rOut_pct;
xSatLo := fbPid.xSatLow;
AssertEquals_REAL(Expected := 90.0, Actual := rOutHi, Delta := 0.0, Message := 'clamped to rOutMax_pct');
AssertTrue(Condition := xSatHi, Message := 'xSatHigh at max');
AssertEquals_REAL(Expected := 10.0, Actual := rOutLo, Delta := 0.0, Message := 'clamped to rOutMin_pct');
AssertTrue(Condition := xSatLo, Message := 'xSatLow exactly at min');
AssertEquals_REAL(Expected := 5.0, Actual := stCmd.rManualOut_pct, Delta := 0.0, Message := 'operator value kept');
coUnit.TEST_FINISHED();
