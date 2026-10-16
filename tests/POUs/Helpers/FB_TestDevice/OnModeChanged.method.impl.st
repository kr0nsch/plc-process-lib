SUPER^.OnModeChanged(eOld := eOld, eNew := eNew);
uiHookCalls := uiHookCalls + 1;
eHookOld := eOld;
eHookNew := eNew;
xHookInFirst := xHookInFirst OR xFirstCall;
udiHookTrace := udiHookTrace * 10 + 1;
IF eOld = E_DeviceMode.Auto AND eNew = E_DeviceMode.Manual THEN
    xManualRun := xOutput;
END_IF
IF eNew = E_DeviceMode.OutOfService THEN
    xFaultLatched := FALSE;
END_IF
