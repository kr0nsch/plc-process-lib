coUnit.TEST('Motor_MaintIntervalReached_MaintenanceRequired');

stCfg.udiMaintInterval_h := 1;
stCfg.udiMaintStarts := 2;
stRetain.udiOpTimeMaint_s := 3590;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1S);
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 9, tDt := T#1S);
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wWarning, Message := 'no warning at 3599 s');
AssertTrue(Condition := fbMot.Status = E_Ne107Status.Good, Message := 'Good at 3599 s');
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1S);
AssertEquals_UDINT(Expected := 3600, Actual := stRetain.udiOpTimeMaint_s, Message := '3600 s since maintenance');
AssertEquals_WORD(Expected := GVL_Const.MOT_WRN_MAINT_RUNTIME, Actual := fbMot.stSts.stCommon.wWarning,
                  Message := 'MAINT_RUNTIME');
AssertTrue(Condition := fbMot.Status = E_Ne107Status.MaintenanceRequired, Message := 'MaintenanceRequired');
AssertTrue(Condition := (fbMot.stSts.stCommon.wStatus AND GVL_Const.DEV_STS_WARNING) <> 0,
           Message := 'common WARNING bit');
stCmd.xStop := TRUE;
fbMot.xFbRun := FALSE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
stCmd.xStart := TRUE;
fbMot.xFbRun := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#1S);
AssertTrue(Condition := (fbMot.stSts.stCommon.wWarning AND GVL_Const.MOT_WRN_MAINT_STARTS) <> 0,
           Message := 'MAINT_STARTS');
stCmd.xResetMaint := TRUE;
Spin(fbM := fbMot, fbT := fbTime, stC := stCmd, stR := stRetain, stF := stCfg, uiN := 1, tDt := T#0S);
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpTimeMaint_s, Message := 'run time since maintenance reset');
AssertEquals_UDINT(Expected := 0, Actual := stRetain.udiOpCountMaint, Message := 'starts since maintenance reset');
AssertEquals_WORD(Expected := 0, Actual := fbMot.stSts.stCommon.wWarning, Message := 'warnings cleared');
AssertTrue(Condition := fbMot.stSts.stCommon.eCmdResult = E_CmdResult.Accepted,
           Message := 'reset maintenance accepted');
AssertFalse(Condition := stCmd.xResetMaint, Message := 'pulse cleared');

coUnit.TEST_FINISHED();
