coUnit.TEST('MotorVfd_ImplementsIMotorVfd_LeadPumpProperties');

SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.xAutoRun := TRUE;
fbVfd.rSpeedSpAuto_pct := 60.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 58.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
itfLead := fbVfd;
AssertEquals_REAL(Expected := 60.0, Actual := itfLead.SpeedRef, Delta := 1.0E-4, Message := 'SpeedRef');
AssertEquals_REAL(Expected := 58.0, Actual := itfLead.SpeedAct, Delta := 1.0E-4, Message := 'SpeedAct');
AssertTrue(Condition := itfLead.SpeedAutoActive, Message := 'SpeedAutoActive in Auto');
AssertTrue(Condition := itfLead.Running, Message := 'Running via I_Motor');
AssertTrue(Condition := itfLead.Mode = E_DeviceMode.Auto, Message := 'Mode via I_Device');
stCmd.stCommon.xSetManual := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := itfLead.SpeedAutoActive, Message := 'not active in Manual');

coUnit.TEST_FINISHED();
