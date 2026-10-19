coUnit.TEST('Device_OutOfServiceRetained_StartsInOos');

stRetain.xOutOfService := TRUE;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbDev.axCondIn[0] := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.OutOfService, Message := 'starts in OutOfService');
AssertTrue(Condition := fbDev.xHookInFirst, Message := 'hook called in the first call');
AssertTrue(Condition := fbDev.eHookNew = E_DeviceMode.OutOfService, Message := 'hook eNew = OutOfService');
AssertTrue(Condition := fbDev.Status = E_Ne107Status.CheckFunction, Message := 'NE 107 CheckFunction');
itfAlm := fbDev.GetAlarm(uiIndex := 0);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'alarm slot OutOfService');
itfAlm := fbDev.GetAlarm(uiIndex := 7);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'last slot OutOfService');
AssertEquals_WORD(Expected := 0, Actual := fbDev.stSts.stCommon.wAlmShelved,
                  Message := 'out of service is not shelved');
itfAlm := fbDev.GetAlarm(uiIndex := 0);
stCmd.stCommon.xSetAuto := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbDev.Mode = E_DeviceMode.Auto, Message := 'xSetAuto leaves OutOfService');
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'active alarm reannunciated');

coUnit.TEST_FINISHED();
