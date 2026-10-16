coUnit.TEST('Device_ImplementsIDevice_InterfaceAccess');

aitfDev[0] := fbDev;
aitfDev[1] := fbExt;
FOR uiDev := 0 TO 1 DO
    itfDev := aitfDev[uiDev];
    itfDev.RequestMode(eNewMode := E_DeviceMode.Auto);
END_FOR
fbDev.axCondIn[0] := TRUE;
fbDev(xFaultCause := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbExt(itfTime := fbTime, stCmd := stCmd2, stRetain := stRetain2, stCfg := stCfg);
FOR uiDev := 0 TO 1 DO
    itfDev := aitfDev[uiDev];
    xAllAuto := xAllAuto AND itfDev.Mode = E_DeviceMode.Auto;
END_FOR
AssertTrue(Condition := xAllAuto, Message := 'RequestMode through the interface');
itfDev := aitfDev[0];
AssertTrue(Condition := itfDev.Fault, Message := 'Fault through the interface');
AssertTrue(Condition := itfDev.Status = E_Ne107Status.Failure, Message := 'Status through the interface');
AssertFalse(Condition := itfDev.Available, Message := 'Available through the interface');
AssertEquals_UINT(Expected := 8, Actual := itfDev.AlarmCount, Message := 'AlarmCount through the interface');
itfAlm := itfDev.GetAlarm(uiIndex := 0);
AssertTrue(Condition := itfAlm.Unacked, Message := 'GetAlarm through the interface');
xRet := itfDev.AckAll();
AssertTrue(Condition := xRet, Message := 'AckAll through the interface');
itfDev.Reset();
fbDev(xFaultCause := FALSE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := itfDev.Fault, Message := 'Reset through the interface');
AssertFalse(Condition := itfAlm.Unacked, Message := 'alarm acknowledged');
itfDev := aitfDev[1];
AssertTrue(Condition := itfDev.Available, Message := 'second device available in Auto');

coUnit.TEST_FINISHED();
