coUnit.TEST('ControlValve_InterlockFirstOut_KeptUntilResetOrOos');

stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 60.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbCv.wInterlock := 16#0004;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 2, Actual := fbCv.stSts.uiFirstOut, Message := 'first out bit 2');
fbCv.wInterlock := 16#0005;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 2, Actual := fbCv.stSts.uiFirstOut, Message := 'first out kept when bit 0 joins');
stCmd.stCommon.xReset := TRUE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := GVL_Const.NO_FIRST_OUT, Actual := fbCv.stSts.uiFirstOut, Message := 'cleared by Reset');
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := GVL_Const.NO_FIRST_OUT, Actual := fbCv.stSts.uiFirstOut,
                  Message := 'no new first out while the word stays non-zero');
fbCv.wInterlock := 16#0000;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbCv.wInterlock := 16#0002;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := 1, Actual := fbCv.stSts.uiFirstOut, Message := 'new first out after the word was 0');
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UINT(Expected := GVL_Const.NO_FIRST_OUT, Actual := fbCv.stSts.uiFirstOut,
                  Message := 'cleared by OOS entry');

coUnit.TEST_FINISHED();
