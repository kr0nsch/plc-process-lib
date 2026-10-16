coUnit.TEST('Valve_Local_OutputsOffTracksLimits');

fbVlv.xZsc := TRUE;
// Manual, закрыта
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xLocal := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Local, Message := 'Local');
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedMode, Message := 'RejectedMode in Local');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'no output in Local');
fbVlv.xZsc := FALSE;
fbTime.Advance(tStep := T#100MS);
// двигают руками
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Intermediate, Message := 'Intermediate between limits');
fbVlv.xZso := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open on ZSO');
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'local cycle counted');
fbVlv.wInterlock := 16#0001;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_WRN_INTERLOCK_IN_LOCAL,
                  Actual := fbVlv.stSts.stCommon.wWarning AND GVL_Const.VLV_WRN_INTERLOCK_IN_LOCAL,
                  Message := 'interlock in Local: warning');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_INTERLOCKED,
                  Message := 'interlock not acting in Local');
AssertFalse(Condition := fbVlv.xQClose, Message := 'PLC does not move the valve in Local');
fbVlv.xZsc := TRUE;
FOR iStep := 1 TO 10 DO                                                 // оба концевика 1 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'both limits not supervised in Local');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Unknown, Message := 'Unknown on both limits');
fbVlv.xZsc := FALSE;
fbVlv.wInterlock := 16#0000;
fbVlv.xLocal := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Manual, Message := 'back to remembered Manual');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open');
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'no movement on return');

coUnit.TEST_FINISHED();
