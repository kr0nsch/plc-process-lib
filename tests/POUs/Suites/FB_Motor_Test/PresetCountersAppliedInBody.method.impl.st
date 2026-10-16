coUnit.TEST('Motor_PresetCounters_AppliedInBody');

Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbMot.PresetCounters(udiRunTime_s := 360000, udiStarts := 1234), Message := 'request');
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpTime_s, Message := 'not applied by the method');
AssertEquals_UDINT(Expected := 0, Actual := fbMot.RunSeconds, Message := 'property unchanged before body');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_UDINT(Expected := 360000, Actual := stRetain.udiOpTime_s, Message := 'run time applied');
AssertEquals_UDINT(Expected := 1234, Actual := stRetain.udiOpCount, Message := 'starts applied');
AssertEquals_UDINT(Expected := 360000, Actual := fbMot.RunSeconds, Message := 'RunSeconds');
AssertEquals_UDINT(Expected := 1234, Actual := fbMot.Starts, Message := 'Starts');
AssertEquals_REAL(Expected := 100.0, Actual := fbMot.stSts.rRunTime_h, Delta := 1.0E-4, Message := '100 h');
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted, Message := 'accepted');
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpTimeMaint_s, Message := 'maintenance counter unchanged');

coUnit.TEST_FINISHED();
