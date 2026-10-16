coUnit.TEST('Pid_SetpointNaN_HeldTargetWithinSpLimits');
uBits.dwValue := 16#7FC00000;                                                          // тихий NaN
stCfg.rSpMin_eu := 20.0;
stCfg.rSpMax_eu := 80.0;
stCmd.rSp_eu := uBits.rValue;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: задание NaN
rTgtStart := fbPid.stSts.rSpTarget_eu;
rSpStart := fbPid.stSts.rSp_eu;
stCmd.rSp_eu := 70.0;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rTgtValid := fbPid.stSts.rSpTarget_eu;
stCmd.rSp_eu := uBits.rValue;
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
rTgtHeld := fbPid.stSts.rSpTarget_eu;
stCfg.rSpMax_eu := 60.0;                                                               // наладчик сузил пределы
fbTime.Advance(tStep := T#100MS);
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := rTgtStart) AND F_IsFinite(rIn := rSpStart) AND F_IsFinite(rIn := rTgtHeld),
           Message := 'targets stay finite');
AssertEquals_REAL(Expected := 20.0, Actual := rTgtStart, Delta := 0.0, Message := 'NaN at start: target = rSpMin_eu');
AssertEquals_REAL(Expected := 20.0, Actual := rSpStart, Delta := 0.0, Message := 'NaN at start: SP = rSpMin_eu');
AssertEquals_REAL(Expected := 70.0, Actual := rTgtValid, Delta := 0.0, Message := 'finite SP accepted');
AssertEquals_REAL(Expected := 70.0, Actual := rTgtHeld, Delta := 0.0, Message := 'NaN SP: previous target held');
AssertEquals_REAL(Expected := 60.0, Actual := fbPid.stSts.rSpTarget_eu, Delta := 0.0,
                  Message := 'held target limited by new rSpMax_eu');
AssertEquals_REAL(Expected := 60.0, Actual := fbPid.stSts.rSp_eu, Delta := 0.0, Message := 'SP follows limited target');
AssertEquals_WORD(Expected := GVL_Const.PID_WRN_SP_INVALID, Actual := fbPid.stSts.stCommon.wWarning,
                  Message := 'warning SP_INVALID');
coUnit.TEST_FINISHED();
