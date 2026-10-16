coUnit.TEST('Valve_InterlockStay_StopsMotorized');

stCfg.eSafePos := E_ValveSafePos.Stay;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
fbVlv.wInterlock := 16#0001;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Intermediate, Message := 'Stay: stopped');
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'outputs off');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_INTERLOCKED,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_INTERLOCKED,
Message := 'INTERLOCKED bit');
AssertEquals_UINT(Expected := 0, Actual := fbVlv.stSts.uiFirstOut, Message := 'first out bit 0');

coUnit.TEST_FINISHED();
