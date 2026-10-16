coUnit.TEST('Valve_MaintCyclesReached_MaintenanceRequired');

stCfg.udiMaintCycles := 2;
stRetain.udiOpCountMaint := 1;
stRetain.udiOpCount := 41;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertTrue(Condition := fbVlv.Status = E_Ne107Status.Good, Message := 'Good before the interval');
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv.xZsc := FALSE;
    fbVlv.xZso := iStep >= 10;
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_UDINT(Expected := 42, Actual := stRetain.udiOpCount, Message := 'total 42');
AssertEquals_UDINT(Expected := 2, Actual := stRetain.udiOpCountMaint, Message := 'since maintenance 2');
AssertEquals_WORD(Expected := GVL_Const.VLV_WRN_MAINT_CYCLES,
                  Actual := fbVlv.stSts.stCommon.wWarning AND GVL_Const.VLV_WRN_MAINT_CYCLES,
Message := 'MAINT_CYCLES');
AssertTrue(Condition := fbVlv.Status = E_Ne107Status.MaintenanceRequired, Message := 'NE 107 MaintenanceRequired');
AssertEquals_WORD(Expected := GVL_Const.DEV_STS_WARNING,
                  Actual := fbVlv.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_WARNING, Message := 'WARNING bit');
stCmd.xResetMaint := TRUE;
fbTime.Advance(tStep := T#100MS);
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpCountMaint, Message := 'reset');
AssertTrue(Condition := fbVlv.Status = E_Ne107Status.Good, Message := 'Good after maintenance reset');
AssertEquals_UDINT(Expected := 42, Actual := stRetain.udiOpCount, Message := 'total kept');

coUnit.TEST_FINISHED();
