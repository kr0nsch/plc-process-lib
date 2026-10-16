coUnit.TEST('Valve_PlcRestart_StateFromLimits');

stCfgNone.xZsoUsed := FALSE;
stCfgNone.xZscUsed := FALSE;
fbOpen(xZso := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbBoth(xZso := TRUE, xZsc := TRUE, itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbMid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbNone(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfgNone);
AssertTrue(Condition := fbOpen.stSts.eState = E_ValveState.Open, Message := 'ZSO: Open');
AssertTrue(Condition := fbOpen.xOpened, Message := 'ZSO: xOpened');
AssertFalse(Condition := fbOpen.xQOpen OR fbOpen.xQClose, Message := 'ZSO: no output in Manual');
AssertTrue(Condition := fbBoth.stSts.eState = E_ValveState.Fault, Message := 'both: Fault on first call');
AssertEquals_WORD(Expected := GVL_Const.VLV_FLT_BOTH_LIMITS, Actual := fbBoth.stSts.stCommon.wFault,
                  Message := 'both: BothLimits');
AssertTrue(Condition := fbMid.stSts.eState = E_ValveState.Intermediate, Message := 'none active: Intermediate');
AssertTrue(Condition := fbNone.stSts.eState = E_ValveState.Unknown, Message := 'no limit switches: Unknown');
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpCount, Message := 'restart is not a cycle');

coUnit.TEST_FINISHED();
