coUnit.TEST('Pid_PvFail_HoldOutput_BumplessResume');
// источник: tools/reference/pid.py, сценарий pv_fail_hold
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
fbTime.Advance(tStep := T#100MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto
fbPid.rPv_eu := 46.0;                                                                  // e = 4 %
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rBefore := fbPid.rOut_pct;
fbPid.xPvValid := FALSE;                                                               // отказ PV
FOR iStep := 1 TO 20 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
rFail := fbPid.rOut_pct;
eStFail := fbPid.Status;
wFltFail := fbPid.stSts.stCommon.wFault;
wStsFail := fbPid.stSts.stCommon.wStatus;
wAlmFail := fbPid.stSts.stCommon.wAlmActive;
fbPid.xPvValid := TRUE;                                                                // PV вернулась
fbPid.rPv_eu := 44.0;                                                                  // e = 6 %
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rResume := fbPid.rOut_pct;
FOR iStep := 1 TO 2 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: pv_fail_hold.out_before
AssertEquals_REAL(Expected := 38.72, Actual := rBefore, Delta := 1.0E-4, Message := 'output before PV failure');
// ref: pv_fail_hold.out_fail
AssertEquals_REAL(Expected := 38.72, Actual := rFail, Delta := 1.0E-4, Message := 'Hold: output held');
AssertTrue(Condition := eStFail = E_Ne107Status.Failure, Message := 'Failure while PV invalid in Auto');
AssertEquals_WORD(Expected := GVL_Const.PID_FLT_PV_INVALID, Actual := wFltFail, Message := 'wFault PV_INVALID');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_PV_FAIL, Actual := wStsFail AND GVL_Const.PID_STS_PV_FAIL,
                  Message := 'status bit PV_FAIL');
AssertEquals_WORD(Expected := 16#0001, Actual := wAlmFail, Message := 'alarm PvInvalid active');
// ref: pv_fail_hold.out_resume
AssertEquals_REAL(Expected := 38.72, Actual := rResume, Delta := 1.0E-4, Message := 'resume without bump');
// ref: pv_fail_hold.out_resume_2
AssertEquals_REAL(Expected := 38.84, Actual := fbPid.rOut_pct, Delta := 1.0E-4,
                  Message := 'then integral with e = 6 %');
AssertTrue(Condition := fbPid.Status = E_Ne107Status.Good, Message := 'Good after PV recovery');
coUnit.TEST_FINISHED();
