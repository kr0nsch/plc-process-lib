coUnit.TEST('Valve_PowerLoss_StopsWithoutFault');

stCfg.tTravel := T#10S;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.xPowerOk := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Intermediate, Message := 'Intermediate on power loss');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'output off');
AssertEquals_WORD(Expected := GVL_Const.VLV_WRN_POWER_LOST,
                  Actual := fbVlv.stSts.stCommon.wWarning AND GVL_Const.VLV_WRN_POWER_LOST, Message := 'POWER_LOST');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault');
AssertFalse(Condition := fbVlv.Fault, Message := 'not Fault');
stCmd.xOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedInhibit,
           Message := 'command without power: RejectedInhibit');
FOR iStep := 1 TO 120 DO                                                // 12 с без напряжения
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'travel supervision suspended');
fbVlv.xPowerOk := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Intermediate, Message := 'Manual stays: target cleared');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'no output in Manual');
stCmd.stCommon.xSetAuto := TRUE;
fbVlv.xAutoOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.xQOpen, Message := 'Auto drives to target');
AssertTrue(Condition := fbVlv.Available, Message := 'available in Auto with power');
fbVlv.xPowerOk := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQOpen, Message := 'off again without power');
AssertFalse(Condition := fbVlv.Available, Message := 'not available without power');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_AVAILABLE,
                  Message := 'AVAILABLE bit off without power');
fbVlv.xPowerOk := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.xQOpen, Message := 'Auto resumes after power returns');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Opening');

coUnit.TEST_FINISHED();
