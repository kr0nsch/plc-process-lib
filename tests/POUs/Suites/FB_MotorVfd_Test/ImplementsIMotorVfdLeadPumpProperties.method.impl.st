coUnit.TEST('MotorVfd_ImplementsIMotorVfd_LeadPumpProperties');

itfLead := fbVfd;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.stCommon.xSetAuto := TRUE;
fbVfd.rSpeedSpAuto_pct := 60.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Stopped, Message := 'precondition: stopped in Auto');
AssertFalse(Condition := itfLead.SpeedAutoActive, Message := 'not active: stopped in Auto');
fbVfd.xAutoRun := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Starting, Message := 'precondition: starting');
AssertFalse(Condition := itfLead.SpeedAutoActive, Message := 'not active while starting');
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 58.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertEquals_REAL(Expected := 60.0, Actual := itfLead.SpeedRef, Delta := 1.0E-4, Message := 'SpeedRef');
AssertEquals_REAL(Expected := 58.0, Actual := itfLead.SpeedAct, Delta := 1.0E-4, Message := 'SpeedAct');
AssertTrue(Condition := itfLead.SpeedAutoActive, Message := 'SpeedAutoActive in Auto');
AssertTrue(Condition := itfLead.Running, Message := 'Running via I_Motor');
AssertTrue(Condition := itfLead.Mode = E_DeviceMode.Auto, Message := 'Mode via I_Device');
fbVfd.xAutoRun := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Stopping,
           Message := 'precondition: stopping, feedback present');
AssertFalse(Condition := itfLead.SpeedAutoActive, Message := 'not active while stopping');
fbVfd.xVfdRunning := FALSE;
fbVfd.rSpeedAct_pct := 0.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xAutoRun := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 60.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertTrue(Condition := itfLead.SpeedAutoActive, Message := 'active again when running');
fbVfd.xCommOk := FALSE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 31, tDt := T#100MS);
AssertEquals_WORD(Expected := GVL_Const.MOT_FLT_COMM_LOSS, Actual := fbVfd.stSts.stCommon.wFault,
                  Message := 'precondition: comm fault');
AssertFalse(Condition := itfLead.SpeedAutoActive, Message := 'not active with a comm fault');
fbVfd.xCommOk := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
stCmd.stCommon.xSetManual := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#100MS);
AssertFalse(Condition := itfLead.SpeedAutoActive, Message := 'not active in Manual');

coUnit.TEST_FINISHED();
