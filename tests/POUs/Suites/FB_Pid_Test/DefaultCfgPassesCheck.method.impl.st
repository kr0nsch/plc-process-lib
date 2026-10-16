coUnit.TEST('Pid_DefaultCfg_PassesCheck');
fbPid.rPv_eu := 50.0;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wCfgErr, Message := 'default Cfg passes CheckConfig');
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR,
                  Message := 'no CFG_ERROR bit');
AssertTrue(Condition := fbPid.Status = E_Ne107Status.Good, Message := 'Good in Manual with default Cfg');
coUnit.TEST_FINISHED();
