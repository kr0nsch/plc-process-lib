coUnit.TEST('Valve_InterlockWithExtFault_OutputsStayOff');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVlv.xAutoOpen := TRUE;
fbVlv.xZso := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Open по ZSO
fbVlv.xExtFault := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_EXT_FAULT, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'precondition: ExtFault');
fbVlv.wInterlock := 16#0001;
FOR iStep := 1 TO 20 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xAnyOut := xAnyOut OR fbVlv.xQOpen OR fbVlv.xQClose;
END_FOR
AssertFalse(Condition := xAnyOut, Message := 'faulty actuator: outputs stay off');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'state Fault');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_INTERLOCKED,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_INTERLOCKED,
Message := 'INTERLOCKED bit');

coUnit.TEST_FINISHED();
