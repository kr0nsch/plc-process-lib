coUnit.TEST('Valve_StopSolenoid_Rejected');

stCfg.eType := E_ValveType.SolenoidEto;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.xQCoil, Message := 'coil energized to open');
stCmd.xStop := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedNotSupported,
           Message := 'stop not supported by a solenoid valve');
AssertTrue(Condition := fbVlv.xQCoil, Message := 'coil unchanged');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'keeps opening');
AssertFalse(Condition := stCmd.xStop, Message := 'xStop cleared');

coUnit.TEST_FINISHED();
