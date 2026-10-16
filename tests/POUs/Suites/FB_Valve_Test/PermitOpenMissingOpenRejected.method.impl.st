coUnit.TEST('Valve_PermitOpenMissing_OpenRejected');

fbVlv.xZsc := TRUE;
fbVlv.wPermitOpen := 16#FFFE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedPermit, Message := 'RejectedPermit');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'stays Closed');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'no output');
stCfg.wPermitOpenMask := 16#FFFE;                                       // бит 0 не требуется
stCmd.xOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'masked bit ignored');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Opening, Message := 'Opening');
stCmd.xStop := TRUE;
fbTime.Advance(tStep := T#100MS);
// стоп: ZSC ещё на месте — Closed
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCfg.wPermitOpenMask := 16#FFFF;
stCmd.stCommon.xSetAuto := TRUE;
fbVlv.xAutoOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Auto, Message := 'Auto');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'Auto waits for the permit');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_PERMIT_MISSING,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_PERMIT_MISSING,
                  Message := 'PERMIT_MISSING bit');
AssertEquals_WORD(Expected := 16#0001, Actual := fbVlv.stSts.wPermitMissing, Message := 'missing permit bit 0');
fbVlv.wPermitOpen := 16#FFFF;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.xQOpen, Message := 'starts when the permit arrives');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.wPermitMissing, Message := 'nothing missing');

coUnit.TEST_FINISHED();
