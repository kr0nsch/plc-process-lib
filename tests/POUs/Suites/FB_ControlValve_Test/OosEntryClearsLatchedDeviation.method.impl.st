coUnit.TEST('ControlValve_OosEntry_ClearsLatchedDeviation');

stCfg.xFbUsed := TRUE;
stCfg.xDevIsFault := TRUE;
stCfg.tDev := T#2S;
stCmd.rPosSpMan_pct := 50.0;
fbCv.xPosFbValid := TRUE;
fbCv.rPosFb_pct := 10.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 3 DO
    fbTime.Advance(tStep := T#1S);
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_WORD(Expected := GVL_Const.CV_FLT_DEVIATION, Actual := fbCv.stSts.stCommon.wFault, Message := 'latched');
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'OOS entry clears the latch');
stCmd.stCommon.xSetManual := TRUE;
fbCv.rPosFb_pct := 50.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.Manual, Message := 'Manual');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'no fault after OOS');

coUnit.TEST_FINISHED();
