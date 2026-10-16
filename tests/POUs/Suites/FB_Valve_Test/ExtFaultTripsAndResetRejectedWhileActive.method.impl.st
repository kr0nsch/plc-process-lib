coUnit.TEST('Valve_ExtFault_TripsAndResetRejectedWhileActive');

stCfg.udiAlarmIdBase := 120;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xExtFault := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'Fault on external fault');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'output off');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_EXT_FAULT, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'wFault ExtFault');
itfAlm := fbVlv.GetAlarm(uiIndex := E_ValveAlarm.ExtFault);
AssertEquals_UDINT(Expected := 125, Actual := itfAlm.Id, Message := 'alarm id = base + slot');
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'ExtFault alarm');
uiSeq := fbVlv.stSts.stCommon.uiCmdSeq;
stCmd.stCommon.xReset := TRUE;
// t1: Reset, причина действует
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'Reset accepted');
AssertEquals_UINT(Expected := uiSeq + 1, Actual := fbVlv.stSts.stCommon.uiCmdSeq, Message := 'one result so far');
FOR iStep := 1 TO 29 DO                                                 // t1 + 2,9 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_UINT(Expected := uiSeq + 1, Actual := fbVlv.stSts.stCommon.uiCmdSeq,
                  Message := 'no second result before the window ends');
fbTime.Advance(tStep := T#100MS);
// t1 + 3,0 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedFault,
           Message := 'RejectedFault at the window end');
AssertEquals_UINT(Expected := uiSeq + 2, Actual := fbVlv.stSts.stCommon.uiCmdSeq, Message := 'second result');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_EXT_FAULT, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'still faulted');
fbVlv.xExtFault := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_EXT_FAULT, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'latched after the cause is gone');
stCmd.stCommon.xReset := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'cleared by Reset');
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'Reset accepted');
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := itfAlm.State = E_AlarmState.Normal, Message := 'alarm Normal after Reset');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Intermediate, Message := 'Intermediate');

coUnit.TEST_FINISHED();
