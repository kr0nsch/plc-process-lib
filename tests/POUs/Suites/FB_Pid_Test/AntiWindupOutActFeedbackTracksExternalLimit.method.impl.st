coUnit.TEST('Pid_AntiWindup_OutActFeedback_TracksExternalLimit');
// источник: tools/reference/pid.py, сценарий outact
stCfgAct.rKp := 1.0;
stCfgAct.rTi_s := 10.0;
stCfgNoAct := stCfgAct;
stCfgAct.xUseOutAct := TRUE;
stCmdAct.rManualOut_pct := 50.0;
stCmdAct.rSp_eu := 50.0;
stCmdNoAct := stCmdAct;
fbPidAct.rPv_eu := 50.0;
fbPidAct.xPvValid := TRUE;
fbPidNoAct.rPv_eu := 50.0;
fbPidNoAct.xPvValid := TRUE;
fbPidAct(itfTime := fbTime, stCmd := stCmdAct, stRetain := stRetAct, stCfg := stCfgAct);          // t0: Manual
fbPidNoAct(itfTime := fbTime, stCmd := stCmdNoAct, stRetain := stRetNoAct, stCfg := stCfgNoAct);
fbPidAct.rOutAct_pct := MAX(30.0, fbPidAct.rOut_pct);
fbPidNoAct.rOutAct_pct := MAX(30.0, fbPidNoAct.rOut_pct);
fbTime.Advance(tStep := T#100MS);
stCmdAct.stCommon.xSetAuto := TRUE;
stCmdNoAct.stCommon.xSetAuto := TRUE;
fbPidAct(itfTime := fbTime, stCmd := stCmdAct, stRetain := stRetAct, stCfg := stCfgAct);          // Auto
fbPidNoAct(itfTime := fbTime, stCmd := stCmdNoAct, stRetain := stRetNoAct, stCfg := stCfgNoAct);
fbPidAct.rPv_eu := 60.0;                                                                            // e = -10 %
fbPidNoAct.rPv_eu := 60.0;
FOR iStep := 1 TO 600 DO                                                                            // 60 с
    fbPidAct.rOutAct_pct := MAX(30.0, fbPidAct.rOut_pct);
    fbPidNoAct.rOutAct_pct := MAX(30.0, fbPidNoAct.rOut_pct);
    fbTime.Advance(tStep := T#100MS);
    fbPidAct(itfTime := fbTime, stCmd := stCmdAct, stRetain := stRetAct, stCfg := stCfgAct);
    fbPidNoAct(itfTime := fbTime, stCmd := stCmdNoAct, stRetain := stRetNoAct, stCfg := stCfgNoAct);
END_FOR
rHoldAct := fbPidAct.rOut_pct;
rHoldNoAct := fbPidNoAct.rOut_pct;
fbPidAct.rPv_eu := 40.0;                                                                            // e = +10 %
fbPidNoAct.rPv_eu := 40.0;
FOR iStep := 1 TO 30 DO                                                                             // 3 с
    fbPidAct.rOutAct_pct := MAX(30.0, fbPidAct.rOut_pct);
    fbPidNoAct.rOutAct_pct := MAX(30.0, fbPidNoAct.rOut_pct);
    fbTime.Advance(tStep := T#100MS);
    fbPidAct(itfTime := fbTime, stCmd := stCmdAct, stRetain := stRetAct, stCfg := stCfgAct);
    fbPidNoAct(itfTime := fbTime, stCmd := stCmdNoAct, stRetain := stRetNoAct, stCfg := stCfgNoAct);
END_FOR
// ref: outact.out_hold_act
AssertEquals_REAL(Expected := 20.067717, Actual := rHoldAct, Delta := 1.0E-3, Message := 'held near external limit');
// ref: outact.out_hold_noact
AssertEquals_REAL(Expected := 0.0, Actual := rHoldNoAct, Delta := 1.0E-4, Message := 'without OutAct: down to 0');
// ref: outact.out_rev_act
AssertEquals_REAL(Expected := 42.839634, Actual := fbPidAct.rOut_pct, Delta := 1.0E-3, Message := 'responds at once');
// ref: outact.out_rev_noact
AssertEquals_REAL(Expected := 14.239797, Actual := fbPidNoAct.rOut_pct, Delta := 1.0E-3, Message := 'still below 30 %');
AssertTrue(Condition := fbPidAct.rOut_pct > 30.0, Message := 'with OutAct the actuator moves above its minimum');
AssertTrue(Condition := fbPidNoAct.rOut_pct < 30.0, Message := 'without OutAct the actuator still sits at 30 %');
coUnit.TEST_FINISHED();
