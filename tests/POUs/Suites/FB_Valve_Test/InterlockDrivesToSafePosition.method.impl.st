coUnit.TEST('Valve_Interlock_DrivesToSafePosition');

fbVlv.xZso := TRUE;
fbVlv.wPermitClose := 16#0000;
// открыта, закрывать нельзя
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xClose := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedPermit,
           Message := 'close without permit rejected');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'still Open');
fbVlv.wInterlock := 16#0018;
fbTime.Advance(tStep := T#100MS);
// блокировка
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closing, Message := 'interlock drives Closed');
AssertTrue(Condition := fbVlv.xQClose, Message := 'close contactor on without permit');
AssertEquals_WORD(Expected := GVL_Const.VLV_STS_INTERLOCKED,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.VLV_STS_INTERLOCKED,
Message := 'INTERLOCKED bit');
AssertEquals_WORD(Expected := 16#0018, Actual := fbVlv.stSts.wInterlock, Message := 'active interlocks');
AssertEquals_UINT(Expected := 3, Actual := fbVlv.stSts.uiFirstOut, Message := 'first out = lowest new bit');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.wPermitMissing, Message := 'no permit needed');
stCmd.xOpen := TRUE;
fbVlv.wInterlock := 16#001A;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.stCommon.eCmdResult = E_CmdResult.RejectedInterlock,
           Message := 'command rejected under interlock');
AssertEquals_UINT(Expected := 3, Actual := fbVlv.stSts.uiFirstOut, Message := 'first out kept');
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZso := FALSE;
    fbVlv.xZsc := iStep >= 10;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'Closed (safe position)');
fbVlv.wInterlock := 16#0000;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'stays Closed after the interlock');
AssertFalse(Condition := fbVlv.xQOpen, Message := 'no automatic return in Manual');
AssertEquals_UINT(Expected := 3, Actual := fbVlv.stSts.uiFirstOut, Message := 'first out held until Reset');
stCmd.stCommon.xReset := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := GVL_Const.NO_FIRST_OUT, Actual := fbVlv.stSts.uiFirstOut,
                  Message := 'first out cleared by Reset');

coUnit.TEST_FINISHED();
