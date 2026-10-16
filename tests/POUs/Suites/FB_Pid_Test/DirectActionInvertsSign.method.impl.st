coUnit.TEST('Pid_DirectAction_InvertsSign');
// источник: tools/reference/pid.py, сценарий direct
stCfgRev.rKp := 2.0;
stCfgRev.rTi_s := 0.0;
stCfgDir := stCfgRev;
stCfgDir.eAction := E_PidAction.Direct;
stCmdRev.rManualOut_pct := 50.0;
stCmdRev.rSp_eu := 50.0;
stCmdDir := stCmdRev;
fbPidRev.rPv_eu := 50.0;
fbPidRev.xPvValid := TRUE;
fbPidDir.rPv_eu := 50.0;
fbPidDir.xPvValid := TRUE;
fbPidRev(itfTime := fbTime, stCmd := stCmdRev, stRetain := stRetRev, stCfg := stCfgRev);  // t0: Manual
fbPidDir(itfTime := fbTime, stCmd := stCmdDir, stRetain := stRetDir, stCfg := stCfgDir);
fbTime.Advance(tStep := T#100MS);
stCmdRev.stCommon.xSetAuto := TRUE;
stCmdDir.stCommon.xSetAuto := TRUE;
fbPidRev(itfTime := fbTime, stCmd := stCmdRev, stRetain := stRetRev, stCfg := stCfgRev);  // Auto
fbPidDir(itfTime := fbTime, stCmd := stCmdDir, stRetain := stRetDir, stCfg := stCfgDir);
fbPidRev.rPv_eu := 60.0;                                                                     // PV выше на 10 %
fbPidDir.rPv_eu := 60.0;
fbTime.Advance(tStep := T#100MS);
fbPidRev(itfTime := fbTime, stCmd := stCmdRev, stRetain := stRetRev, stCfg := stCfgRev);
fbPidDir(itfTime := fbTime, stCmd := stCmdDir, stRetain := stRetDir, stCfg := stCfgDir);
// ref: direct.out_reverse
AssertEquals_REAL(Expected := 30.0, Actual := fbPidRev.rOut_pct, Delta := 1.0E-4, Message := 'reverse: 50 - 20');
// ref: direct.err_reverse
AssertEquals_REAL(Expected := -10.0, Actual := fbPidRev.stSts.rErr_pct, Delta := 1.0E-4,
                  Message := 'reverse: e = SP - PV');
// ref: direct.out_direct
AssertEquals_REAL(Expected := 70.0, Actual := fbPidDir.rOut_pct, Delta := 1.0E-4, Message := 'direct: 50 + 20');
// ref: direct.err_direct
AssertEquals_REAL(Expected := 10.0, Actual := fbPidDir.stSts.rErr_pct, Delta := 1.0E-4,
                  Message := 'direct: e = PV - SP');
coUnit.TEST_FINISHED();
