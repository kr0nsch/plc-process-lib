coUnit.TEST('LevelLoop_AiPidVfd_TracksBumplessNoWindup');

stAiCfg.rRangeHi_eu := 10.0;
stPidCfg.eAction := E_PidAction.Direct;
stPidCfg.xUseOutAct := TRUE;
stPidCfg.rKp := 2.0;
stPidCfg.rTi_s := 20.0;
stPidCfg.rPvMax_eu := 10.0;
stPidCfg.rSpMax_eu := 10.0;
stPidRet.eRemoteMode := E_DeviceMode.Auto;
stPidCmd.rSp_eu := 5.0;
stVfdCfg.stVfd.rSpeedMin_pct := 30.0;
stVfdRet.eRemoteMode := E_DeviceMode.Auto;
// (1) насос стоит; 11,68 мА = 4,8 м
LevelLoopStep(fbT := fbTime, fbAi := fbAi, stAiCmd := stAiCmd, stAiCfg := stAiCfg, fbPid := fbPid,
              stPidCmd := stPidCmd, stPidRet := stPidRet, stPidCfg := stPidCfg, fbVfd := fbVfd,
              stVfdCmd := stVfdCmd, stVfdRet := stVfdRet, stVfdCfg := stVfdCfg, rLevel_mA := 11.68,
              uiN := 1, tDt := T#0S);
LevelLoopStep(fbT := fbTime, fbAi := fbAi, stAiCmd := stAiCmd, stAiCfg := stAiCfg, fbPid := fbPid,
              stPidCmd := stPidCmd, stPidRet := stPidRet, stPidCfg := stPidCfg, fbVfd := fbVfd,
              stVfdCmd := stVfdCmd, stVfdRet := stVfdRet, stVfdCfg := stVfdCfg, rLevel_mA := 11.68,
              uiN := 10, tDt := T#100MS);
AssertTrue(Condition := (fbPid.stSts.stCommon.wStatus AND GVL_Const.PID_STS_TRACKING) <> 0,
           Message := 'pump stopped: PID tracks');
AssertEquals_REAL(Expected := 0.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4, Message := 'PID output = reference 0');
AssertFalse(Condition := fbPid.Available, Message := 'PID not available while tracking');
// (2) пуск
fbVfd.xAutoRun := TRUE;
LevelLoopStep(fbT := fbTime, fbAi := fbAi, stAiCmd := stAiCmd, stAiCfg := stAiCfg, fbPid := fbPid,
              stPidCmd := stPidCmd, stPidRet := stPidRet, stPidCfg := stPidCfg, fbVfd := fbVfd,
              stVfdCmd := stVfdCmd, stVfdRet := stVfdRet, stVfdCfg := stVfdCfg, rLevel_mA := 11.68,
              uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Starting, Message := 'precondition: pump starting');
AssertEquals_REAL(Expected := 30.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4,
                  Message := 'reference preset to min');
LevelLoopStep(fbT := fbTime, fbAi := fbAi, stAiCmd := stAiCmd, stAiCfg := stAiCfg, fbPid := fbPid,
              stPidCmd := stPidCmd, stPidRet := stPidRet, stPidCfg := stPidCfg, fbVfd := fbVfd,
              stVfdCmd := stVfdCmd, stVfdRet := stVfdRet, stVfdCfg := stVfdCfg, rLevel_mA := 11.68,
              uiN := 1, tDt := T#100MS);
AssertTrue(Condition := fbVfd.stSts.eState = E_MotorState.Running, Message := 'precondition: pump running');
AssertTrue(Condition := (fbPid.stSts.stCommon.wStatus AND GVL_Const.PID_STS_TRACKING) <> 0,
           Message := 'PID still tracks while starting');
AssertEquals_REAL(Expected := 30.0, Actual := fbPid.rOut_pct, Delta := 1.0E-4,
                  Message := 'PID output tracks the preset');
LevelLoopStep(fbT := fbTime, fbAi := fbAi, stAiCmd := stAiCmd, stAiCfg := stAiCfg, fbPid := fbPid,
              stPidCmd := stPidCmd, stPidRet := stPidRet, stPidCfg := stPidCfg, fbVfd := fbVfd,
              stVfdCmd := stVfdCmd, stVfdRet := stVfdRet, stVfdCfg := stVfdCfg, rLevel_mA := 11.68,
              uiN := 1, tDt := T#100MS);
AssertEquals_WORD(Expected := 0, Actual := fbPid.stSts.stCommon.wStatus AND GVL_Const.PID_STS_TRACKING,
                  Message := 'tracking released when the pump runs in Auto');
AssertEquals_REAL(Expected := 30.0, Actual := fbPid.rOut_pct, Delta := 1.0E-3, Message := 'no bump at release');
// (3) уровень ниже задания 10 мин
LevelLoopStep(fbT := fbTime, fbAi := fbAi, stAiCmd := stAiCmd, stAiCfg := stAiCfg, fbPid := fbPid,
              stPidCmd := stPidCmd, stPidRet := stPidRet, stPidCfg := stPidCfg, fbVfd := fbVfd,
              stVfdCmd := stVfdCmd, stVfdRet := stVfdRet, stVfdCfg := stVfdCfg, rLevel_mA := 11.68,
              uiN := 600, tDt := T#1S);
AssertEquals_REAL(Expected := 30.0, Actual := fbVfd.rSpeedRef_pct, Delta := 1.0E-4,
                  Message := 'reference held at min speed');
AssertEquals_REAL(Expected := 26.0, Actual := fbPid.rOut_pct, Delta := 0.05,
                  Message := 'back-calculation on rOutAct: 30 + P, not wound down');
// (4) уровень выше задания; 12,32 мА = 5,2 м
LevelLoopStep(fbT := fbTime, fbAi := fbAi, stAiCmd := stAiCmd, stAiCfg := stAiCfg, fbPid := fbPid,
              stPidCmd := stPidCmd, stPidRet := stPidRet, stPidCfg := stPidCfg, fbVfd := fbVfd,
              stVfdCmd := stVfdCmd, stVfdRet := stVfdRet, stVfdCfg := stVfdCfg, rLevel_mA := 12.32,
              uiN := 1, tDt := T#1S);
AssertEquals_REAL(Expected := 34.0, Actual := fbVfd.rSpeedRef_pct, Delta := 0.05,
                  Message := 'above min at once: no windup');

coUnit.TEST_FINISHED();
