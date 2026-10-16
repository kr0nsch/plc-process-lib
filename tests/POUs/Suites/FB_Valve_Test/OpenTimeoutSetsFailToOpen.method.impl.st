coUnit.TEST('Valve_Open_Timeout_SetsFailToOpen');

stCfg.tTravel := T#10S;
fbVlv.xZsc := TRUE;
// t0: закрыта
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
// t0: Opening
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 99 DO                                                 // до t0 + 9,9 с ZSO нет
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'still opening at t0 + 9.9 s');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault before tTravel');
fbTime.Advance(tStep := T#100MS);
// t0 + 10,0 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'Fault at tTravel');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'output off on timeout');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_FAIL_TO_OPEN, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'wFault FailToOpen');
AssertTrue(Condition := fbVlv.Status = E_Ne107Status.Failure, Message := 'NE 107 Failure');
itfAlm := fbVlv.GetAlarm(uiIndex := E_ValveAlarm.FailToOpen);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'FailToOpen alarm ActiveUnack');
fbTime.Advance(tStep := T#100MS);
fbVlv.xZso := TRUE;
// ZSO пришёл позже
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_FAIL_TO_OPEN, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'fault latched');
AssertTrue(Condition := fbVlv.xOpened, Message := 'position still visible in Fault');
stCmd.stCommon.xReset := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'Reset accepted');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'cleared by Reset');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'state from limit switches after Reset');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'no output after Reset');

coUnit.TEST_FINISHED();
