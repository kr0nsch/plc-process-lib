coUnit.TEST('AnalogInput_ChannelFault_SetsFailure');

fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0: 50
fbTime.Advance(tStep := T#100MS);
// t1 = t0 + 0,1 с: отказ канала
fbAi(itfTime := fbTime, rIn := 12.0, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);
FOR iStep := 1 TO 19 DO   // t1 + 1,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 12.0, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.stSts.eSignal = E_AiSignalState.ChannelFault, Message := 'ChannelFault');
AssertFalse(Condition := fbAi.Fault, Message := 'no failure before tFailDelay');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, xChannelFault := TRUE, stCmd := stCmd, stCfg := stCfg);   // t1 + 2,0 с
AssertTrue(Condition := fbAi.Fault, Message := 'failure after tFailDelay');
AssertEquals_WORD(Expected := GVL_Const.AI_FLT_CHANNEL, Actual := fbAi.stSts.stCommon.wFault, Message := 'CHANNEL bit');
AssertEquals_REAL(Expected := 50.0, Actual := fbAi.rValue_eu, Delta := 1.0E-4, Message := 'value held');
fbTime.Advance(tStep := T#100MS);
fbAi(itfTime := fbTime, rIn := 12.0, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);   // tc: отказ канала снят
FOR iStep := 1 TO 19 DO   // tc + 1,9 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 12.0, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Fault, Message := 'failure kept during return confirmation');
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wFault,
                  Message := 'fault bit by current classification');
FOR iStep := 1 TO 1 DO   // tc + 2,0 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 12.0, xChannelFault := FALSE, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertFalse(Condition := fbAi.Fault, Message := 'failure cleared');

coUnit.TEST_FINISHED();
