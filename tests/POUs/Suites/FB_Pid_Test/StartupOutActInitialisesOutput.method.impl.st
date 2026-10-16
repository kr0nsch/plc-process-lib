coUnit.TEST('Pid_Startup_OutActInitialisesOutput');
// источник: tools/reference/pid.py, сценарий start_outact
uBits.dwValue := 16#7FC00000;                                                          // тихий NaN
stCfg.rKp := 2.0;
stCfg.rTi_s := 10.0;
stCfg.xUseOutAct := TRUE;
stRetain.eRemoteMode := E_DeviceMode.Auto;
stRetNaN := stRetain;
stCmd.rSp_eu := 50.0;
stCmdNaN := stCmd;
stCmdNaN.rManualOut_pct := 42.0;
fbPid.rPv_eu := 46.0;                                                                  // e = 4 %, P = 8 %
fbPid.xPvValid := TRUE;
fbPid.rOutAct_pct := 37.0;                                                             // механизм на 37 %
fbPidNaN.rPv_eu := 46.0;
fbPidNaN.xPvValid := TRUE;
fbPidNaN.rOutAct_pct := uBits.rValue;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // первый вызов
fbPidNaN(itfTime := fbTime, stCmd := stCmdNaN, stRetain := stRetNaN, stCfg := stCfg);
rOutSt := fbPid.rOut_pct;
rISt := fbPid.stSts.rI_pct;
rCmdOutSt := stCmd.rManualOut_pct;
FOR iStep := 1 TO 2 DO                                                                 // механизм отрабатывает выход
    fbPid.rOutAct_pct := fbPid.rOut_pct;
    fbTime.Advance(tStep := T#100MS);
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbPid.Mode = E_DeviceMode.Auto, Message := 'Auto restored from retain');
// ref: start_outact.out_start
AssertEquals_REAL(Expected := 37.0, Actual := rOutSt, Delta := 1.0E-4, Message := 'output from rOutAct_pct, not 0');
// ref: start_outact.i_start
AssertEquals_REAL(Expected := 29.0, Actual := rISt, Delta := 1.0E-4, Message := 'I = u - P at startup');
AssertEquals_REAL(Expected := 37.0, Actual := rCmdOutSt, Delta := 0.0,
                  Message := 'rManualOut_pct tracks startup output');
// ref: start_outact.out_2
AssertEquals_REAL(Expected := 37.08, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'control continues from 37');
// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := fbPidNaN.rOut_pct), Message := 'NaN source: output stays finite');
// ref: start_outact.out_start_nan
AssertEquals_REAL(Expected := 42.0, Actual := fbPidNaN.rOut_pct, Delta := 1.0E-4,
                  Message := 'non-finite rOutAct_pct: output from rManualOut_pct');
coUnit.TEST_FINISHED();
