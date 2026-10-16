coUnit.TEST('Device_DefaultCfg_PassesCheck');

fbAi(itfTime := fbTime, stCmd := stAiCmd, stCfg := stAiCfg);
fbDi(itfTime := fbTime, stCmd := stDiCmd, stCfg := stDiCfg);
fbMot(itfTime := fbTime, stCmd := stMotCmd, stRetain := stMotRet, stCfg := stMotCfg);
fbVfd(itfTime := fbTime, stCmd := stVfdCmd, stRetain := stVfdRet, stCfg := stVfdCfg);
fbVlv(itfTime := fbTime, stCmd := stVlvCmd, stRetain := stVlvRet, stCfg := stVlvCfg);
fbCv(itfTime := fbTime, stCmd := stCvCmd, stRetain := stCvRet, stCfg := stCvCfg);
fbPid(itfTime := fbTime, stCmd := stPidCmd, stRetain := stPidRet, stCfg := stPidCfg);

AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'AnalogInput: wCfgErr = 0');
AssertEquals_WORD(Expected := 0, Actual := fbDi.stSts.stCommon.wCfgErr, Message := 'DigitalInput: wCfgErr = 0');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wCfgErr, Message := 'Motor: wCfgErr = 0');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wCfgErr, Message := 'MotorVfd: wCfgErr = 0');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wCfgErr, Message := 'Valve: wCfgErr = 0');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wCfgErr, Message := 'ControlValve: wCfgErr = 0');
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wCfgErr, Message := 'Pid: wCfgErr = 0');
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR,
                  Message := 'AnalogInput: Cfg accepted');
AssertEquals_WORD(Expected := 0, Actual := fbDi.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR,
                  Message := 'DigitalInput: Cfg accepted');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR,
                  Message := 'Motor: Cfg accepted');
AssertEquals_WORD(Expected := 0, Actual := fbVfd.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR,
                  Message := 'MotorVfd: Cfg accepted');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR,
                  Message := 'Valve: Cfg accepted');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR,
                  Message := 'ControlValve: Cfg accepted');
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_CFG_ERROR,
                  Message := 'Pid: Cfg accepted');

coUnit.TEST_FINISHED();
