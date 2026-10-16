coUnit.TEST('Pid_CfgSpLimitsEqual_FixedSetpoint');
stCfg.rSpMin_eu := 40.0;
stCfg.rSpMax_eu := 40.0;
stCmd.rSp_eu := 70.0;
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wCfgErr, Message := 'equal SP limits pass CheckConfig');
AssertEquals_REAL(Expected := 40.0, Actual := fbPid.stSts.rSpTarget_eu, Delta := 0.0, Message := 'target fixed at 40');
AssertEquals_REAL(Expected := 40.0, Actual := fbPid.stSts.rSp_eu, Delta := 0.0, Message := 'SP fixed at 40');
coUnit.TEST_FINISHED();
