coUnit.TEST('Valve_OosRequestWhileMoving_Rejected');

fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedState,
           Message := 'OOS while moving rejected');
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Manual, Message := 'still Manual');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'keeps opening');
stCmd.xStop := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'OOS when stopped accepted');
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService');
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'outputs off');
AssertTrue(Condition := fbVlv.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
stCmd.xOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedMode, Message := 'RejectedMode in OOS');

coUnit.TEST_FINISHED();
