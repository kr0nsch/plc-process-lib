coUnit.TEST('Motor_InterlockMaskBitCleared_Ignored');

stCfg.wInterlockMask := 16#FFFE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbMot.wInterlock := 16#0001;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#100MS);
AssertTrue(Condition := fbMot.xQRun, Message := 'masked interlock ignored');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.wInterlock, Message := 'masked bit not reported');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wStatus AND GVL_Const.MOT_STS_INTERLOCKED,
                  Message := 'not interlocked');
AssertEquals_UINT(Expected := GVL_Const.NO_FIRST_OUT, Actual := fbMot.stSts.uiFirstOut, Message := 'no first out');
fbMot.wInterlock := 16#0003;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := fbMot.xQRun, Message := 'unmasked bit stops');
AssertEquals_WORD(Expected := 16#0002, Actual := fbMot.stSts.wInterlock, Message := 'only unmasked bit reported');
AssertEquals_UINT(Expected := 1, Actual := fbMot.stSts.uiFirstOut, Message := 'first out bit 1');

coUnit.TEST_FINISHED();
