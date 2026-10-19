coUnit.TEST('MotorVfd_PlcRestart_RefBumpless');

stCfg.stVfd.rSpeedMin_pct := 30.0;
stCfg.stVfd.rRampUp_pctps := 10.0;
stCfg.stVfd.rRampDown_pctps := 10.0;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbVfd.xAutoRun := TRUE;
fbVfd.xVfdRunning := TRUE;
fbVfd.rSpeedAct_pct := 70.0;
fbVfd.rSpeedSpAuto_pct := 70.0;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Running AND fbVfd.xQRun, Message := 'precondition: adopted');
AssertEquals_REAL(Expected := 70.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4,
                  Message := 'reference preset from the actual speed');
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertEquals_REAL(Expected := 70.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4, Message := 'no dip afterwards');
fbVfd2.xVfdRunning := TRUE;
fbVfd2.rSpeedAct_pct := 55.0;
SpinVfd(fbV := fbVfd2, fbT := fbTime2, stC := stCmd2, stR := stRet2, stF := stCfg, uiN := 1, tDt := T#0S);
AssertTrue(Condition := fbVfd2.stSts.eState = E_MotorState.Running, Message := 'precondition: Manual adopted');
AssertEquals_REAL(Expected := 55.0, Actual := fbVfd2.rSpeedRef_pct, Delta := 1.0E-4,
                  Message := 'Manual: reference from the actual speed');
AssertEquals_REAL(Expected := 55.0, Actual := stCmd2.rSpeedSp_pct, Delta := 1.0E-4,
                  Message := 'Manual: operator setpoint := actual speed');
SpinVfd(fbV := fbVfd2, fbT := fbTime2, stC := stCmd2, stR := stRet2, stF := stCfg, uiN := 10, tDt := T#100MS);
AssertEquals_REAL(Expected := 55.0, Actual := fbVfd2.rSpeedRef_pct, Delta := 1.0E-4,
                  Message := 'Manual: held, not ramped to min');

coUnit.TEST_FINISHED();
