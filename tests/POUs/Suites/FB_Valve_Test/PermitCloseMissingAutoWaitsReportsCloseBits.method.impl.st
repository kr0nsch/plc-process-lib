coUnit.TEST('Valve_PermitCloseMissing_AutoWaitsReportsCloseBits');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVlv.xAutoOpen := TRUE;
fbVlv.xZso := TRUE;
// открыта, Auto
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'Open');
fbVlv.wPermitOpen := 16#FFFE;
fbVlv.wPermitClose := 16#FFFD;
fbVlv.xAutoOpen := FALSE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQClose, Message := 'Auto waits for the close permit');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'stays Open');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_PERMIT_MISSING,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_PERMIT_MISSING,
                  Message := 'PERMIT_MISSING bit');
AssertEquals_WORD(Expected := 16#0002, Actual := fbVlv.stSts.wPermitMissing, Message := 'missing close permit bit 1');
fbVlv.wPermitClose := 16#FFFF;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.xQClose, Message := 'closes when the permit arrives');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.wPermitMissing, Message := 'nothing missing');

coUnit.TEST_FINISHED();
