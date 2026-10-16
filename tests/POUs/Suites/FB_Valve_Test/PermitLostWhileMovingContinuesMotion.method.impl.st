coUnit.TEST('Valve_PermitLostWhileMoving_ContinuesMotion');

fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.wPermitOpen := 16#0000;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.xQOpen, Message := 'running stroke not stopped by a lost permit');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_PERMIT_MISSING,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_PERMIT_MISSING,
                  Message := 'PERMIT_MISSING bit');
AssertEquals_WORD(Expected := 16#FFFF, Actual := fbVlv.stSts.wPermitMissing, Message := 'all open permits missing');
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZso := iStep >= 10;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'reaches Open');

coUnit.TEST_FINISHED();
