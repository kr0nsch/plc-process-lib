coUnit.TEST('Valve_CfgChecks_SetBits');

uBad.iValue := 7;
stCfg.eType := uBad.eType;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_TYPE, Actual := fbVlv.stSts.stCommon.wCfgErr, Message := 'type');
stCfg.eType := E_ValveType.Motorized;
stCfg.tTravel := T#0S;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_TRAVEL, Actual := fbVlv.stSts.stCommon.wCfgErr, Message := 'travel');
stCfg.tTravel := T#60S;
stCfg.eType := E_ValveType.SolenoidEtc;
stCfg.eSafePos := E_ValveSafePos.Stay;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_SAFE_POS, Actual := fbVlv.stSts.stCommon.wCfgErr,
                  Message := 'Stay for a solenoid');
stCfg.eType := E_ValveType.Motorized;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wCfgErr, Message := 'Stay for Motorized is valid');
uBad.iValue := 5;
stCfg.eSafePos := uBad.eSafePos;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_SAFE_POS, Actual := fbVlv.stSts.stCommon.wCfgErr,
                  Message := 'safe position out of enum');
stCfg.eSafePos := E_ValveSafePos.Closed;
stCfg.xCloseOnTorque := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_TORQUE, Actual := fbVlv.stSts.stCommon.wCfgErr,
                  Message := 'close on torque without torque switch');
stCfg.xCloseOnTorque := FALSE;
stCfg.xTorqueUsed := TRUE;
stCfg.eType := E_ValveType.SolenoidEto;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_TORQUE, Actual := fbVlv.stSts.stCommon.wCfgErr,
                  Message := 'torque switch for a solenoid');
stCfg.xTorqueUsed := FALSE;
stCfg.tReverse := T#0S;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbVlv.stSts.stCommon.wCfgErr, Message := 'no reverse pause for a solenoid');
stCfg.eType := E_ValveType.Motorized;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_REVERSE, Actual := fbVlv.stSts.stCommon.wCfgErr,
                  Message := 'reverse pause 0 for Motorized');
stCfg.tReverse := T#1S;
stCfg.tResetWindow := T#0S;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_RESET, Actual := fbVlv.stSts.stCommon.wCfgErr,
                  Message := 'reset window');
stCfg.tResetWindow := T#3S;
uBad.iValue := 9;
stSlot := stCfg.astAlarm[3];
stSlot.ePriority := uBad.ePriority;
stCfg.astAlarm[3] := stSlot;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.VLV_CFG_ALARM, Actual := fbVlv.stSts.stCommon.wCfgErr,
                  Message := 'alarm priority');

coUnit.TEST_FINISHED();
