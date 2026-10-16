coUnit.TEST('Valve_SolenoidEtc_FaultDeenergizesCoil');

stCfg.eType := E_ValveType.SolenoidEtc;
fbVlv.xZso := TRUE;
// без тока: открыт
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Open, Message := 'normally open valve is Open');
AssertFalse(Condition := fbVlv.xQCoil, Message := 'coil off when open');
stCmd.xClose := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.xQCoil, Message := 'coil on to close');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closing, Message := 'Closing');
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZso := FALSE;
    fbVlv.xZsc := iStep >= 10;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Closed, Message := 'Closed on ZSC');
AssertTrue(Condition := fbVlv.xQCoil, Message := 'coil holds the valve closed');
fbVlv.xExtFault := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQCoil, Message := 'fault: coil de-energized (spring position)');
AssertTrue(Condition := fbVlv.stSts.eState = E_ValveState.Fault, Message := 'Fault');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_EXT_FAULT, Actual := fbVlv.stSts.stCommon.wFault,
                  Message := 'wFault ExtFault');
AssertFalse(Condition := fbVlv.xQOpen OR fbVlv.xQClose, Message := 'no motor outputs for a solenoid valve');
fbVlv.xExtFault := FALSE;
fbVlv.xZsc := FALSE;
fbVlv.xZso := TRUE;
fbTime.Advance(tStep := T#100MS);
// пружина открыла клапан
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := fbVlv.xQCoil, Message := 'coil stays off until Reset');
AssertTrue(Condition := fbVlv.xOpened, Message := 'spring opened the valve');

coUnit.TEST_FINISHED();
