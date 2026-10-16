coUnit.TEST('Valve_BothLimits_SetsFailureOutputsOff');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVlv.xAutoOpen := FALSE;
fbVlv.xZsc := TRUE;
// Auto, закрыта
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Auto, Message := 'Auto from retain');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'Closed');
fbVlv.xZso := TRUE;
// t0: оба концевика
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 4 DO                                                  // t0 + 0,4 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault before tLimitFilter');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'state held during the filter');
fbTime.Advance(tStep := T#100MS);
// t0 + 0,5 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_BOTH_LIMITS, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'BothLimits after tLimitFilter');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'Fault state');
AssertTrue(Condition := fbVlv.Status = E_Ne107Status.Failure, Message := 'NE 107 Failure');
itfAlm := fbVlv.GetAlarm(uiIndex := E_ValveAlarm.BothLimits);
AssertTrue(Condition := itfAlm.Active, Message := 'BothLimits alarm active');
fbVlv.xAutoOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'outputs off while both limit switches');
AssertFalse(Condition := fbVlv.Available, Message := 'not available');
fbVlv.xZso := FALSE;
fbTime.Advance(tStep := T#100MS);
// концевик исправен
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'not latched: clears without Reset');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Auto resumes towards target');
AssertTrue(Condition := fbVlv.xQOpen, Message := 'open contactor on');

coUnit.TEST_FINISHED();
