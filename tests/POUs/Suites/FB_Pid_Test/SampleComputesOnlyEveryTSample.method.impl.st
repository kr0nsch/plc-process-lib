coUnit.TEST('Pid_Sample_ComputesOnlyEveryTSample');
// источник: tools/reference/pid.py, сценарий sample
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.tSample := T#100MS;
stCmd.rManualOut_pct := 30.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Manual
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#10MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbTime.Advance(tStep := T#10MS);
stCmd.stCommon.xSetAuto := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // Auto между расчётами
fbPid.rPv_eu := 46.0;                                                                  // e = 4 %
rPrev := fbPid.rOut_pct;
FOR iStep := 1 TO 30 DO                                                                // 300 мс по 10 мс
    fbTime.Advance(tStep := T#10MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    IF fbPid.rOut_pct <> rPrev THEN
        uiChanges := uiChanges + 1;
    END_IF
    rPrev := fbPid.rOut_pct;
END_FOR
// ref: sample.changes
AssertEquals_UINT(Expected := 3, Actual := uiChanges, Message := 'output changes only on 3 samples');
// ref: sample.dt_ms
AssertEquals_REAL(Expected := 100.0, Actual := fbPid.stSts.rDt_ms, Delta := 1.0E-3, Message := 'dt = tSample');
// ref: sample.out_end
AssertEquals_REAL(Expected := 38.16, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'output after 3 samples');
coUnit.TEST_FINISHED();
