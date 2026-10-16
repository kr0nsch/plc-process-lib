coUnit.TEST('Pid_RetainAuto_RestoredOnRestart');
// источник: tools/reference/pid.py, сценарий retain_auto
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stRetain.eRemoteMode := E_DeviceMode.Auto;
stCmd.rManualOut_pct := 42.0;
stCmd.rSp_eu := 50.0;
fbPid.rPv_eu := 46.0;                                                                  // e = 4 %
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // первый вызов
rOutSt := fbPid.rOut_pct;
wStsSt := fbPid.stSts.stCommon.wStatus;
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Auto, Message := 'Auto restored from retain');
AssertTrue(Condition := fbPid.Available, Message := 'available in Auto');
FOR iStep := 1 TO 2 DO
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
// ref: retain_auto.out_start
AssertEquals_REAL(Expected := 42.0, Actual := rOutSt, Delta := 1.0E-4, Message := 'output from rManualOut_pct');
AssertEquals_WORD(Expected := GVL_Const.PID_STS_DT_GAP, Actual := wStsSt AND GVL_Const.PID_STS_DT_GAP,
                  Message := 'first call: initialisation step');
// ref: retain_auto.out_2
AssertEquals_REAL(Expected := 42.08, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'control continues');
coUnit.TEST_FINISHED();
