coUnit.TEST('Valve_OosEntry_ClearsLatchedFaults');

stCfg.xTorqueUsed := TRUE;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
fbTime.Advance(tStep := T#3S);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);   // ход 3 с: страгивание позади
fbVlv.xTorqueOpen := TRUE;
fbTime.Advance(tStep := T#100MS);
// муфта в ходе
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xTorqueOpen := FALSE;
fbVlv.xExtFault := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xExtFault := FALSE;
fbVlv.xZsc := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_TORQUE_TRIP OR GVL_Const.VLV_FLT_EXT_FAULT,
                  Actual := fbVlv.stSts.stCommon.wFault, Message := 'latched');
stCmd.stCommon.xSetOos := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.OutOfService, Message := 'OutOfService accepted in Fault');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'OOS entry clears latched faults');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'state from limit switches');
itfAlm := fbVlv.GetAlarm(uiIndex := E_ValveAlarm.ExtFault);
AssertTrue(Condition := itfAlm.State = E_AlarmState.OutOfService, Message := 'alarm OutOfService');
fbVlv.xExtFault := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'external fault not supervised in OOS');
fbVlv.xExtFault := FALSE;
stCmd.stCommon.xSetManual := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Mode = E_DeviceMode.Manual, Message := 'Manual');
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wFault, Message := 'no fault after OOS');

coUnit.TEST_FINISHED();
