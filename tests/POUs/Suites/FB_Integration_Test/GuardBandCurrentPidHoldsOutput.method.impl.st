coUnit.TEST('LevelLoop_GuardBandCurrent_PidHoldsOutput');

stAiCfg.rRangeHi_eu := 10.0;
stPidCfg.rPvMax_eu := 10.0;
stPidCfg.rSpMax_eu := 10.0;
stPidRet.eRemoteMode := E_DeviceMode.Auto;
stPidCmd.rSp_eu := 5.0;
stPidCmd.rManualOut_pct := 40.0;
FOR iStep := 1 TO 600 DO
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 3.61, stCmd := stAiCmd, stCfg := stAiCfg);
    fbPid(itfTime := fbTime, rPv_eu := fbAi.rValue_eu, xPvValid := fbAi.xValid, stCmd := stPidCmd,
          stRetain := stPidRet, stCfg := stPidCfg);
    IF iStep = 50 THEN
        rOut5s := fbPid.rOut_pct;
    END_IF
END_FOR
AssertFalse(Condition := fbAi.xValid, Message := 'guard band confirmed: PV invalid');
AssertEquals_WORD(Expected := GVL_Const.PID_FLT_PV_INVALID, Actual := fbPid.stSts.stCommon.wFault,
                  Message := 'PID reports the PV fault');
AssertTrue(Condition := fbPid.rOut_pct < 50.0, Message := 'output held, not driven to 100 pct');
AssertEquals_REAL(Expected := rOut5s, Actual := fbPid.rOut_pct, Delta := 1.0E-4,
                  Message := 'output frozen after the fault');

coUnit.TEST_FINISHED();
