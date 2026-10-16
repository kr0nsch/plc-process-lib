coUnit.TEST('Pid_AntiWindup_LongSaturation_RecoversWithinTt');
// источник: tools/reference/pid.py, сценарий aw_recovery
stCfgAw.rKp := 1.0;
stCfgAw.rTi_s := 10.0;
stCfgAw.rTt_s := 0.0;
stCfgNoAw := stCfgAw;
stCfgNoAw.rTt_s := 1.0E6;
stCmdAw.rManualOut_pct := 50.0;
stCmdAw.rSp_eu := 50.0;
stCmdNoAw := stCmdAw;
fbPidAw.rPv_eu := 50.0;
fbPidAw.xPvValid := TRUE;
fbPidNoAw.rPv_eu := 50.0;
fbPidNoAw.xPvValid := TRUE;
fbPidAw(itfTime := fbTime, stCmd := stCmdAw, stRetain := stRetAw, stCfg := stCfgAw);          // t0: Manual
fbPidNoAw(itfTime := fbTime, stCmd := stCmdNoAw, stRetain := stRetNoAw, stCfg := stCfgNoAw);
fbTime.Advance(tStep := T#100MS);
stCmdAw.stCommon.xSetAuto := TRUE;
stCmdNoAw.stCommon.xSetAuto := TRUE;
fbPidAw(itfTime := fbTime, stCmd := stCmdAw, stRetain := stRetAw, stCfg := stCfgAw);          // Auto
fbPidNoAw(itfTime := fbTime, stCmd := stCmdNoAw, stRetain := stRetNoAw, stCfg := stCfgNoAw);
fbPidAw.rPv_eu := 30.0;                                                                         // e = +20 %
fbPidNoAw.rPv_eu := 30.0;
FOR iStep := 1 TO 600 DO                                                                        // 60 с
    fbTime.Advance(tStep := T#100MS);
    fbPidAw(itfTime := fbTime, stCmd := stCmdAw, stRetain := stRetAw, stCfg := stCfgAw);
    fbPidNoAw(itfTime := fbTime, stCmd := stCmdNoAw, stRetain := stRetNoAw, stCfg := stCfgNoAw);
END_FOR
rOutSatAw := fbPidAw.rOut_pct;
rISatAw := fbPidAw.stSts.rI_pct;
rISatNoAw := fbPidNoAw.stSts.rI_pct;
fbPidAw.rPv_eu := 70.0;                                                                         // e = -20 %
fbPidNoAw.rPv_eu := 70.0;
fbTime.Advance(tStep := T#100MS);
fbPidAw(itfTime := fbTime, stCmd := stCmdAw, stRetain := stRetAw, stCfg := stCfgAw);
fbPidNoAw(itfTime := fbTime, stCmd := stCmdNoAw, stRetain := stRetNoAw, stCfg := stCfgNoAw);
rOutRevAw := fbPidAw.rOut_pct;
rOutRevNo := fbPidNoAw.rOut_pct;
FOR iStep := 1 TO 99 DO                                                                         // до Tt = 10 с
    fbTime.Advance(tStep := T#100MS);
    fbPidAw(itfTime := fbTime, stCmd := stCmdAw, stRetain := stRetAw, stCfg := stCfgAw);
    fbPidNoAw(itfTime := fbTime, stCmd := stCmdNoAw, stRetain := stRetNoAw, stCfg := stCfgNoAw);
END_FOR
// ref: aw_recovery.out_sat_aw
AssertEquals_REAL(Expected := 100.0, Actual := rOutSatAw, Delta := 1.0E-4, Message := 'saturated at rOutMax_pct');
// ref: aw_recovery.i_sat_aw
AssertEquals_REAL(Expected := 99.782799, Actual := rISatAw, Delta := 1.0E-3,
                  Message := 'I bounded by back-calculation');
// ref: aw_recovery.i_sat_noaw
AssertEquals_REAL(Expected := 169.997986, Actual := rISatNoAw, Delta := 1.0E-3, Message := 'I winds up without it');
// ref: aw_recovery.out_rev_aw
AssertEquals_REAL(Expected := 79.782799, Actual := rOutRevAw, Delta := 1.0E-3, Message := 'leaves limit at once');
// ref: aw_recovery.out_rev_noaw
AssertEquals_REAL(Expected := 100.0, Actual := rOutRevNo, Delta := 1.0E-4, Message := 'wound-up: still at limit');
// ref: aw_recovery.out_tt_aw
AssertEquals_REAL(Expected := 59.982796, Actual := fbPidAw.rOut_pct, Delta := 1.0E-3, Message := 'recovered within Tt');
// ref: aw_recovery.out_tt_noaw
AssertEquals_REAL(Expected := 100.0, Actual := fbPidNoAw.rOut_pct, Delta := 1.0E-4, Message := 'wound-up after Tt');
AssertFalse(Condition := fbPidAw.xSatHigh, Message := 'back-calculation: not saturated after Tt');
coUnit.TEST_FINISHED();
