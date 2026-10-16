coUnit.TEST('ControlValve_Local_TracksFeedback');

stCfg.xFbUsed := TRUE;
stCmd.rPosSpMan_pct := 30.0;
fbCv.xPosFbValid := TRUE;
fbCv.rPosFb_pct := 30.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCfg.rRateUp_pctps := 1.0;
stCfg.rRateDown_pctps := 1.0;
fbCv.xLocal := TRUE;
fbCv.rPosFb_pct := 37.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.Local, Message := 'Local');
AssertEquals_REAL(Expected := 37.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'follows feedback without ramp');
AssertEquals_REAL(Expected := 37.0, Actual := stCmd.rPosSpMan_pct, Delta := 0.0, Message := 'manual setpoint tracks');
AssertFalse(Condition := fbCv.xAutoActive, Message := 'not auto');
fbCv.xPosFbValid := FALSE;
fbCv.rPosFb_pct := 80.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 37.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'invalid feedback: hold');
AssertEquals_WORD(Expected := GVL_Const.CV_WRN_FB_INVALID,
                  Actual := fbCv.stSts.stCommon.wWarning AND GVL_Const.CV_WRN_FB_INVALID, Message := 'FB_INVALID');
fbCv.xPosFbValid := TRUE;
fbCv.rPosFb_pct := 42.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 42.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'follows feedback again');
fbCv.xLocal := FALSE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.Manual, Message := 'back to Manual');
AssertEquals_REAL(Expected := 42.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'no bump on return');

coUnit.TEST_FINISHED();
