coUnit.TEST('Device_DevType_ReportedInStsCommon');

AssertTrue(Condition := fbAi.stSts.stCommon.eDevType = E_DeviceType.None AND
                        fbDi.stSts.stCommon.eDevType = E_DeviceType.None AND
                        fbMot.stSts.stCommon.eDevType = E_DeviceType.None AND
                        fbVfd.stSts.stCommon.eDevType = E_DeviceType.None AND
                        fbVlv.stSts.stCommon.eDevType = E_DeviceType.None AND
                        fbCv.stSts.stCommon.eDevType = E_DeviceType.None AND
                        fbPid.stSts.stCommon.eDevType = E_DeviceType.None,
           Message := 'None before the first call');
fbAi(itfTime := fbTime, stCmd := stAiCmd, stCfg := stAiCfg);
fbDi(itfTime := fbTime, stCmd := stDiCmd, stCfg := stDiCfg);
fbMot(itfTime := fbTime, stCmd := stMotCmd, stRetain := stMotRet, stCfg := stMotCfg);
fbVfd(itfTime := fbTime, stCmd := stVfdCmd, stRetain := stVfdRet, stCfg := stVfdCfg);
fbVlv(itfTime := fbTime, stCmd := stVlvCmd, stRetain := stVlvRet, stCfg := stVlvCfg);
fbCv(itfTime := fbTime, stCmd := stCvCmd, stRetain := stCvRet, stCfg := stCvCfg);
fbPid(itfTime := fbTime, stCmd := stPidCmd, stRetain := stPidRet, stCfg := stPidCfg);
AssertTrue(Condition := fbAi.stSts.stCommon.eDevType = E_DeviceType.AnalogInput, Message := 'AnalogInput');
AssertTrue(Condition := fbDi.stSts.stCommon.eDevType = E_DeviceType.DigitalInput, Message := 'DigitalInput');
AssertTrue(Condition := fbMot.stSts.stCommon.eDevType = E_DeviceType.Motor, Message := 'Motor');
AssertTrue(Condition := fbVfd.stSts.stCommon.eDevType = E_DeviceType.MotorVfd, Message := 'MotorVfd, not Motor');
AssertTrue(Condition := fbVlv.stSts.stCommon.eDevType = E_DeviceType.Valve, Message := 'Valve');
AssertTrue(Condition := fbCv.stSts.stCommon.eDevType = E_DeviceType.ControlValve, Message := 'ControlValve');
AssertTrue(Condition := fbPid.stSts.stCommon.eDevType = E_DeviceType.Pid, Message := 'Pid');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, stCmd := stAiCmd, stCfg := stAiCfg);
fbDi(itfTime := fbTime, stCmd := stDiCmd, stCfg := stDiCfg);
fbMot(itfTime := fbTime, stCmd := stMotCmd, stRetain := stMotRet, stCfg := stMotCfg);
fbVfd(itfTime := fbTime, stCmd := stVfdCmd, stRetain := stVfdRet, stCfg := stVfdCfg);
fbVlv(itfTime := fbTime, stCmd := stVlvCmd, stRetain := stVlvRet, stCfg := stVlvCfg);
fbCv(itfTime := fbTime, stCmd := stCvCmd, stRetain := stCvRet, stCfg := stCvCfg);
fbPid(itfTime := fbTime, stCmd := stPidCmd, stRetain := stPidRet, stCfg := stPidCfg);
AssertTrue(Condition := fbMot.stSts.stCommon.eDevType = E_DeviceType.Motor, Message := 'Motor kept');
AssertTrue(Condition := fbVfd.stSts.stCommon.eDevType = E_DeviceType.MotorVfd, Message := 'MotorVfd kept');

coUnit.TEST_FINISHED();
