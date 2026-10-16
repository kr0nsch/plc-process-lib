coUnit.TEST('Runtime_LocalDeviceInstances_RunInTestMethod');

FOR uiDev := 0 TO 5 DO
    itfDev := afbDev[uiDev];
    itfDev.RequestMode(eNewMode := E_DeviceMode.Auto);
    CallDevice(fbDevice := afbDev[uiDev], stCmdDev := astCmd[uiDev], stRetDev := astRet[uiDev], stCfgDev := stCfg,
               itfTimeSrc := fbTime);
    xAllAuto := xAllAuto AND itfDev.Mode = E_DeviceMode.Auto;
END_FOR
AssertTrue(Condition := xAllAuto, Message := 'six local device instances run');

coUnit.TEST_FINISHED();
