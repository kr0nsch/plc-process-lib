coUnit.TEST('ControlValve_OutOfService_HoldsOutput');

stCmd.rPosSpMan_pct := 40.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbCv.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService');
AssertEquals_REAL(Expected := 40.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'held');
AssertTrue(Condition := fbCv.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
stCmd.rPosSpMan_pct := 80.0;
fbCv.wInterlock := 16#0001;
fbCv.xPositionerFault := TRUE;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 40.0, Actual := fbCv.rOut_pct, Delta := 0.0,
                  Message := 'held: setpoint, interlock and faults ignored');
AssertEquals_REAL(Expected := 40.0, Actual := stCmd.rPosSpMan_pct, Delta := 0.0, Message := 'manual setpoint tracks');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wFault, Message := 'positioner fault not supervised');

coUnit.TEST_FINISHED();
