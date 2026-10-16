coUnit.TEST('Pid_OutputLimits_ClampAndFlags');
// источник: tools/reference/pid.py, сценарий limits
stCfg.rKp := 2.0;
stCfg.rTi_s := 0.0;
stCfg.rOutMin_pct := 10.0;
stCfg.rOutMax_pct := 90.0;
stCfg.rSafeOut_pct := 10.0;                                                            // в пределах выхода (бит 11)
stCmd.rManualOut_pct := 50.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
fbPid.rPv_eu := 20.0;                                                                  // v = 50 + 60 = 110
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: limits.out_high
AssertEquals_REAL(Expected := 90.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'clamped to rOutMax_pct');
AssertTrue(Condition := fbPid.xSatHigh, Message := 'xSatHigh');
AssertFalse(Condition := fbPid.xSatLow, Message := 'no xSatLow at max');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_SAT_HIGH,
                  Actual := fbPid.stSts.stCommon.wStatus AND (GVL_Const.PID_STS_SAT_HIGH OR GVL_Const.PID_STS_SAT_LOW),
                  Message := 'status bit SAT_HIGH only');
fbPid.rPv_eu := 80.0;                                                                  // v = 50 - 60 = -10
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// ref: limits.out_low
AssertEquals_REAL(Expected := 10.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'clamped to rOutMin_pct');
AssertTrue(Condition := fbPid.xSatLow, Message := 'xSatLow');
AssertFalse(Condition := fbPid.xSatHigh, Message := 'no xSatHigh at min');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_SAT_LOW,
                  Actual := fbPid.stSts.stCommon.wStatus AND (GVL_Const.PID_STS_SAT_HIGH OR GVL_Const.PID_STS_SAT_LOW),
                  Message := 'status bit SAT_LOW only');
coUnit.TEST_FINISHED();
