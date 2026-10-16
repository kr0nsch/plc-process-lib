coUnit.TEST('Valve_StopMotorized_GoesIntermediate');

fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 20 DO                                                 // открывается 2 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
stCmd.xStop := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Intermediate, Message := 'Intermediate after stop');
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'outputs off');
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'stop accepted');
AssertFalse(Condition := stCmd.xStop, Message := 'xStop cleared');
FOR iStep := 1 TO 20 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xEverOn := xEverOn OR fbVlv.xQOpen OR fbVlv.xQClose;
END_FOR
AssertFalse(Condition := xEverOn, Message := 'stays stopped');
AssertFalse(Condition := fbVlv.xOpened OR fbVlv.xClosed, Message := 'neither open nor closed');

coUnit.TEST_FINISHED();
