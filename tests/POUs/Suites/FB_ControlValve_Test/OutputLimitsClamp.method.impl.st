coUnit.TEST('ControlValve_OutputLimits_Clamp');

wLimBits := GVL_Const.CV_STS_LIMITED_MIN OR GVL_Const.CV_STS_LIMITED_MAX;
stCfg.rOutMin_pct := 10.0;
stCfg.rOutMax_pct := 90.0;
stCmd.rPosSpMan_pct := 95.0;
// без рампы — сразу
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 90.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'clamped to 90 %');
AssertEquals_REAL(Expected := 90.0, Actual := fbCv.stSts.rPosSp_pct, Delta := 0.0, Message := 'setpoint after limits');
AssertEquals_WORD(Expected := GVL_Const.CV_STS_LIMITED_MAX,
                  Actual := fbCv.stSts.stCommon.wStatus AND wLimBits,
                  Message := 'LIMITED_MAX');
stCmd.rPosSpMan_pct := 5.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 10.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'clamped to 10 %');
AssertEquals_WORD(Expected := GVL_Const.CV_STS_LIMITED_MIN,
                  Actual := fbCv.stSts.stCommon.wStatus AND wLimBits,
                  Message := 'LIMITED_MIN');
stCmd.stCommon.xSetAuto := TRUE;
fbCv.rPosSpAuto_pct := 120.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.Auto, Message := 'Auto');
AssertEquals_REAL(Expected := 90.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'Auto setpoint clamped');
AssertTrue(Condition := fbCv.xAutoActive, Message := 'xAutoActive in Auto');
fbCv.rPosSpAuto_pct := 55.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 55.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'within limits');
AssertEquals_WORD(Expected := 0,
                  Actual := fbCv.stSts.stCommon.wStatus AND wLimBits,
                  Message := 'no limit bits');

coUnit.TEST_FINISHED();
