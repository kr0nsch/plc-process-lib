coUnit.TEST('MotorVfd_ImplementsIMotor_PolymorphicArray');

fbMot(itfTime := fbTime2, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg);
stCmd2.xStart := TRUE;
fbMot.xFbRun := TRUE;
fbTime2.Advance(tStep := T#1S);
fbMot(itfTime := fbTime2, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg);
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbVfd.xVfdRunning := TRUE;
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1S);
FOR uiIdx := 1 TO 5 DO
    fbTime2.Advance(tStep := T#1S);
    fbMot(itfTime := fbTime2, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg);
END_FOR
SpinVfd(fbV := fbVfd, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 5, tDt := T#1S);
aitfMot[1] := fbMot;
aitfMot[2] := fbVfd;
FOR uiIdx := 1 TO 2 DO
    itfMot := aitfMot[uiIdx];
    IF itfMot.Running THEN
        uiRunningCount := uiRunningCount + 1;
    END_IF
    udiStartsSum := udiStartsSum + itfMot.Starts;
    udiRunSum := udiRunSum + itfMot.RunSeconds;
END_FOR
AssertEquals_UINT(Expected := 2, Actual := uiRunningCount, Message := 'both running via I_Motor');
AssertEquals_UDINT(Expected := 2, Actual := udiStartsSum, Message := 'one start each');
AssertEquals_UDINT(Expected := 10, Actual := udiRunSum, Message := '5 s each');
AssertTrue(Condition := fbMot.stSts.stCommon.eDevType = E_DeviceType.Motor, Message := 'plain motor type');
AssertTrue(Condition := fbVfd.stSts.stCommon.eDevType = E_DeviceType.MotorVfd, Message := 'VFD type');
itfDev := aitfMot[2];
AssertTrue(Condition := itfDev.Reset(), Message := 'Reset via I_Device');

coUnit.TEST_FINISHED();
