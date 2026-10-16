coUnit.TEST('Device_AllTypes_AlarmCountThroughIDevice');

fbAi(itfTime := fbTime, stCmd := stAiCmd, stCfg := stAiCfg);
fbDi(itfTime := fbTime, stCmd := stDiCmd, stCfg := stDiCfg);
fbMot(itfTime := fbTime, stCmd := stMotCmd, stRetain := stMotRet, stCfg := stMotCfg);
fbVfd(itfTime := fbTime, stCmd := stVfdCmd, stRetain := stVfdRet, stCfg := stVfdCfg);
fbVlv(itfTime := fbTime, stCmd := stVlvCmd, stRetain := stVlvRet, stCfg := stVlvCfg);
fbCv(itfTime := fbTime, stCmd := stCvCmd, stRetain := stCvRet, stCfg := stCvCfg);
fbPid(itfTime := fbTime, stCmd := stPidCmd, stRetain := stPidRet, stCfg := stPidCfg);
aitfDev[1] := fbAi;
aitfDev[2] := fbDi;
aitfDev[3] := fbMot;
aitfDev[4] := fbVfd;
aitfDev[5] := fbVlv;
aitfDev[6] := fbCv;
aitfDev[7] := fbPid;
auiSlots[1] := GVL_Const.AI_ALARM_COUNT;
auiSlots[2] := GVL_Const.DI_ALARM_COUNT;
auiSlots[3] := GVL_Const.MOT_ALARM_COUNT;
auiSlots[4] := GVL_Const.MOT_ALARM_COUNT;
auiSlots[5] := GVL_Const.VLV_ALARM_COUNT;
auiSlots[6] := GVL_Const.CV_ALARM_COUNT;
auiSlots[7] := GVL_Const.PID_ALARM_COUNT;
FOR uiDev := 1 TO 7 DO
    xCountOk := xCountOk AND (aitfDev[uiDev].AlarmCount = auiSlots[uiDev]);
    itfAlm := aitfDev[uiDev].GetAlarm(uiIndex := 0);
    xSlotOk := xSlotOk AND (itfAlm <> 0);
    xModeOk := xModeOk AND (aitfDev[uiDev].Mode = E_DeviceMode.Auto OR aitfDev[uiDev].Mode = E_DeviceMode.Manual
                            OR aitfDev[uiDev].Mode = E_DeviceMode.Local
                            OR aitfDev[uiDev].Mode = E_DeviceMode.OutOfService);
END_FOR
AssertTrue(Condition := xCountOk, Message := 'AlarmCount = <DEV>_ALARM_COUNT for every type');
AssertTrue(Condition := xSlotOk, Message := 'slot 0 reachable through GetAlarm');
AssertTrue(Condition := xModeOk, Message := 'mode from the enumeration');
AssertEquals_UINT(Expected := GVL_Const.MOT_ALARM_COUNT, Actual := fbVfd.AlarmCount,
                  Message := 'MotorVfd: eight slots like Motor');

coUnit.TEST_FINISHED();
