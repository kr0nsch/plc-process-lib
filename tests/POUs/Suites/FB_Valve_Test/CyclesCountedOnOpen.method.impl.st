coUnit.TEST('Valve_Cycles_CountedOnOpen');

fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZsc := FALSE;
    fbVlv.xZso := iStep >= 10;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'first open: 1');
stCmd.xClose := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZso := FALSE;
    fbVlv.xZsc := iStep >= 10;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'Closed');
AssertEquals_UDINT(Expected := 1, Actual := stRetain.udiOpCount, Message := 'closing does not count');
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZsc := FALSE;
    fbVlv.xZso := iStep >= 10;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_UDINT(Expected := 2, Actual := stRetain.udiOpCount, Message := 'second open: 2');
AssertEquals_UDINT(Expected := 2, Actual := stRetain.udiOpCountMaint, Message := 'maintenance counter 2');
AssertEquals_UDINT(Expected := 2, Actual := fbVlv.stSts.udiCycles, Message := 'Sts udiCycles');
AssertEquals_UDINT(Expected := 2, Actual := fbVlv.stSts.udiCyclesMaint, Message := 'Sts udiCyclesMaint');
stCmd.xClose := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 5 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZso := FALSE;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
stCmd.xStop := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 5 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZso := iStep >= 5;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open again');
AssertEquals_UDINT(Expected := 2, Actual := stRetain.udiOpCount,
                   Message := 'partial stroke back to Open is not a cycle');
stCmd.xResetMaint := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpCountMaint, Message := 'maintenance counter reset');
AssertEquals_UDINT(Expected := 2, Actual := stRetain.udiOpCount, Message := 'total kept');
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'xResetMaint accepted');
AssertFalse(Condition := stCmd.xResetMaint, Message := 'xResetMaint cleared');

coUnit.TEST_FINISHED();
